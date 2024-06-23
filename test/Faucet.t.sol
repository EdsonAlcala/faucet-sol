// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.19;

import {Test, console} from "forge-std/Test.sol";
import {Faucet} from "../src/Faucet.sol";

contract FaucetTest is Test {
    Faucet public instance;

    address OWNER = vm.addr(0x01);
    address RECIPIENT = vm.addr(0x02);

    function setUp() public {
        vm.deal(OWNER, 100 ether);
        vm.prank(OWNER);
        instance = new Faucet{value: 10 ether}();
    }

    function test_owner() public view {
        assertEq(address(instance.owner()), OWNER);
    }

    function test_drip() public {
        vm.prank(OWNER);

        instance.drip(RECIPIENT);

        assertEq(address(RECIPIENT).balance, 1e17);
    }

    function test_when_caller_is_not_owner_reverts() public {
        vm.prank(RECIPIENT);

        vm.expectRevert("Caller is not the owner");

        instance.drip(RECIPIENT);
    }

    function test_when_drip_fails_reverts() public {
        vm.startPrank(OWNER);

        // redeploy the contract with insufficient balance
        instance = new Faucet();

        vm.expectRevert("Failed dripping ETH");

        instance.drip(RECIPIENT);

        vm.stopPrank();
    }
}
