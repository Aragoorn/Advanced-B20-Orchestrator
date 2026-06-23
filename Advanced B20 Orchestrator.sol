// SPDX-License-Identifier: MIT
pragma solidity 0.8.34;

interface IB20Factory {
    function deployAsset(string memory name, string memory symbol, uint8 decimals) external returns (address);
}

contract AdvancedBaseOrchestrator {
    address public owner;
    address public b20AssetAddress;
    
    event AssetDeployed(address indexed asset, string name);
    event InteractionLogged(address indexed user, string memo);

    constructor() {
        owner = msg.sender;
    }

    function initiateB20Asset(address factory, string memory name, string memory symbol) external {
        require(msg.sender == owner, "Only owner");
        b20AssetAddress = IB20Factory(factory).deployAsset(name, symbol, 18);
        emit AssetDeployed(b20AssetAddress, name);
    }

    function executeComplexTransfer(string memory memo) external {
        emit InteractionLogged(msg.sender, memo);
    }

    function burnTokens() external {
        require(b20AssetAddress != address(0), "No asset deployed");
        // Update state to remove the warning
        b20AssetAddress = address(0); 
    }
}