//SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;


interface IERC20 {
    function totalSupply() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
    function allowance(address owner, address spender) external view returns (uint256);


    function transfer(address recipient, uint256 amount) external returns (bool);
    function approve(address spender, uint256 amount) external returns (bool);
    function transferFrom(address spender, address recipient, uint256 amount) external returns (bool);

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);

}



contract ERCToken is IERC20 {
    using SafeMath for uint256;
    string public name;
    string public symbol;
    uint8 public decimals;
    uint256 public _totalSupply;
    
    mapping (address => uint256) _balances;
    mapping (address => mapping(address => uint256)) _allow;
     
   constructor() {
       name = "ERC-Token";
        symbol = "ERCTOKEN";
        decimals = 10;
        _totalSupply = 10**(decimals + 20);
        _balances[msg.sender] = _totalSupply;
    }

    function totalSupply() public override view returns (uint256 supply) {
        return _totalSupply;
    }

    function balanceOf(address _owner) public override view returns (uint256 balance) {
        return _balances[_owner];
    }

    function transfer(address _receiver, uint256 _numTokens) public override returns (bool) {
        require(_numTokens <= _balances[msg.sender]);
        _balances[msg.sender] = _balances[msg.sender].sub(_numTokens);
        _balances[_receiver] = _balances[_receiver].add(_numTokens);
        emit Transfer(msg.sender, _receiver, _numTokens);
        return true;
    }

    function approve(address _delegate, uint256 _numTokens) public override returns (bool) {
        _allow[msg.sender][_delegate] = _numTokens; 
        emit Approval(msg.sender, _delegate, _numTokens);
        return true;
    }
    
    function allowance(address _owner, address _delegate) public override view returns (uint) {
        return _allow[_owner][_delegate];    
    }
    
    function transferFrom(address _owner, address _buyer, uint256 _numTokens) public override returns (bool) {
        require(_numTokens <= _balances[_owner]);
        require(_numTokens <= _allow[_owner][msg.sender]); 
        
        _balances[_owner] = _balances[_owner].sub(_numTokens);
        _allow[_owner][msg.sender] = _allow[_owner][msg.sender].sub(_numTokens);
        _balances[_buyer] = _balances[_buyer].add(_numTokens);  
        emit Transfer(_owner, _buyer, _numTokens);
        return true;
    }
}


library SafeMath {
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        assert(c >= a);
        return c;
    }

    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        assert(b <= a);
        return a - b;
    }

}