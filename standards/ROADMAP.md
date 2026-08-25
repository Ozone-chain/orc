# ORC Standards Roadmap

This roadmap documents the strategic pipeline of future technical standards planned for the **Ozone Chain (ORC)** ecosystem.

---

## 1. Overview Matrix

| Standard | Working Title | Category | Target Status | Upstream Reference | Ozone-Specific Requirements |
|:---|:---|:---|:---|:---|:---|
| **ORC-1** | ORC Process & Governance | Process | **Final** | EIP-1 | Tailored for Ozone governance & editors |
| **ORC-20** | Fungible Token Standard | Token | **Final** | ERC-20 | 100% ABI compatibility + Custom Errors |
| **ORC-165** | Standard Interface Detection | Interface | *Draft Planned* | ERC-165 | Standardized `supportsInterface(bytes4)` |
| **ORC-721** | Non-Fungible Token Standard | Token | *Draft Planned* | ERC-721 | NFT metadata, safe transfers & enumeration |
| **ORC-1155** | Multi-Token Standard | Token | *Draft Planned* | ERC-1155 | Batch transfers & semi-fungibles |
| **ORC-2612** | Permit / Gasless Approvals | Token | *Draft Planned* | ERC-2612 | EIP-712 typed signed allowances |
| **ORC-4626** | Tokenized Vault Standard | Application | *Draft Planned* | ERC-4626 | Yield-bearing DeFi vault standard |
| **ORC-1001** | Post-Quantum Signature Verification | Security | *Research* | Native | High-efficiency PQC application-layer verification |

---

## 2. Detailed Roadmap Specifications

### ORC-165: Standard Interface Detection
- **Motivation**: Provide a standardized method for smart contracts on Ozone Chain to query whether a target contract implements a given interface.
- **ERC Alignment**: Exact match with ERC-165 (`0x01ffc9a7`).
- **EVM Compatibility**: Purely contract-level; no consensus changes required.

### ORC-721: Ozone Non-Fungible Token Standard
- **Motivation**: Standardize unique, collectible, and tokenized real-world assets on Ozone Chain.
- **ERC Alignment**: 100% ABI and event compatibility with ERC-721 (`ownerOf`, `safeTransferFrom`, `tokenURI`).
- **Target Applications**: NFT marketplaces, gaming, digital identity, and RWA tokenization.

### ORC-1155: Multi-Token Standard
- **Motivation**: Single-contract deployment managing fungible, non-fungible, and semi-fungible tokens with gas-efficient batch operations.
- **ERC Alignment**: Exact match with ERC-1155 (`balanceOfBatch`, `safeBatchTransferFrom`).

### ORC-2612: Signed Approvals (Permit Extension)
- **Motivation**: Eliminate the 2-step "approve then transfer" UX friction in DeFi by allowing allowances to be granted via gasless cryptographic signatures (EIP-712).
- **ERC Alignment**: Standard `permit(address owner, address spender, uint256 value, uint256 deadline, uint8 v, bytes32 r, bytes32 s)`.

### ORC-4626: Tokenized Vault Standard
- **Motivation**: Standardize yield-bearing vaults, lending pools, and staking derivatives to unify DeFi composability on Ozone Chain.
- **ERC Alignment**: Exact match with ERC-4626 (`deposit`, `mint`, `withdraw`, `redeem`, `convertToShares`, `convertToAssets`).

### ORC-1001: Post-Quantum Signature Verification (Research Track)
- **Motivation**: Investigate application-layer precompiled/hybrid post-quantum signature verification modules for high-value enterprise contracts on Ozone Chain.
- **Status**: Exploratory research.
