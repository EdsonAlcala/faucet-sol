// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

contract Faucet {
    address public owner;

    uint256 public ETH_AMOUNT = 1e17; // 0.1 Ether

    event FaucetDripped(address recipient);

    constructor() payable {
        owner = msg.sender;
    }

    function drip(address _recipient) external onlyOwner {
        // Drip Ether
        (bool sent,) = _recipient.call{value: ETH_AMOUNT}("");
        require(sent, "Failed dripping ETH");

        emit FaucetDripped(_recipient);
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Caller is not the owner");
        _;
    }
}
