// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Hack {
    constructor(MagicNum target) {
        address c;
        // returns bytecode of our contract
        // Totalos is 19 bytes
        // 10 bytes returned will be our contract
        bytes memory bytecode = hex"69602a60005260206000f3600052600a6016f3";
        assembly {
            // create contract address
            // 1. value  0
            // 2. byte offset (pointer in memory) 0x20
            // 3. length of our bytecode = 19 or 0x13
            c := create(0, add(bytecode, 0x20), 0x13)
        }
        assert(c != address(0));

        // set out solver contract address on contract
        target.setSolver(c);
    }
}

contract MagicNum {
    address public solver;

    constructor() {}

    function setSolver(address _solver) public {
        solver = _solver;
    }
}
