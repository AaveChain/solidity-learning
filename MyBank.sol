// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract MyBank{  ///deposit and withdraw foem owner address (account).......

    address public owner;

    mapping(address => uint256) _balances;

    event LogDepositeMade(address accountHolder, uint amount);

    constructor(){
        owner= msg.sender;
        emit LogDepositeMade(msg.sender, 1000);
    }

    function deposit() public payable returns(uint){
        require((_balances[msg.sender] +msg.value)> _balances[msg.sender] && msg.sender!=address(0));
        _balances[msg.sender] += msg.value;
        emit LogDepositeMade(msg.sender, msg.value);
        return _balances[msg.sender];

    }
    function withdraw(uint withdrawAmount) public returns(uint){
        require(_balances[msg.sender] >= withdrawAmount);
        require(msg.sender!=address(0));
        require(_balances[msg.sender] >0);
        _balances[msg.sender]-= withdrawAmount;
        payable (msg.sender).transfer(withdrawAmount);
        emit LogDepositeMade(msg.sender,withdrawAmount);
        return _balances[msg.sender];
    }
    function viewBalance() public view returns(uint){
        return _balances[msg.sender];
          
    }


}