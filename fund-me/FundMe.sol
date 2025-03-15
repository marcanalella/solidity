// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {PriceConverter} from "./PriceConverter.sol";

contract FundMe {

    using PriceConverter for uint256;

    uint256 public minimumUsd = 5e18;

    address[] public funders;
    
    mapping(address funder => uint256 amountFunded) public addressToAmountFunded;

    //payable make possible to take fund to the contract like a wallet
    function fund() public payable {
       
        //1e18 = 1 ETH = 10000000000000000000 Wei
        // https://eth-converter.com/
        //What is a revert?
        // Undo any actions that have been done, and send the remaining gas back
        //A failed transaction spend gas becaouse computer executed task.
        // if a transaction reverts, it undoes anything it does previously and
        //you can consider the transaction failed.
        //if you send a reverted transaction, you will spend gas.

        //msg.value is passed as firtst input parameter to the funciton getConversionRate()
        require(msg.value.getConversionRate() >= minimumUsd, "Didn't send enought ETH");
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = addressToAmountFunded[msg.sender] + msg.value;
    
    }
}
    
    //function withdraw() public {}

    //In Solidity, strings are essentially arrays of bytes (i.e., byte arrays). 
    //This means that direct comparison using equality operators won’t yield the desired result 
    //as it would compare the memory addresses rather than the actual string contents.
    //This method involves hashing the strings using a cryptographic hash function like SHA-256 and then 
    //comparing the resulting hash values. If the hashes match, the strings are considered equal.
    //This function compares two strings by hashing them using the keccak256 cryptographic hash function 
    //and checking if the hash values are equal, returning a boolean indicating the comparison result.

    //function compareStrings(string memory a, string memory b) public pure returns (bool) {
    //    return (keccak256(abi.encodePacked((a))) == keccak256(abi.encodePacked((b))));
    //}