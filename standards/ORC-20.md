---
orc: 20
title: Ozone Fungible Token Standard
description: A standard interface and semantic specification for fungible tokens on Ozone Chain, maintaining 100% ABI and tooling compatibility with ERC-20.
author: Ozone Chain Core Architecture Team <standards@ozonechain.io>
status: Final
type: Standards Track
category: Token
created: 2026-08-24
requires: 1
---

# ORC-20: Ozone Fungible Token Standard

## Abstract

This standard defines the canonical API and operational semantics for fungible tokens on **Ozone Chain**. ORC-20 is 100% interface and ABI compatible with the Ethereum ERC-20 token standard, ensuring seamless interoperability with existing EVM wallets (e.g., MetaMask, Rabby), client libraries (ethers.js, viem, web3.js), decentralized exchanges (AMMs), block explorers, and smart contract developer frameworks.

---

## Motivation

Fungible tokens represent the lifeblood of decentralized finance, governance, gaming, and ecosystem asset transfer. Establishing a standardized, rigorous token framework on Ozone Chain provides:

1. **Ecosystem Interoperability**: Any wallet, DEX, lending market, or bridge can interact with any ORC-20 token predictably without custom adapters.
2. **Backwards Compatibility**: Existing ERC-20 tokens deployed on Ozone Chain qualify immediately as ORC-20 Compatible without requiring contract migration or redeployment.
3. **EVM Tooling Harmony**: Exact function signature and event parity ensures all standard development toolchains (Foundry, Hardhat, Remix, Wagmi, Viem) work out-of-the-box.
4. **Enhanced Developer Clarity**: Rigorous normative rules (RFC 2119) and standardized custom errors ensure robust edge-case handling and clear revert reasons.

---

## Specification

### 1. Mandatory Interface

An ORC-20 compliant contract **MUST** implement the following functions and events:

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

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
     * @notice Returns the total token supply in existence.
     */
    function totalSupply() external view returns (uint256);

    /**
     * @notice Returns the token balance of `account`.
     */
    function balanceOf(address account) external view returns (uint256);

    /**
     * @notice Moves `amount` tokens from the caller's account to `to`.
     * @dev MUST emit a {Transfer} event.
     * @return A boolean value indicating whether the operation succeeded.
     */
    function transfer(address to, uint256 amount) external returns (bool);

    /**
     * @notice Returns the remaining number of tokens that `spender` is allowed
     * to spend on behalf of `owner` through {transferFrom}.
     */
    function allowance(address owner, address spender) external view returns (uint256);

    /**
     * @notice Sets `amount` as the allowance of `spender` over the caller's tokens.
     * @dev MUST emit an {Approval} event.
     * @return A boolean value indicating whether the operation succeeded.
     */
    function approve(address spender, uint256 amount) external returns (bool);

    /**
     * @notice Moves `amount` tokens from `from` to `to` using the allowance mechanism.
     * `amount` is then deducted from the caller's allowance.
     * @dev MUST emit a {Transfer} event.
     * @return A boolean value indicating whether the operation succeeded.
     */
    function transferFrom(address from, address to, uint256 amount) external returns (bool);
}
```

---

### 2. Optional Metadata Extension

An ORC-20 contract **MAY** implement the metadata extension to provide human-readable information:

```solidity
interface IORC20Metadata is IORC20 {
    /**
     * @notice Returns the name of the token.
     */
    function name() external view returns (string memory);

    /**
     * @notice Returns the symbol of the token (usually in all caps, e.g., "OZO").
     */
    function symbol() external view returns (string memory);

    /**
     * @notice Returns the number of decimals used to get its user representation.
     * For example, if `decimals` equals `18`, a balance of `5050000000000000000`
     * tokens should be displayed to a user as `5.05`.
     */
    function decimals() external view returns (uint8);
}
```

---

### 3. Standard Custom Errors

To optimize gas and ensure standardized programmatic revert handling, conforming implementations **SHOULD** revert using the following typed errors:

```solidity
interface IORC20Errors {
    /// @dev Reverts when `sender` balance is lower than `needed`.
    error ORC20InsufficientBalance(address sender, uint256 balance, uint256 needed);

    /// @dev Reverts when transfer/burn is initiated from the zero address.
    error ORC20InvalidSender(address sender);

    /// @dev Reverts when transfer/mint is directed to the zero address.
    error ORC20InvalidReceiver(address receiver);

    /// @dev Reverts when `spender` allowance is lower than `needed`.
    error ORC20InsufficientAllowance(address spender, uint256 allowance, uint256 needed);

    /// @dev Reverts when approving from the zero address.
    error ORC20InvalidApprover(address approver);

    /// @dev Reverts when approving to the zero address.
    error ORC20InvalidSpender(address spender);
}
```

---

### 4. Normative Behavioral Semantics

1. **Zero-Value Transfers**: Calls to `transfer(to, 0)` or `transferFrom(from, to, 0)` **MUST** be treated as valid transfers, **MUST NOT** revert solely due to the zero value, and **MUST** emit a `Transfer` event with `value == 0`.
2. **Zero Address Guards**:
   - Transfers from the zero address (`address(0)`) **MUST** revert (unless part of a standardized internal mint operation).
   - Transfers to the zero address (`address(0)`) **MUST** revert (unless part of a standardized internal burn operation).
   - Approvals involving `address(0)` as owner or spender **MUST** revert.
3. **Infinite Allowance**: If the allowance is set to `type(uint256).max`, a conforming `transferFrom` implementation **SHOULD NOT** deduct the transferred amount from the allowance, mimicking standard OpenZeppelin / EVM infinite approval mechanics.
4. **State Transitions & Event Emission**:
   - Every state-changing transfer **MUST** emit `Transfer(from, to, value)`.
   - Every approval change **MUST** emit `Approval(owner, spender, value)`.
   - Minting **MUST** emit `Transfer(address(0), to, value)`.
   - Burning **MUST** emit `Transfer(from, address(0), value)`.

---

## Compatibility

### 1. Function Selector and ABI Equivalence

ORC-20 preserves identical 4-byte keccak-256 function selectors:

| Function Signature | Keccak-256 Hash | 4-Byte Selector | Status |
|:---|:---|:---|:---|
| `totalSupply()` | `0x18160ddd8f...` | `0x18160ddd` | Mandatory |
| `balanceOf(address)` | `0x70a08231b9...` | `0x70a08231` | Mandatory |
| `transfer(address,uint256)` | `0xa9059cbb2a...` | `0xa9059cbb` | Mandatory |
| `allowance(address,address)` | `0xdd62ed3e69...` | `0xdd62ed3e` | Mandatory |
| `approve(address,uint256)` | `0x095ea7b3ac...` | `0x095ea7b3` | Mandatory |
| `transferFrom(address,address,uint256)` | `0x23b872dd33...` | `0x23b872dd` | Mandatory |
| `name()` | `0x06fdde038e...` | `0x06fdde03` | Optional |
| `symbol()` | `0x95d89b41e2...` | `0x95d89b41` | Optional |
| `decimals()` | `0x313ce5672c...` | `0x313ce567` | Optional |

### 2. Tooling & Ecosystem Compatibility

- **Web3 Libraries**: 100% compatible with `ethers.js`, `viem`, `web3.js`, and `wagmi`. Any standard ERC-20 ABI JSON works unmodified.
- **Wallets**: MetaMask, Rabby, Coinbase Wallet, Rainbow, and Ledger can track balances, send tokens, and handle allowances without special configuration.
- **Decentralized Exchanges (DEXes)**: Automated market makers (Uniswap v2/v3 forks on Ozone Chain) interact seamlessly with ORC-20 contracts.
- **Block Explorers**: Ozone Chain block explorers automatically index and render `Transfer` and `Approval` events.

---

## Security Considerations

1. **Reentrancy**: Implementations **MUST** update internal balances before executing any external calls or hooks (Checks-Effects-Interactions pattern).
2. **Allowance Front-Running (Race Conditions)**: Standard `approve(spender, newAmount)` is vulnerable to the known ERC-20 approval race condition where a spender spends `oldAmount` before the `newAmount` transaction is mined. DApps should use `approve(spender, 0)` before setting a new amount, or implement atomic helper extensions (e.g. `increaseAllowance` / `decreaseAllowance` or `ORC-2612` permit).
3. **Fee-on-Transfer / Rebasing Incompatibilities**: Non-standard balance mechanics (e.g. deflationary transfer fees) can break standard DEX liquidity pools. Tokens with special mechanics **MUST** clearly document such behavior in their metadata.
4. **Integer Overflow / Underflow**: Solidity 0.8+ native checked arithmetic prevents arithmetic overflows. Custom assembly or unchecked blocks must be audited thoroughly.

---

## Gas Considerations

- Standard storage layouts (`mapping(address => uint256) private _balances` and `mapping(address => mapping(address => uint256)) private _allowances`) represent optimal EVM cold/warm slot access.
- Custom errors (`IORC20Errors`) save ~50–100 gas per revert compared to string-based revert reasons.

---

## Reference Implementation

The official production reference implementation is provided in:
- Interface: [`contracts/interfaces/IORC20.sol`](file:///e:/Developement%20Apps/ORC/contracts/interfaces/IORC20.sol)
- Reference Contract: [`contracts/reference/ORC20.sol`](file:///e:/Developement%20Apps/ORC/contracts/reference/ORC20.sol)

---

## Compliance Test Cases

Formal Foundry compliance test suites are located in:
- Standard Compliance: [`test/ORC20Compliance.t.sol`](file:///e:/Developement%20Apps/ORC/test/ORC20Compliance.t.sol)
- Edge Cases & Fuzzing: [`test/ORC20EdgeCases.t.sol`](file:///e:/Developement%20Apps/ORC/test/ORC20EdgeCases.t.sol)

---

## References

- [Ethereum ERC-20 Token Standard](https://eips.ethereum.org/EIPS/eip-20)
- [OpenZeppelin ERC20 Implementation](https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol)
- [ORC-1: Purpose, Process, and Governance](file:///e:/Developement%20Apps/ORC/process/ORC-1.md)
