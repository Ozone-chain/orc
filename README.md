# ORC — Ozone Request for Comments

[![License: CC0-1.0](https://img.shields.io/badge/License-CC0_1.0-blue.svg)](LICENSE)
[![Code License: MIT](https://img.shields.io/badge/Code_License-MIT-green.svg)](LICENSE)
[![Ozone Chain EVM](https://img.shields.io/badge/Ozone_Chain-EVM_Compatible-blueviolet)](https://ozonechain.io/)
[![Status](https://img.shields.io/badge/Status-Active_Standards-success)](standards/)

**ORC (Ozone Request for Comments)** is the official standards and proposal framework for defining interoperable, secure, extensible, and Ozone-native technical standards for applications built on **[Ozone Chain](https://ozonechain.io/)**.

Inspired by established blockchain standards ecosystems (such as Ethereum's EIP/ERC framework), ORC standardizes token interfaces, smart contract protocols, wallet interaction conventions, and application interfaces while maintaining **100% compatibility with standard EVM technologies and the existing ERC-20 ecosystem**.

---

## Architectural Principles

1. **Strict EVM Compatibility**: ORC operates at the smart contract, application, and tooling standards layer. It does not alter Ozone Chain's EVM execution environment, consensus, or base transaction semantics.
2. **Preservation of Existing Assets**: Existing ERC-20 tokens deployed on Ozone Chain remain fully functional. No migration or contract redeployment is required to maintain compatibility.
3. **Canonical Interface Parity**: Core standards (such as ORC-20) maintain exact ABI, function selector, and event signature equivalence with canonical ERC standards to guarantee seamless integration with MetaMask, ethers.js, viem, wagmi, AMMs, and EVM block explorers.
4. **Empirical Benchmarks**: Performance and gas characteristics are strictly based on reproducible measurements on the EVM; marketing claims without verifiable benchmarks are prohibited.
5. **Open Governance**: Clear, RFC-style proposal lifecycle managed by standards editors, open-source contributors, and ecosystem working groups.

---

## Repository Structure

```text
ORC/
├── process/                     # Governance, lifecycle, numbering & RFC template
│   ├── ORC-1.md                 # Foundational process specification
│   ├── lifecycle.md             # Status transition machine
│   ├── numbering.md             # Identifier allocation policy
│   └── template.md              # Canonical proposal template
│
├── standards/                   # Finalized and active specifications
│   ├── ORC-20.md                # Ozone Fungible Token Standard
│   └── ROADMAP.md               # Upcoming standards pipeline
│
├── contracts/                   # Smart contract interfaces & reference code
│   ├── interfaces/              # Clean, modular Solidity interfaces
│   │   ├── IORC20.sol           # Core ORC-20 interface
│   │   ├── IORC20Metadata.sol   # Optional token metadata interface
│   │   └── IORC20Errors.sol     # Standard custom revert errors
│   └── reference/               # Production-grade reference implementations
│       └── ORC20.sol            # ORC-20 reference contract
│
├── test/                        # Formal compliance and test suites
│   ├── ORC20Compliance.t.sol    # Automated compliance test suite
│   ├── ORC20EdgeCases.t.sol     # Boundary and fuzz test suite
│   └── helpers/                 # Test runners and reporting utilities
│
├── benchmarks/                  # Performance measurement suite
│   ├── ORC20Benchmark.t.sol     # Forge gas measurement contracts
│   └── ORC20Benchmark.md        # Reproducible gas analysis methodology
│
├── certification/               # Token compliance certification & badges
│   ├── CERTIFICATION.md         # Tier definitions & verification requirements
│   ├── verify-compliance.sh     # CLI verification script
│   └── badges/                  # Ecosystem certification badges
│
└── docs/                        # Ecosystem developer documentation
    ├── introduction.md          # Ecosystem vision and overview
    ├── compatibility.md         # EVM & tooling compatibility matrix
    ├── developer-guide.md       # Building and testing ORC tokens
    ├── ecosystem-integration.md # Wallet, DEX, Explorer & Bridge integration
    ├── certification.md         # How to verify and certify your contracts
    └── security.md              # Smart contract security guidelines
```

---

## Standards Index

| Standard | Title | Category | Status | ERC Alignment | Description |
|:---|:---|:---|:---|:---|:---|
| **[ORC-1](process/ORC-1.md)** | ORC Process and Governance | Process | **Final** | EIP-1 | Defines proposal structure, lifecycle, and editorial workflow |
| **[ORC-20](standards/ORC-20.md)** | Ozone Fungible Token Standard | Token | **Final** | ERC-20 | Canonical standard for fungible assets on Ozone Chain |
| **[ORC-165](standards/ROADMAP.md#orc-165)** | Standard Interface Detection | Interface | *Planned* | ERC-165 | Runtime interface query mechanism |
| **[ORC-721](standards/ROADMAP.md#orc-721)** | Ozone Non-Fungible Token | Token | *Planned* | ERC-721 | Unique and collectible assets standard |
| **[ORC-1155](standards/ROADMAP.md#orc-1155)** | Multi-Token Standard | Token | *Planned* | ERC-1155 | Efficient batch and hybrid token management |
| **[ORC-2612](standards/ROADMAP.md#orc-2612)** | Signed Approvals (Permit) | Token | *Planned* | ERC-2612 | Gasless signature-based token allowances |
| **[ORC-4626](standards/ROADMAP.md#orc-4626)** | Tokenized Vault Standard | Application | *Planned* | ERC-4626 | Standardized yield-bearing vaults |

---

## Certification Tiers

Ecosystem tokens deployed on Ozone Chain are classified into four transparent tiers:

1. **ERC-20 Compatible**: A contract providing standard ERC-20 ABI functions.
2. **ORC-20 Compatible**: A contract satisfying all normative semantic requirements of [ORC-20](standards/ORC-20.md).
3. **ORC-20 Certified**: A contract that passes 100% of the official [ORC-20 Compliance Suite](test/ORC20Compliance.t.sol) with reproducible on-chain test receipts.
4. **ORC-20 Reference Implementation**: The official implementation maintained by the Ozone Chain core team in `contracts/reference/`.

See [Certification Guide](certification/CERTIFICATION.md) for verification procedures.

---

## Quick Start for Developers

### 1. Installation

Clone this repository and verify test suites using Foundry:

```bash
git clone https://github.com/Ozone-chain/ORC.git
cd ORC
forge install
```

### 2. Run Compliance Suite

Run the formal ORC-20 compliance test suite against the reference implementation:

```bash
forge test --match-contract ORC20ComplianceTest -vv
```

Expected output:
```text
[PASS] test_ORC20_Compliance_Summary() (gas: ...)
Logs:
  =============================================================
  [OZONE CHAIN] ORC-20 Compliance Suite: PASS
  All canonical interfaces, events, and edge cases verified.
  =============================================================
```

### 3. Run Benchmarks

Measure exact gas costs for deployment, transfer, approval, and transferFrom:

```bash
forge test --match-contract ORC20BenchmarkTest --gas-report
```

---

## Contributing

Anyone in the Ozone Chain community can author an ORC proposal. Please review:
1. **[ORC-1: Process and Governance](process/ORC-1.md)**
2. **[Contributing Guide](CONTRIBUTING.md)**
3. **[ORC Proposal Template](process/template.md)**

---

## Security & Responsible Disclosure

Smart contract security is paramount in the Ozone Chain ecosystem. If you discover a vulnerability within an ORC reference implementation or standard specification, please review **[SECURITY.md](SECURITY.md)** for our disclosure process.

---

## Ozone Chain Network Details

| Parameter | Value |
|:---|:---|
| **Network Name** | Ozone Chain Mainnet |
| **RPC Endpoint** | `https://node1.ozonechain.io` |
| **Chain ID** | `4000` (`0xFA0`) |
| **Native Currency** | `OZO` |
| **Block Explorer** | [https://ozonescan.io](https://ozonescan.io) |

---

## Official Links

- **Ozone Chain Website**: [https://ozonechain.io/](https://ozonechain.io/)
- **Ozone Chain Explorer**: [https://ozonescan.io/](https://ozonescan.io/)
- **Ozone Chain GitHub**: [https://github.com/Ozone-chain](https://github.com/Ozone-chain)

