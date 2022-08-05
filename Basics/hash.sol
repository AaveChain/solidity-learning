// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

// contract HashFunc{

//     function hash1Keccak256(uint _x, string memory name, address _addr) public pure returns(bytes32){
//         return keccak256(abi.encodePacked(_x,name,_addr));

//     }
//     function hash2Keccak256(uint _x, string memory name, address _addr) public pure returns(bytes32){
//         return keccak256(abi.encode(_x,name,_addr));

//     }
//     function hashSHA256(uint _x, string memory name, address _addr) public pure returns(bytes32){
//         return sha256(abi.encodePacked(_x,name,_addr));
//     }
//     function hashRipmed160(uint _x, string memory name, address _addr) public pure returns(bytes20){
//         return ripemd160(abi.encodePacked(_x,name,_addr));
//     }

// }  

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
    
    
    function collision(string memory text0, uint x, string memory text1) external pure returns (bytes32){
        // encodePacked(AAA, BBB) -> AAABBB
        // encodePacked(AA, ABBB) -> AAABBB
        return keccak256(abi.encodePacked(text0, x, text1));
    }

}
