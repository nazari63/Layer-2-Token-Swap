// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

interface IERC20 {
    function transfer(address recipient, uint256 amount) external returns (bool);
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
}

contract L2TokenSwap {
    address public admin;

    event TokensSwapped(address indexed user, address tokenFrom, address tokenTo, uint256 amountFrom, uint256 amountTo);

    constructor() {
        admin = msg.sender;
    }

    function swapTokens(address tokenFrom, address tokenTo, uint256 amountFrom, uint256 amountTo) external {
        require(IERC20(tokenFrom).transferFrom(msg.sender, address(this), amountFrom), "Transfer failed");
        require(IERC20(tokenTo).transfer(msg.sender, amountTo), "Transfer failed");
        emit TokensSwapped(msg.sender, tokenFrom, tokenTo, amountFrom, amountTo);
    }
}