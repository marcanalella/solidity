// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

//import "dummy-contract/SimpleStorage.sol"; not use this but named imports
import {SimpleStorage} from "dummy-contract/SimpleStorage.sol"; //not use this but named imports

contract StorageFactory {
    SimpleStorage public simpleStorage;

    function createSimpleStorageContract() public {
        simpleStorage = new SimpleStorage(); //deploy a new contract and override the existing contract
    }
}