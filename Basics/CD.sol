// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract AB {

    uint256 num1;
    address owner;
    constructor() public{
        owner = msg.sender;
    }

    function sendBal(address payable receiver) payable external {
        uint256 amount = msg.value;
        receiver.transfer(amount);  
    }
}