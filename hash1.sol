// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract HashFunc{

     function hash1Keccak256(uint _x, string memory name, address _addr) public pure returns(bytes32){
         return keccak256(abi.encodePacked(_x,name,_addr));

     }
     function hash2Keccak256(uint _x, string memory name, address _addr) public pure returns(bytes32){
         return keccak256(abi.encode(_x,name,_addr));

     }
     function hashSHA256(uint _x, string memory name, address _addr) public pure returns(bytes32){
         return sha256(abi.encodePacked(_x,name,_addr));
     }
     function hashRipmed160(uint _x, string memory name, address _addr) public pure returns(bytes20){
         return ripemd160(abi.encodePacked(_x,name,_addr));
     }
 } 