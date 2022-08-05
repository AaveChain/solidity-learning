// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

//MY token launch on  Testnet of Binance Smart Chain.....

interface IERC20 {

    function totalSupply() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
    function allowance(address owner, address spender) external view returns (uint256);

    function transfer(address recipient, uint256 amount) external returns (bool);
    function approve(address spender, uint256 amount) external returns (bool);
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
    function increaseAllowance(address spender,uint256 addedValue) external returns (bool);
    function decreaseAllowance(address spender,uint256 subtractedValue) external returns (bool);
    

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
}

library SafeMath {
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        return a + b;
    }
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        return a - b;
    }
    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        return a % b;
    }

}


contract Rider is IERC20 {

    string public constant name = "Rider";
    string public constant symbol = "RD";
    uint8 public constant decimals = 0;

    mapping(address => uint256) balances;

    mapping(address => mapping (address => uint256)) allowed;
    address public _owner;

    uint256 totalSupply_ = 100000;

    using SafeMath for uint256;
    


   constructor() {

    balances[msg.sender] = totalSupply_;
    _owner=msg.sender;
    }

    event burn(address _owner, uint _value);


    function totalSupply() public override view returns (uint256) {
    return totalSupply_;
    }

    function balanceOf(address tokenOwner) public override view returns (uint256) {
        return balances[tokenOwner];
    }

    function transfer(address receiver, uint256 numTokens) public override returns (bool) {
        require(numTokens <= balances[msg.sender]);
        balances[msg.sender] = balances[msg.sender].sub(numTokens);
        balances[receiver] = balances[receiver].add(numTokens);
        emit Transfer(msg.sender, receiver, numTokens);
        return true;
    }

    function approve(address delegate, uint256 numTokens) public override returns (bool) {
        allowed[msg.sender][delegate] = numTokens;
        emit Approval(msg.sender, delegate, numTokens);
        return true;
    }

    function allowance(address owner, address delegate) public override view returns (uint) {
        return allowed[owner][delegate];
    }

    function transferFrom(address owner, address buyer, uint256 numTokens) public override returns (bool) {
        require(numTokens <= balances[owner]);
        require(numTokens <= allowed[owner][msg.sender]);

        balances[owner] = balances[owner].sub(numTokens);
        allowed[owner][msg.sender] = allowed[owner][msg.sender].sub(numTokens);
        balances[buyer] = balances[buyer].add(numTokens);
        emit Transfer(owner, buyer, numTokens);
        return true;
    }
    function increaseAllowance(address spender, uint256 addedValue) public override returns (bool) {
        require(spender!= address(0));

        allowed[msg.sender][spender]=allowed[msg.sender][spender].add(addedValue);
        emit Approval(msg.sender, spender, allowed[msg.sender][spender]);
        return true;
    }
    function decreaseAllowance(address spender, uint256 subtractedValue) public override  returns (bool) {
        require(spender!= address(0));

        allowed[msg.sender][spender]=allowed[msg.sender][spender].sub(subtractedValue);
        emit Approval(msg.sender, spender, allowed[msg.sender][spender]);
        return true;
    }

    function _mintToken(uint _value) public returns(bool){
        require(msg.sender==_owner,"only admin has this acess");
        totalSupply_+=_value;
        balances[_owner]+=_value;
        return true;
    }
    function _burnToken(uint _value) public returns(bool){
        require(msg.sender==_owner,"only admin has this acess");
        totalSupply_-=_value;
        balances[_owner]-=_value;
        // balances[_owner] += _value - _value/20;
        emit burn(msg.sender, _value);
        // emit Transfer(msg.sender, _owner, _value);
        return true;
    }


}
