// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract TestDelegateCall{
    uint public num;
    address public sender;
    uint public value;


    function setVars(uint _num) external payable{
        num=2*_num;
        sender=msg.sender;
        value=msg.value;

    }

}

contract Delegatecall{
   
    uint public num;
    address public sender;
    uint public value;


    function setVars(address _test, uint _num) external payable{

        _test.delegatecall(abi.encodeWithSignature("setVars(uint256)", _num));

        // (bool success, bytes memory data)=_test.delegatecall(
        //     abi.encodeWithSelect(TestDelegateCall.setVars.selector,_num));
        // require(success, "delegatecall failed");


    }

}

