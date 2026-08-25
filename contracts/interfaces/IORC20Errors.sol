// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title IORC20Errors - Standard ORC-20 Custom Revert Errors
 * @notice Standard typed custom errors for gas-efficient reverts and programmatic handling.
 */
interface IORC20Errors {
    /**
     * @dev Indicates an error related to the balance of an `sender`.
     * @param sender The address lacking sufficient balance.
     * @param balance The current balance of the address.
     * @param needed The required balance to perform the transfer.
     */
    error ORC20InsufficientBalance(address sender, uint256 balance, uint256 needed);

    /**
     * @dev Indicates a failure with the `sender` address (e.g. `address(0)`).
     * @param sender The invalid sender address.
     */
    error ORC20InvalidSender(address sender);

    /**
     * @dev Indicates a failure with the `receiver` address (e.g. `address(0)`).
     * @param receiver The invalid receiver address.
     */
    error ORC20InvalidReceiver(address receiver);

    /**
     * @dev Indicates a failure with the `spender` allowance.
     * @param spender The address attempting to spend tokens.
     * @param allowance The current allowance approved.
     * @param needed The minimum allowance required.
     */
    error ORC20InsufficientAllowance(address spender, uint256 allowance, uint256 needed);

    /**
     * @dev Indicates a failure with the `approver` address (e.g. `address(0)`).
     * @param approver The invalid approver address.
     */
    error ORC20InvalidApprover(address approver);

    /**
     * @dev Indicates a failure with the `spender` address (e.g. `address(0)`).
     * @param spender The invalid spender address.
     */
    error ORC20InvalidSpender(address spender);
}
