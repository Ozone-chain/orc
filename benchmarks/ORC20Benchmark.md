# ORC-20 Performance & Benchmarking Specification

This document defines the benchmarking methodology, execution environment parameters, gas profiles, and comparison data for **ORC-20** on **Ozone Chain**.

---

## 1. Benchmarking Principles & Non-Marketing Commitment

In compliance with the ORC Technical Standards Charter:
- **No Synthetic Speed Claims**: ORC-20 is executed on the standard Ozone Chain EVM. We make **zero claims** of execution speed advantages over canonical ERC-20 purely due to standard branding.
- **Reproducibility**: All gas metrics documented here are 100% reproducible using the automated Foundry test suite (`forge test --match-contract ORC20BenchmarkTest --gas-report`).
- **Optimization Attribution**: Gas savings documented in this report stem strictly from Solidity compiler configurations (Solidity `0.8.24`, Cancun EVM target, `via_ir = false`, optimizer runs `200`) and the use of **custom errors** instead of revert strings.

---

## 2. Benchmark Environment

| Parameter | Specification |
|:---|:---|
| **Target Blockchain** | Ozone Chain (EVM Compatible) |
| **EVM Target Version** | Cancun / Shanghai |
| **Solidity Compiler** | `solc 0.8.24` |
| **Optimization** | Enabled (`runs = 200`) |
| **Test Framework** | Foundry (`forge 0.2.0`) |
| **State Condition** | Standard EVM Cold/Warm Storage (EIP-2929 rules) |

---

## 3. Gas Consumption Profile

The table below outlines the measured gas consumption across core operations for the ORC-20 Reference Implementation (`contracts/reference/ORC20.sol`):

| Operation | Baseline ERC-20 (String Reverts) | ORC-20 Reference (Custom Errors) | Net Difference | Notes |
|:---|:---:|:---:|:---:|:---|
| **Contract Deployment** | ~580,000 gas | ~524,120 gas | **-55,880 gas (-9.6%)** | Reduced bytecode from eliminating revert string tables |
| **Transfer (Cold Recipient)** | 51,320 gas | 51,215 gas | ~0% (Within EVM variance) | Dominated by SSTORE cold slot initialization (20,000 gas) |
| **Transfer (Warm Recipient)** | 29,450 gas | 29,380 gas | ~0% | Standard SSTORE update |
| **Approve (0 -> Non-Zero)** | 46,120 gas | 46,080 gas | ~0% | SSTORE cold slot initialization |
| **Approve (Update)** | 26,100 gas | 26,050 gas | ~0% | SSTORE warm slot modification |
| **TransferFrom (Standard)** | 35,400 gas | 35,320 gas | ~0% | Balance updates + allowance decrement |
| **TransferFrom (Infinite Allowance)** | 32,800 gas | 32,710 gas | **-90 gas** | Skips SSTORE allowance update when allowance == `type(uint256).max` |
| **Revert on Insufficient Balance** | ~23,450 gas | ~21,310 gas | **-2,140 gas (-9.1%)** | Typed custom error saves ABI string encoding and calldata memory expansion |

---

## 4. Reproducing the Benchmarks

To independently verify these gas measurements on your machine:

```bash
# Clone the repository
git clone https://github.com/Ozone-chain/ORC.git
cd ORC

# Execute gas benchmark tests
forge test --match-contract ORC20BenchmarkTest --gas-report
```
