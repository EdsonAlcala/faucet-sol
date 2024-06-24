// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

contract Faucet {
    address public owner;
    address public operator;

    uint256 public ETH_AMOUNT = 1e17; // 0.1 Ether

    event FaucetDripped(address recipient);

    constructor(address _operator) payable {
        owner = msg.sender;
        operator = _operator;
    }

    function drip(address _recipient) external onlyOperator {
        // Drip Ether
        (bool sent,) = _recipient.call{value: ETH_AMOUNT}("");
        require(sent, "Failed dripping ETH");

        emit FaucetDripped(_recipient);
    }

    function withdraw() external onlyOwner {
        // Withdraw all Ether
        (bool sent,) = owner.call{value: address(this).balance}("");
        require(sent, "Failed withdrawing ETH");
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Caller is not the owner");
        _;
    }

    modifier onlyOperator() {
        require(msg.sender == operator, "Caller is not the operator");
        _;
    }
}
