// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";


contract FundMe {

    uint256 public minimumUsd = 5e18;

    uint256 public minimumEur = 4e18;

    uint256 public lastPriceEUR;

    uint256 public lastPriceUSD;

    uint256 public lastPriceEUROffChain;

    uint256 public lastPriceUSDOffChain;

    AggregatorV3Interface internal ethUsdDataFeed;

    AggregatorV3Interface internal eurUsdDataFeed;

    address[] public funders;
    mapping(address funder => uint256 amountFunded) public addressToAmountFunded;

    constructor() {
        ethUsdDataFeed = AggregatorV3Interface(
            0x694AA1769357215DE4FAC081bf1f309aDC325306
        );

        eurUsdDataFeed = AggregatorV3Interface(
            0x1a81afB8146aeFfCFc5E50e8479e826E7D55b910
        );
    }

    //payable make possible to take fund to the contract like a wallet
    function fund(string memory currency) public payable {
       
        require(getSupportedCurrency(currency), "Currency not supported, you have wasted your money in gas");

        
        require(isFundable(msg.value, currency), "Didn't send enought ETH");
        //1e18 = 1 ETH = 10000000000000000000 Wei
        // https://eth-converter.com/
        //What is a revert?
        // Undo any actions that have been done, and send the remaining gas back
        //A failed transaction spend gas becaouse computer executed task.
        // if a transaction reverts, it undoes anything it does previously and
        //you can consider the transaction failed.
        //if you send a reverted transaction, you will spend gas.

        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = addressToAmountFunded[msg.sender] + msg.value;
    
    }

    function getEthUsdPrice() public returns(uint256) {
        (, int256 price,,,) = ethUsdDataFeed.latestRoundData();
        lastPriceUSDOffChain = uint256(price);
        return uint256(price) * 1e10;
    }

        function getEurUsdPrice() public returns(uint256) {
    
        (, int256 price,,,) = eurUsdDataFeed.latestRoundData();
        lastPriceEUROffChain = uint256(price);
        return uint256(price) * 1e10;
    }

    function getConversionRate(uint256 ethAmount) public returns(uint256) {
        uint256 ethPrice = getEthUsdPrice();
        return (ethPrice * ethAmount) / 1e18;
    } 

    function getSupportedCurrency(string memory currency) internal pure returns(bool) {
        return (compareStrings(currency, "EUR") || compareStrings(currency, "USD"));
    }

    function isFundable(uint256 ethAmount, string memory currency) internal returns(bool) {
        if(compareStrings(currency, "EUR")) {

            lastPriceEUR = (getConversionRate(ethAmount) / getEurUsdPrice());
            return lastPriceEUR >= minimumEur;
        } else {
            lastPriceUSD = getConversionRate(ethAmount);
            return lastPriceUSD >= minimumUsd;
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

    function compareStrings(string memory a, string memory b) public pure returns (bool) {
        return (keccak256(abi.encodePacked((a))) == keccak256(abi.encodePacked((b))));
    }
}