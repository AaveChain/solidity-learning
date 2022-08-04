// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract sendEther {

    // address payable public getter= payable(0xdD870fA1b7C4700F2BD7f44238821C26f7392148);


    receive() external payable {}

    function CheckBal() external view returns(uint){
        return address(this).balance;
    }

    function send( address payable getter) public payable{
        bool sent = getter.send(msg.value);
        require(sent, "tx is failed");

    }
    function transfer(address payable getter) public payable{
        getter.transfer(msg.value);
    }
    function call(address payable getter) public payable{
        (bool sent, )=getter.call{value:msg.value}("");
        require(sent, "tx is failed");
    }

}





