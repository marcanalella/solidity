// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

abstract contract VaultBase {

    mapping(address => uint) internal balances;

    event Deposited(address indexed user, uint amount);

    event Withdrawn(address indexed user, uint amount);

    function getBalance(address user) external view returns (uint) {
        return balances[user];
    }
}