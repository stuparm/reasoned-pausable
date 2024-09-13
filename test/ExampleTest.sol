// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";
import {Example} from "./Example.sol";
import {Pausable} from "../src/Pausable.sol";

contract ExampleTest is Test {
    Example example;

    function setUp() public {
        example = new Example();
    }

    function testRegular() public {
        example.incrementValue();
        uint256 value = example.getValue();
        assert(value == 1);
    }

    function testIncrementPause() public {
        example.pause("contract is paused");
        vm.expectRevert(abi.encodeWithSelector(Pausable.EnforcedPause.selector, "contract is paused"));
        example.incrementValue();
    }

    function testGetValuePause() public {
        example.pause("contract is paused");
        vm.expectRevert(abi.encodeWithSelector(Pausable.EnforcedPause.selector, "contract is paused"));
        example.getValue();
    }
}
