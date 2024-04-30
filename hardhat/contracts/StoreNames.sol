// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "hardhat/console.sol";

contract StoreNames {
    address private owner;

    mapping(address => string[]) public names;

    event AddedNewName(address addr, string name);

    constructor() {
        owner = msg.sender;
    }

    function addName(string memory _name) public {
        console.log("Adding new name: ", _name);

        names[msg.sender].push(_name);

        emit AddedNewName(msg.sender, _name);
    }

    function getName(uint256 _index) public view returns (string memory) {
        console.log("Returning name", msg.sender, _index);

        return names[msg.sender][_index];
    }

    receive() external payable {
        console.log(">>StoreNames receiving amount:", msg.value);
    }

    fallback() external payable {
        console.log("fallback function called");
        console.log("sender:", msg.sender);
    }
}
