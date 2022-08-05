
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "./IERC20.sol";
import "@openzeppelin/contracts/utils/math/Math.sol";

contract ERC20 is IERC20 {

    using Math for uint256;

    string public name = "Avineesh Kumar";
    string public symbol = "AKT";

    uint256 _totalSupply = 1000000;
    uint256 public basePercent = 100;
    mapping (address => uint256) private _balances;
    mapping(address => mapping(address => uint)) public allowance;
    

//     function transfer(address _to, uint256 _value) public returns (bool success){
//         require(balanceOf[msg.sender] >= _value,"Tokens transferred must be less or equal to account balance");
//     // Remove full balance of sender balance
//         balanceOf[msg.sender] -= _value;
//     // Add only 99.5 percent of transfer value to receiver balance
//         // balanceOf[_to] += _value - _value/20;
//         emit Transfer(msg.sender, _to, _value);
//         return true;
//   }
    function findOnePercent(uint256 value) public view returns (uint256)  {
        uint256 roundValue = value.ceil(basePercent);
        uint256 onePercent = roundValue.mul(basePercent).div(10000);
        return onePercent;
    }
    function balanceOf(address owner) public view returns (uint256) {
        return _balances[owner];
    }
    function transfer(address to, uint256 value) public returns (bool) {
        require(value <= _balances[msg.sender]);
        require(to != address(0));

        uint256 tokensToBurn = findOnePercent(value);
        uint256 tokensToTransfer = value.sub(tokensToBurn);

        _balances[msg.sender] = _balances[msg.sender].sub(value);
        _balances[to] = _balances[to].add(tokensToTransfer);

        _totalSupply = _totalSupply.sub(tokensToBurn);

        emit Transfer(msg.sender, to, tokensToTransfer);
        emit Transfer(msg.sender, address(0), tokensToBurn);
        return true;
  }


    // function mint(uint _value) external {
    //     balanceOf[msg.sender] += _value;
    //     _totalSupply += _value;
    //     emit Transfer(address(0), msg.sender, _value);
    // }
    // function burn(address _to,uint _value) public {
    //     balanceOf[_to] += _value - _value/20;
    //     emit Transfer(msg.sender,address(0), _value);
    //     // emit Transfer(msg.sender, address(0), _value);
    // }
}