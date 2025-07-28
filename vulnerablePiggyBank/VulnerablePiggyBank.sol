// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract VulnerablePiggyBank {

    address public owner;

    constructor() { owner = msg.sender; }

    function deposit() public payable {}

    //No access control: Anyone can call withdraw() and drain the balance, not just the owner.
    function withdraw() public { 
        //Added require(msg.sender == owner) to restrict withdraw() access.
        require(msg.sender == owner, "Only owner can withdraw");
        payable(msg.sender).transfer(address(this).balance); 
    }

    // Simulated attack: contract withdraws all funds to itself
    function attack() public {
        withdraw(); // Steals the balance by calling the unprotected withdraw, now not working anymore
     }
}
