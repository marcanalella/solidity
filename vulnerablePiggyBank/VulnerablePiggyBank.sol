// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract VulnerablePiggyBank {

    address public owner;

    constructor() { owner = msg.sender; }

    //Restricting deposits to the owner makes sense becouse the contract is used as a personal or private vault.
    //We want to avoid accidental or malicious deposits from third parties.
    function deposit() public payable {
        require(msg.sender == owner, "Only owner can deposit");
        require(msg.value > 0, "Cannot deposit 0 ETH");
    }

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
