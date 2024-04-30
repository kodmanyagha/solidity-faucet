// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "hardhat/console.sol";

contract StoreNamesV2 {
    address private owner;

    mapping(address => string[]) public names;

    event AddedNewName(address addr, string name);

    constructor() {
        console.log("StoreNamesV2 constructor invoked.");

        owner = msg.sender;
    }

    function addName(string memory _name) public {
        console.log("Adding new name (V2): ", _name);

        names[msg.sender].push(_name);

        emit AddedNewName(msg.sender, _name);
    }

    function getName(uint256 _index) public view returns (string memory) {
        console.log("Returning name (V2): ", msg.sender, _index);

        return names[msg.sender][_index];
    }

    receive() external payable {
        console.log(">>StoreNames receiving amount (V2): ", msg.value);
    }

    fallback() external payable {
        console.log("fallback function called (V2)");
        console.log("sender (V2):", msg.sender);
    }
}
