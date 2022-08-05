// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract AccessControl {

    address private owner;
    uint public price;
    bool public sellerPaysClosingFees;
    
    constructor(uint _price){
        owner  = msg.sender;
        price = _price;
        sellerPaysClosingFees = false;

    }

    modifier onlyOwner(){
        require(owner  == msg.sender, "only owner can update agreement terms");
        _;
    }
    function setPrice(uint _price) public onlyOwner{
        // require(owner  == msg.sender, "only owner can update agreement terms");
        price = _price;
        
    }
    function setClosingFeeAgreement(bool _ownerPays) public onlyOwner{
        sellerPaysClosingFees = _ownerPays;
    }
    
}

// contract AccessControl {

//     event GrantRole(bytes32 indexed role, address indexed account);
//     event RevokeRole(bytes32 indexed role, address indexed account);

//     mapping (bytes32 => mapping(address => bool)) public roles;

//     //0xdf8b4c520ffe197c5343c6f5aec59570151ef9a492f2c624fd45ddde6135ec42
//     bytes32 private constant ADMIN = keccak256(abi.encodePacked("ADMIN"));
//     //0x2db9fd3d099848027c2383d0a083396f6c41510d7acfd92adc99b6cffcf31e96
//     bytes32 private constant USER = keccak256(abi.encodePacked("USER"));

//     modifier onlyRole(bytes32 _role){
//         require(roles[_role][msg.sender], "not authorized");
//         _;
//     }
    
//     constructor(){
//         _grantRole(ADMIN, msg.sender);
//     }
//     function _grantRole(bytes32 _role, address _account) internal {
//         roles[_role][_account]= true;
//         emit GrantRole(_role, _account);
//     }
//     function grantRole(bytes32 _role, address _account) external onlyRole(ADMIN) {
//         _grantRole(_role, _account);
//     }
//     function revokeRole(bytes32 _role, address _account) external onlyRole(ADMIN) {
//         roles[_role][_account]= false;
//         emit RevokeRole(_role, _account);
//     }
// }
// //0x5B38Da6a701c568545dCfcB03FcB875f56beddC4  