// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.19;

import {Script} from "forge-std/Script.sol";
import {Vm} from "forge-std/Vm.sol";
import {console2} from "forge-std/console2.sol";

import {DeploymentUtils} from "../src/utils/DeploymentUtils.sol";
import {DeployerUtils} from "../src/utils/DeployerUtils.sol";

import {Faucet} from "../src/Faucet.sol";

contract FaucetScript is Script {
    using DeployerUtils for Vm;
    using DeploymentUtils for Vm;

    address internal deployer;
    uint64 internal SEPOLIA_NETWORK_ID = 11155111;
    uint64 internal INITIAL_ETH_AMOUNT = 1 ether;
    address internal OPERATOR_ADDRESS = 0x219d8795Edbc4c6924B5d3C3CD92882516a45A2F;

    function run() public {
        console2.log("Deploying Faucet contract");
        deployer = vm.loadDeployerAddress();

        console2.log("Deployer Address");
        console2.logAddress(deployer);

        vm.startBroadcast(deployer);

        Faucet faucet = new Faucet{value: INITIAL_ETH_AMOUNT}(OPERATOR_ADDRESS);

        console2.log("Faucet Address");
        console2.logAddress(address(faucet));

        vm.saveDeploymentAddress("Faucet", address(faucet));
    }
}
