// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "hardhat/console.sol";

//import "./access-control/Auth.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Box is Ownable {
    uint256 private _value;
    string private _name;

    event ValueChanged(uint256 value);
    event NameUpdated(string name);

    constructor() Ownable(msg.sender) {}

    // The onlyOwner modifier restricts who can call the store function
    function store(uint256 value) public onlyOwner {
        _value = value;
        emit ValueChanged(value);
    }

    function retrieve() public view returns (uint256) {
        return _value;
    }

    function updateName(string memory name) public fooModifier("test") {
        console.log("updateName function invoked");

        _name = name;
        emit NameUpdated(name);
    }

    function getName() public view returns (string memory) {
        return _name;
    }

    modifier fooModifier(string memory bar) {
        console.log("fooModifier executed, bar: ", bar);
        _;
    }
}
