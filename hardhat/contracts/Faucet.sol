// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import "hardhat/console.sol";

contract Faucet {
    /* Storage variables will be here. There we will keep some state, some data
    that can be persisted over the time. I will create here just two simple
    variables for keeping some numbers. */

    /* So uint that accessor will be public. This will be publicly accessible and
    I need to tell you first that the everything on the blockchain is publicly
    accessible. Even though I could write here a private, this would be anyway
    still accessibly accessible on the blockchain because everything is open
    on the blockchain, so everything is basically public. This private and public
    has some meaning in the terms of smart contract, but I will get into this later. */

    // uint is abbreviation of uint256
    // This can store only positive numbers.
    uint public funds = 1_000;

    // This can store positive and negative numbers.
    int public counter = -10;

    // uint32 can contain maximum 2^32-1 value.
    //uint32 public test = 4_294_967_295;

    address payable public owner;

    string[] public arrayValue;

    mapping(address => string[]) public addressNames;

    address[] public funders;

    /* Create custom event with name and parameters. This is a mechanism
    for the clients catch it. These clients can be a user interface,
    backend app, or event another smart contract. These clients listens
    events and react to them. */
    event NewNameAdded(address addr, string name);

    constructor() payable {
        owner = payable(msg.sender);
    }

    receive() external payable {
        console.log(">> Sender: ", msg.sender);
        console.log(">> Value: ", msg.value);
    }

    /* I didn't understand this. payable modifier is specified for two methods.
    What happening on this situation? */
    function addFunds() external payable {
        funders.push(msg.sender);
    }

    /*
    `pure` and `view` modifiers (read-only call, no gas fee):
    view: it indicates that the function will not alter the storage state in any way.
    pure: even more strict, indicating that it won't even read the storage state.
    
    Remember the rule about pure functions: Their behavour coming from matematic,
    functions gives deterministic output for same input. Because of that
    we don't even read from state because state is changeable source.
    When we write pure functions the expected result is never an error.
    */
    function calculateSomething() external pure returns (uint) {
        return 2 + 2;
    }

    function getSomethingFromState() external view returns (uint) {
        return funds;
    }

    function addName(string memory name) public {
        console.log("New name: %0", name);

        addressNames[msg.sender].push(name);
        emit NewNameAdded(msg.sender, name);
    }

    function getName(uint256 index) public view returns (string memory) {
        for (uint i = 0; i < addressNames[msg.sender].length; i++) {
            if (i == index) {
                return addressNames[msg.sender][index];
            }
        }

        return "";
    }
}
