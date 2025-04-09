
// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;
contract SimpleBank {

    mapping (address => uint) private balances;

    address public Owner;

    event LogDepositMade (address depositer ,uint amount);
    
    constructor() {
        Owner = msg.sender;
    }

    function deposit() public payable returns(uint) {  
        require((balances[msg.sender] + msg.value) >= balances[msg.sender]);
        balances[msg.sender] += msg.value; // Add to existing balance 
        emit LogDepositMade (msg.sender , msg.value);// send the event
        return balances[msg.sender];
    }

    function withdraw(uint withdrawAmount) public payable returns(uint) {
        require(withdrawAmount <= balances[msg.sender], "Insufficient Money!");
        balances[msg.sender] -= withdrawAmount;
        payable (msg.sender).transfer(withdrawAmount);
        return balances[msg.sender];
    }

    function balance() view public returns(uint) {
        return balances[msg.sender];
    }

}
