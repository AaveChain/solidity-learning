// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract Payable {

    address payable public owner;

    constructor() payable {
        owner=payable(msg.sender);
        
    }
    function depositETH() external payable {}

    function CheckBal() external view returns(uint){
        return address(this).balance;
    }
    function transfer(address payable _to, uint _amount) external payable {
       (bool success, ) = _to.call{value: _amount}("");
        require(success, "Failed to send Ether");
    }

}