// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {IORC20} from "./IORC20.sol";

/**
 * @title IORC20Metadata - Ozone Fungible Token Metadata Interface
 * @notice Optional interface defining human-readable metadata for ORC-20 tokens.
 */
interface IORC20Metadata is IORC20 {
    /**
     * @notice Returns the name of the token.
     */
    function name() external view returns (string memory);

    /**
     * @notice Returns the ticker symbol of the token.
     */
    function symbol() external view returns (string memory);

    /**
     * @notice Returns the number of decimal places used to format balances.
     */
    function decimals() external view returns (uint8);
}
