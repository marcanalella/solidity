// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

contract DataConsumer {
    
    AggregatorV3Interface internal dataFeed;

    // BTC/USD FEED SEPOLIA ETH ADDRESS 
    constructor() {
        dataFeed = AggregatorV3Interface(0x1b44F3514812d835EB1BDB0acB33d3fA3351Ee43);
    }

    function getPriceData() public view returns (int) {
        (, int256 price,,,) = dataFeed.latestRoundData();
        return price;
    }

}


// tx https://sepolia.etherscan.io/tx/0xbb286e55e3e1218f249d9f473c643511f83279d2143b9a90f053b8f190666e3c
// contract https://sepolia.etherscan.io/address/0x25fe06a81ef82b54864b170c956fdbc55f3c1e82