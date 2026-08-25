// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title IORC20 - Ozone Fungible Token Standard Interface
 * @notice Canonical interface for fungible tokens on Ozone Chain.
 * @dev 100% ABI and function-selector compatible with canonical ERC-20.
 */
interface IORC20 {
    /**
     * @dev Emitted when `value` tokens are moved from one account (`from`) to another (`to`).
     * Note that `value` may be zero.
     */
    event Transfer(address indexed from, address indexed to, uint256 value);

    /**
     * @dev Emitted when the allowance of a `spender` for an `owner` is set by
     * a call to {approve}. `value` is the new allowance.
     */
    event Approval(address indexed owner, address indexed spender, uint256 value);

    /**
     * @notice Returns the total amount of tokens in existence.
     */
    function totalSupply() external view returns (uint256);

    /**
     * @notice Returns the amount of tokens owned by `account`.
     */
    function balanceOf(address account) external view returns (uint256);

    /**
     * @notice Moves `amount` tokens from the caller's account to `to`.
     * @param to The destination recipient address.
     * @param amount The quantity of tokens to transfer.
     * @return A boolean indicating whether the operation succeeded.
     */
    function transfer(address to, uint256 amount) external returns (bool);

    /**
     * @notice Returns the remaining number of tokens that `spender` will be
     * allowed to spend on behalf of `owner` through {transferFrom}.
     */
    function allowance(address owner, address spender) external view returns (uint256);

    /**
     * @notice Sets `amount` as the allowance of `spender` over the caller's tokens.
     * @param spender The authorized spender address.
     * @param amount The maximum allowance granted.
     * @return A boolean indicating whether the operation succeeded.
     */
    function approve(address spender, uint256 amount) external returns (bool);

    /**
     * @notice Moves `amount` tokens from `from` to `to` using the allowance mechanism.
     * `amount` is then deducted from the caller's allowance.
     * @param from The source address holding the tokens.
     * @param to The destination recipient address.
     * @param amount The quantity of tokens to transfer.
     * @return A boolean indicating whether the operation succeeded.
     */
    function transferFrom(address from, address to, uint256 amount) external returns (bool);
}
