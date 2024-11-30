// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

//import "dummy-contract/SimpleStorage.sol"; not use this but named imports
import {SimpleStorage} from "./SimpleStorage.sol"; //not use this but named imports

contract StorageFactory {
    SimpleStorage[] public simpleStorageList;
    //address[] public simpleStorageList;

    function createSimpleStorageContract() public {
        SimpleStorage simpleStorage = new SimpleStorage();
        simpleStorageList.push(simpleStorage);
    }

    function sfStore(uint256 _simpleStorageIndex, uint256 _newSimpleStorageNumber) public {
        //address
        //abi - application binary interface
        SimpleStorage mySimpleStorage = simpleStorageList[_simpleStorageIndex];
        mySimpleStorage.store(_newSimpleStorageNumber);

        //SimpleStorage(address)
        //SimpleStorage mySimpleStorage = SimpleStorage(simpleStorageList[_simpleStorageIndex]);
    }

    function sfGet(uint256 _simpleStorageIndex) public view returns (uint256) {
        SimpleStorage mySimpleStorage = simpleStorageList[_simpleStorageIndex];
        return mySimpleStorage.retrieve();
    }
}