// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract FundMe {

    uint256 public minimumUsd = 5;

    uint256 public minimumEur = 4;

    //payable make possible to take fund to the contract like a wallet
    function fund() public payable {
        // https://eth-converter.com/
        require(msg.value > 1e18, "didn't send enought ETH");//1e18 = 1 ETH = 10000000000000000000 Wei
        //What is a revert?
        // Undo any actions that have been done, and send the remaining gas back
        //A failed transaction spend gas becaouse computer executed task.
        // if a transaction reverts, it undoes anything it does previously and
        //you can consider the transaction failed.
        //if you send a reverted transaction, you will spend gas.
    
    }
    
    //function withdraw() public {}
}