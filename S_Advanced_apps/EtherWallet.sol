// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract ETHwallet{
    address payable public owner;

    constructor() {
        owner = payable(msg.sender);
    }

    receive() external payable{}

    function withdrwal(uint _amount) external {
        require(msg.sender == owner, "caller is not owner");
        payable(msg.sender).transfer(_amount);

        // (bool sent,)= msg.sender.call{value: _amount}("");
        // require(sent, "Failed to send ether");
    }

    function checkBal() external view returns(uint){
        return address(this).balance;
    }
}