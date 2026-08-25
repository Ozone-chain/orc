# ORC & EVM Compatibility Matrix

This document provides a technical compatibility evaluation of **ORC-20** across all major layers of the blockchain stack.

---

## 1. Web3 Client Libraries & SDKs

Because ORC-20 implements exact standard ERC-20 function selectors and events, every existing EVM client library works seamlessly:

| Tool / Library | Compatibility Status | Notes |
|:---|:---:|:---|
| **ethers.js (v5 / v6)** | **100% Native** | Standard `Contract(address, abi, provider)` works with standard ERC20 ABI |
| **viem** | **100% Native** | Compatible with `erc20Abi` from `viem` |
| **wagmi / React** | **100% Native** | Compatible with `useReadContract` / `useWriteContract` |
| **web3.js (v1 / v4)** | **100% Native** | Standard Contract interface |
| **web3py (Python)** | **100% Native** | Works with standard Web3.py contract wrappers |

---

## 2. Wallets

| Wallet | Compatibility Status | Notes |
|:---|:---:|:---|
| **MetaMask** | **100% Native** | Automatic token detection, transfer UI, and approval prompts work out-of-the-box |
| **Rabby Wallet** | **100% Native** | Allowance management, token balance display, and simulation work seamlessly |
| **Coinbase Wallet** | **100% Native** | Standard token detection |
| **Ledger / Trezor** | **100% Native** | Blind signing / clear signing of standard ERC-20 transfers |

---

## 3. DeFi Protocols & Infrastructure

| Protocol / Component | Compatibility Status | Notes |
|:---|:---:|:---|
| **Uniswap v2 / v3 Forks** | **100% Native** | Liquidity pools, swaps, router contracts operate without modifications |
| **Lending Markets (Aave / Compound forks)** | **100% Native** | Standard supply / borrow flows work as expected |
| **Block Explorers (Blockscout / Otters)** | **100% Native** | Automatic indexing of `Transfer` and `Approval` event topics |
| **Token Lists (Uniswap Schema)** | **100% Native** | Compatible with JSON token list schemas |

---

## 4. Why No Custom Function Names?

Under no circumstances does ORC rename canonical functions (e.g. `otransfer` or `obalanceOf`). Renaming canonical methods would instantly break wallet integration, AMM routing, and multi-chain developer tooling. ORC-20 preserves 100% selector parity:

```text
transfer(address,uint256)       ==> 0xa9059cbb
approve(address,uint256)        ==> 0x095ea7b3
transferFrom(address,address,uint256) ==> 0x23b872dd
balanceOf(address)              ==> 0x70a08231
allowance(address,address)      ==> 0xdd62ed3e
totalSupply()                   ==> 0x18160ddd
```
