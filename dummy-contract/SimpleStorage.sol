// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract SimpleStorage {
    //storage variable -> exists outside of fuction calls
    uint256 public favoriteNumber; //0

    struct Person {
        uint256 personalFavoriteNumber;
        string name;
    }

    Person[] public listOfPeople;

    mapping(string => uint256) public nameToFavoriteNumber;

    //virtual means that this fuction is overrideable
    function store(uint256 _favoriteNumber) public virtual {
        favoriteNumber = _favoriteNumber;
    }

    //view -> read state from blockchain, it disallows any 
    //modification of state.
    //pure -> it disallows any modification of state and even reading from
    //state or storage.
    //pure or view no need gas, but it spend gas only when called by
    //a fuction that change state.
    function retrieve() public view returns(uint256) {
        return favoriteNumber;
    }
    
    //calldata, memory -> it's only going to exist for the duration of
    //fuction call. The difference between them is that a memory variable can
    //be changed, can be manipulated.
    function addPerson(string memory _name, uint256 _favoriteNumber) public {
        listOfPeople.push(Person(_favoriteNumber, _name));
        nameToFavoriteNumber[_name] = _favoriteNumber;
    }
}
