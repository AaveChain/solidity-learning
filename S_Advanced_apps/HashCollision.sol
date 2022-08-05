// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;



contract HashFunction {


    function hash(string memory text, uint num,address addr) external pure returns (bytes32) {
        return keccak256(abi.encodePacked(text, num, addr));
    }
    function encode(string memory text0,string memory text1) external pure returns (bytes memory) {
        return abi.encode(text0, text1);
    }
    function encodePacked(string memory text0,string memory text1) external pure returns (bytes memory) {
        return abi.encodePacked(text0, text1);
    }


    function collisionExample1(string memory text0,string memory text1) external pure returns (bytes32){
        return keccak256(abi.encodePacked(text0,text1));
    }

   // remove collision if use abi.encode only
    function collisionExample2(string memory text0,string memory text1) external pure returns (bytes32){
        return keccak256(abi.encode(text0,text1));
    }
    
    
    function collision(string memory text0, uint x, string memory text1) external pure returns (bytes32){
        return keccak256(abi.encodePacked(text0, x, text1));
    }
    // encodePacked(AAA, BBB) -> AAABBB
        // encodePacked(AA, ABBB) -> AAABBB

}