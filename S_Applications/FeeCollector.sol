// SPDX-License-Identifier: MIT

pragma solidity ^0.8.13;

import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

contract FeeColletor{

    address public owner;
    uint public balance;

    event TransferReceived(address _from,uint _amount);
    event Transfersent(address _from, address _destAddr, uint _amount);

    constructor(){
        owner = msg.sender;
    }

    receive()  payable external {
        balance += msg.value;
        emit TransferReceived(msg.sender, msg.value);
    }
    function withdraw(uint amount, address payable destAddr) public {
        require(msg.sender ==owner, "Only owner can withdraw funds");
        require(amount <=balance, "insufficient funds");

        destAddr.transfer(amount);
        balance -= amount;
        emit Transfersent(msg.sender, destAddr,amount);

    }
    function transferERC20(IERC20 token, address to, uint amount) public {
        require(msg.sender ==owner, "Only owner can withdraw funds");
        uint erc20balance = token.balanceOf(address(this));
        require(amount <=erc20balance, "balance is low");
        token.transfer(to, amount);
        emit Transfersent(msg.sender, to ,amount);

    }

}