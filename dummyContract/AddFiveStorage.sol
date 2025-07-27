// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {SimpleStorage} from "./SimpleStorage.sol";

//inheritance and overriding in Solidity

contract AddFiveStorage is SimpleStorage {
    //it's not a view because we aren't reading from storage
    function sayHello() public pure returns (string memory) {
        return "Hello";
    }

    function store(uint256 _favoriteNumber) public override {
        favoriteNumber = _favoriteNumber + 5;
    }
}