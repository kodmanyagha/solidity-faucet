// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PayableSample {
    address payable public owner;

    constructor() payable {
        owner = payable(msg.sender);
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }

    function withdraw(uint _amount) public onlyOwner {
        uint amount = address(this).balance;
        // (bool success, ) = owner.call{value: amount}("");
        (bool success, bytes memory data) = owner.call{value: amount}("");
        require(success, "Failed to send Ether");

        owner.transfer(_amount);
    }
}
