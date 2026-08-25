// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {ORC20} from "../contracts/reference/ORC20.sol";

// Minimal Script interface for Foundry deployment without external dependency requirements
interface Vm {
    function startBroadcast(uint256 privateKey) external;
    function stopBroadcast() external;
    function envUint(string calldata) external returns (uint256);
    function envString(string calldata) external returns (string memory);
    function envOr(string calldata, string calldata) external returns (string memory);
}

/**
 * @title DeployORC20
 * @notice Foundry deployment script for the official ORC-20 Reference Token on Ozone Chain.
 * @dev Run with:
 * forge script script/DeployORC20.s.sol:DeployORC20 \
 *   --rpc-url $OZONE_RPC_URL \
 *   --broadcast \
 *   --verify
 */
contract DeployORC20 {
    Vm private constant vm = Vm(address(uint160(uint256(keccak256("hevm cheat code")))));

    event Deployed(address indexed contractAddress, string name, string symbol);

    function run() external returns (ORC20 token) {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        string memory tokenName = vm.envOr("TOKEN_NAME", "Ozone Reference Token");
        string memory tokenSymbol = vm.envOr("TOKEN_SYMBOL", "ORC");

        vm.startBroadcast(deployerPrivateKey);

        token = new ORC20(tokenName, tokenSymbol);

        vm.stopBroadcast();

        emit Deployed(address(token), tokenName, tokenSymbol);
    }
}
