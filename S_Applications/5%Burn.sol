// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

//MY token burn and mint simply....

interface IERC20 {

    // function totalSupply() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
    function allowance(address owner, address spender) external view returns (uint256);

    function transfer(address recipient, uint256 amount) external returns(bool);
    function approve(address spender, uint256 amount) external returns (bool);
    // function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
    // function increaseAllowance(address spender,uint256 addedValue) external returns (bool);
    // function decreaseAllowance(address spender,uint256 subtractedValue) external returns (bool);
    

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

    string private constant name = "Rider";
    string private constant symbol = "RD";
    uint8 private constant decimals = 0;

    address public _owner;

    uint256 private totalSupply_ = 100000;

    mapping(address => uint256) balances;
    mapping(address => mapping (address => uint256)) allowed;

    // event Transfer(address indexed from, address indexed to, uint value);
    // event Approval(address indexed owner, address indexed spender, uint value);

    using SafeMath for uint256;
    // event Burn(address indexed burner, uint256 value);
    event Burn(address _owner, uint _value);


    constructor() {
        balances[msg.sender] = totalSupply_;
        _owner=payable(msg.sender);
    }

    function balanceOf(address tokenOwner) public view returns (uint256) {
        return balances[tokenOwner];
    }
    function transfer(address to, uint value) public override returns(bool){
        require(balanceOf(msg.sender) >= value, "(balance too low)");
        balances[to] -= value;
        totalSupply_ -=  value * 5 / 100;
        value -=  value * 95 / 100;
        balances[to] += value;
        _burnToken(value);
        emit Transfer(msg.sender, to, value);
        return true;
    }
    
    
    function approve(address spender, uint value) public override returns(bool) {
        allowed[msg.sender][spender] = value;
        emit Approval(msg.sender, spender, value);
        return true;
    }
    function allowance(address owner, address delegate) public view returns (uint) {
        return allowed[owner][delegate];
    }

    // function transferFrom(address from, address to, uint value) public returns(bool) {
    //     require(balanceOf(from) >= value, "Saldo insuficiente (balance too low)");
    //     require(allowed[from][msg.sender] >= value, "allowance too low");
    //     balances[from] -= value;
    //     totalSupply_ -=  value * 5 / 100;
    //     value -=  value * 95 / 100;
    //     balances[to] += value;
    
    //     emit Transfer(from, to, value);
    //     return true;
    // }
    function _burnToken(uint value) public  returns(bool){
        require(msg.sender==_owner,"only admin has this acess");
        totalSupply_-=value;
        balances[_owner]-=value;
        // balances[_owner] += _value - _value/20;
        emit Burn(msg.sender, value);
        return true;
        
    }
    






}