// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract ExampleContract {
    string public name;

    // if you use calldata, it won't compile
    constructor(string memory _name) {
        name = _name;
    }
}