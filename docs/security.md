# ORC Smart Contract Security Guidelines

This guide outlines security standards, common attack vectors, and best practices for developing smart contracts in the **Ozone Chain (ORC)** ecosystem.

---

## 1. Core Threat Vectors & Mitigation

### 1.1 Reentrancy
- **Risk**: External calls during transfer hooks or callbacks can hijack control flow before internal balances update.
- **Rule**: Always adhere strictly to the **Checks-Effects-Interactions (CEI)** pattern. Update balances and state before making any external call or dispatching external tokens.

### 1.2 Allowance Front-Running (Race Conditions)
- **Risk**: If user Alice reduces Bob's allowance from 100 to 50 via `approve(bob, 50)`, Bob can watch the mempool and execute `transferFrom` for 100 before Alice's transaction is mined, then spend the new 50 allowance afterwards (total 150 spent).
- **Rule**:
  - DApps should call `approve(spender, 0)` before setting a new allowance.
  - Implement and use helper methods or signature-based permits (`ORC-2612`).

### 1.3 Fee-on-Transfer & Rebasing Gotchas
- **Risk**: Tokens that deduct a fee on transfer or dynamically rebase balances break automated liquidity pools that assume `amountReceived == amountSent`.
- **Rule**:
  - Standard ORC-20 tokens MUST NOT deduct fees silently.
  - If a fee-on-transfer mechanism is necessary for a specific business model, it MUST be documented explicitly and audited against DEX pool integrations.

### 1.4 Unchecked External Calls & SafeTransfer
- **Risk**: Some legacy tokens return `false` on failure instead of reverting.
- **Rule**: When interacting with arbitrary external tokens in dApps, always use a wrapper like OpenZeppelin's `SafeERC20` (`safeTransfer`, `safeTransferFrom`).

### 1.5 Signature Replay (Permits & Meta-Transactions)
- **Risk**: Reusing signed permit payloads across different chains or transactions.
- **Rule**:
  - Hash signatures with EIP-712 structured typed data.
  - Include the active `block.chainid` in the `DOMAIN_SEPARATOR`.
  - Maintain an incrementing per-account `nonce`.
  - Enforce explicit expiration `deadline` timestamps.

---

## 2. Security Audit Checklist

Before deploying any ORC contract to Ozone Chain Mainnet:
- [ ] Checked arithmetic enabled (Solidity 0.8+ default).
- [ ] No `tx.origin` used for authentication; use `msg.sender`.
- [ ] Admin keys secured with a multi-signature wallet or timelock.
- [ ] Custom errors defined with explicit descriptive parameters.
- [ ] Fuzz testing executed with >1,000 runs using Foundry (`forge test --fuzz-runs 1000`).
- [ ] Slither / static analysis report generated with zero high/medium vulnerabilities.
