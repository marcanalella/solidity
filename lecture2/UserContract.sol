// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

/*My solution to Week 1 Lecture 2 - Solidity Fundamentals 
This Solidity contract manages user registration, profile updates, and retrieval using a struct and 
mappings. It ensures each user registers with a unique, valid email and non-empty name. 
User data is stored in both a public array and a private mapping for quick access. 
Validation checks prevent duplicate emails and empty inputs. A helper function confirms b
asic email format by checking for the "@" character. Though efficient in logic, 
the contract retains a redundant users array solely for checking email uniqueness, 
which could be optimized using a mapping for better performance and gas efficiency.*/


contract UserContract {

    struct User {
        string name;
        string email;
        uint256 createdAt;
        uint256 updatedAt;
    }
    
    User[] public users;

    mapping(address => User) private addressToUser;

    function register(string memory name, string memory email) public {
        require(addressToUser[msg.sender].createdAt == 0, "Already registered");
        require(isValidString(name), "Name cannot be empty");
        require(isValidString(email), "Email cannot be empty");
        require(!isUsedEmail(email), "Email already used");
        require(isValidEmail(email), "Email not valid");
        
        User memory userToSave = User(name, email, block.timestamp, block.timestamp);
        users.push(userToSave);
        addressToUser[msg.sender] = userToSave;
    }
    
    function updateProfile(string memory name, string memory email) public {
        require(addressToUser[msg.sender].createdAt != 0, "Not registered");
        require(isValidString(name), "Name cannot be empty");
        require(isValidString(email), "Email cannot be empty");
        require(!isUsedEmail(email), "Email already used");
        require(isValidEmail(email), "Email not valid");

        addressToUser[msg.sender].name = name;
        addressToUser[msg.sender].email = email;
        addressToUser[msg.sender].updatedAt = block.timestamp;
            
    }
    
    function getProfile() public view returns(User memory) {
       return  addressToUser[msg.sender];
    }

    function isValidString(string memory stringToCheck) private pure returns(bool) {
        // Check if string is a empty string
        bytes memory tempEmptyStringTest = bytes(stringToCheck); 
        return tempEmptyStringTest.length != 0;
    }

    function compareStrings(string memory a, string memory b) private pure returns (bool) {
        return (keccak256(abi.encodePacked((a))) == keccak256(abi.encodePacked((b))));
    }
    
    function isUsedEmail(string memory email) private view returns (bool) {
        for(uint256 i = 0; i < users.length; i++) {
            if(compareStrings(users[i].email, email)) {
                return true;
            }
        }
        return false;
    }

    //simple check if email contains @
    function isValidEmail(string memory email) private pure returns (bool) {
        bytes memory emailBytes = bytes(email);
        for (uint i = 0; i < emailBytes.length; i++) {
            if (emailBytes[i] == "@") {
              return true;
            }
        }
        return false;
    }

}