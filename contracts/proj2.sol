// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract deploy {
    uint number;
    function store (uint _num) public {
        number = _num;
    }
    
    function getNumber() public view returns(uint){
        return number;
    }
}