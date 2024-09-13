// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import {Pausable} from "../src/Pausable.sol";

contract Example is Pausable {

    uint256 private s_value;

    constructor() {
        s_value = 0;
    }

    function pause(string memory reason) public {
        _pause(reason);
    }

    function unpause() public {
        _unpause();
    }

    function incrementValue() public whenNotPaused {
        s_value += 1;
    }

    function getValue() public view whenNotPaused returns (uint256) {
        return s_value;
    }

}