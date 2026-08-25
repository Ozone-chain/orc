# Task: Design and Build ORC — Ozone Request for Comments

You are acting as a **senior blockchain protocol architect, standards engineer, Solidity developer, technical writer, and open-source maintainer**.

I represent **Ozone Chain**, an EVM-compatible blockchain.

Official website:
https://ozonechain.io/

GitHub organization:
https://github.com/Ozone-chain

Ozone Chain currently uses standard Ethereum/EVM-compatible technologies and existing tokens are ERC-20 compatible.

We want to create a new ecosystem standards framework called:

# ORC — Ozone Request for Comments

The goal is to create an Ozone-native standards framework inspired by Ethereum's EIP/ERC ecosystem, while preserving compatibility with existing Ethereum/EVM standards.

---

# IMPORTANT ARCHITECTURAL PRINCIPLE

Do NOT modify Ozone Chain's consensus, EVM, transaction format, networking layer, or existing ERC-20 behavior for ORC v1 unless there is a clearly justified technical requirement.( Should be EVM Compatible and developer friendly this is like BEP )

ORC v1 should primarily be:

- A technical standards framework
- A specification system
- A proposal/governance process
- A collection of Ozone ecosystem standards
- ERC/EVM compatibility specifications
- Reference implementations
- Compliance tests
- Developer documentation
- Certification/badge definitions
- Benchmarking methodology

The existing ERC-20 ecosystem must continue working.

Do NOT create incompatible functions such as:

```solidity
otransfer()
oapprove()
otransferFrom()
obalanceOf()
```

ORC-20 should remain ERC-20 ABI/interface compatible unless a future ORC specification explicitly introduces an extension.

---

# PRIMARY OBJECTIVES

Design ORC from scratch as a professional blockchain standards ecosystem.

The result should be suitable for:

- Ozone Chain developers
- DApp developers
- Token developers
- Wallet developers
- DEX developers
- Explorer developers
- Infrastructure providers
- Auditors
- Ecosystem projects
- Open-source contributors

The framework should be credible enough to eventually become the official standards framework of Ozone Chain.

---

# PART 1 — RESEARCH FIRST

Before generating the implementation, research and understand:

1. Ethereum EIP process
2. ERC standards
3. EIP-1 / proposal lifecycle
4. ERC-20
5. ERC-165
6. ERC-721
7. ERC-1155
8. ERC-2612
9. ERC-4626
10. OpenZeppelin implementation patterns
11. Foundry compliance testing
12. Open-source standards repositories

Use official/high-quality sources where possible.

Do NOT blindly copy Ethereum's terminology or implementation.

ORC should be an independent Ozone Chain standards framework inspired by established standards practices.

---

# PART 2 — DEFINE ORC

Create a formal definition.

Proposed definition:

> ORC (Ozone Request for Comments) is the standards and proposal framework for defining interoperable, secure, extensible and Ozone-native technical standards for applications built on Ozone Chain.

Improve this definition if necessary.

Explain:

- What ORC is
- What ORC is not
- Why ORC exists
- Relationship between ORC and EVM
- Relationship between ORC and ERC
- How existing ERC standards remain valid
- How an ERC standard can become ORC-compatible
- How Ozone-specific extensions should be handled

---

# PART 3 — ORC GOVERNANCE

Create:

## ORC-1 — ORC Process and Governance

This is the foundational specification.

It must define:

- ORC numbering
- ORC categories
- ORC metadata
- ORC lifecycle
- Proposal process
- Review process
- Technical review
- Security review
- Community review
- Approval process
- Finalization process
- Deprecation process
- Rejection process
- Withdrawal process
- Revision process
- ORC maintainers
- Author responsibilities
- Community responsibilities

Recommended lifecycle:

```text
IDEA
 ↓
DRAFT
 ↓
REVIEW
 ↓
CANDIDATE
 ↓
FINAL
```

Also support:

```text
WITHDRAWN
REJECTED
DEPRECATED
STAGNANT
```

Document exactly what each status means.

---

# PART 4 — ORC NUMBERING

Define a professional numbering scheme.

Prefer compatibility with existing Ethereum standards where appropriate.

Example:

```text
ORC-1      ORC Process
ORC-20     Fungible Token
ORC-721    NFT
ORC-1155   Multi Token
ORC-165    Interface Detection
```

Explain whether matching Ethereum numbering means:

```text
ORC-20 ≈ ERC-20-compatible standard
```

or whether the ORC standard is an independent specification.

Define rules preventing conflicting or duplicate ORC numbers.

---

# PART 5 — ORC CATEGORIES

Define categories such as:

```text
Core
Interface
Token
Application
Security
Networking
Informational
```

Keep the initial system simple.

Explain how categories may expand in the future.

---

# PART 6 — ORC DOCUMENT TEMPLATE

Create a canonical template that every ORC must use.

Example structure:

```markdown
---
orc: ORC-20
title: Ozone Fungible Token Standard
description: ...
author: ...
status: Draft
type: Standards Track
category: Token
created: YYYY-MM-DD
requires: ORC-1
---

# Abstract

# Motivation

# Specification

# Compatibility

# Requirements

# Optional Extensions

# Security Considerations

# Gas Considerations

# Compliance

# Reference Implementation

# Test Cases

# Backward Compatibility

# References
```

Improve the template if required.

Document every metadata field.

---

# PART 7 — ORC-20

Create the first real ORC standard:

# ORC-20 — Ozone Fungible Token Standard

ORC-20 must preserve ERC-20 compatibility.

It should define the standard interface:

```solidity
function totalSupply()
    external
    view
    returns (uint256);

function balanceOf(address account)
    external
    view
    returns (uint256);

function transfer(
    address to,
    uint256 amount
) external returns (bool);

function allowance(
    address owner,
    address spender
) external
    view
    returns (uint256);

function approve(
    address spender,
    uint256 amount
) external returns (bool);

function transferFrom(
    address from,
    address to,
    uint256 amount
) external returns (bool);
```

Required events:

```solidity
event Transfer(
    address indexed from,
    address indexed to,
    uint256 value
);

event Approval(
    address indexed owner,
    address indexed spender,
    uint256 value
);
```

Document:

- Function semantics
- Event semantics
- Error behavior
- Zero-value transfers
- Allowances
- transferFrom behavior
- Minting
- Burning
- Decimals
- Metadata
- Compatibility requirements
- Security considerations
- Edge cases

---

# PART 8 — ERC-20 COMPATIBILITY

This section is extremely important.

Explicitly document:

```text
ORC-20 MUST remain compatible with ERC-20 tooling.
```

Evaluate compatibility with:

- Solidity
- OpenZeppelin
- ethers.js
- viem
- wagmi
- MetaMask
- common wallets
- DEX contracts
- block explorers
- token lists

Explain:

- ABI compatibility
- Function selector compatibility
- Event compatibility
- Storage compatibility considerations
- Existing ERC-20 token compatibility
- Existing dApp compatibility

Do not make unsupported claims.

---

# PART 9 — EXISTING ERC-20 TOKENS

Define how an existing ERC-20 token can qualify as ORC-20.

Important:

Existing Ozone Chain ERC-20 tokens should NOT necessarily require redeployment.

Define possible classifications:

```text
ERC-20 Compatible
ORC-20 Compatible
ORC-20 Certified
ORC-20 Reference Implementation
```

Clearly define the difference between each.

---

# PART 10 — ORC REFERENCE IMPLEMENTATION

Create a Solidity reference implementation.

Prefer secure and battle-tested libraries such as OpenZeppelin rather than unnecessarily rewriting ERC-20 logic.

Example architecture:

```text
OpenZeppelin ERC20
        ↓
ORC20 compatibility layer
        ↓
Ozone-specific extensions
```

Do NOT fork large portions of OpenZeppelin without technical justification.

Use modern Solidity.

Use custom errors where appropriate.

Use safe patterns.

Add NatSpec documentation.

---

# PART 11 — ORC INTERFACES

Create:

```text
interfaces/
    IORC20.sol
```

If an ORC interface identifier is technically useful, define how ORC implementations can advertise support.

Evaluate whether ERC-165 should be used.

Do not add unnecessary functions purely for branding.

---

# PART 12 — ORC COMPLIANCE TEST SUITE

Create a professional compliance framework.

Use Foundry if appropriate.

Tests should cover:

```text
Interface
totalSupply
balanceOf
transfer
approve
allowance
transferFrom

Transfer event
Approval event

Zero transfers
Zero approvals
Insufficient balance
Insufficient allowance
Allowance updates
Mint behavior
Burn behavior
Edge cases
```

Create a test suite that an external project can use to verify ORC-20 compatibility.

Example:

```bash
forge test
```

Expected output should clearly indicate:

```text
ORC-20 Compliance: PASS
```

---

# PART 13 — ORC CERTIFICATION

Design a certification system.

Define:

### ORC-20 Compatible

Contract meets compatibility requirements.

### ORC-20 Certified

Contract passes the official ORC compliance suite.

### ORC Reference Implementation

Implementation maintained by Ozone Chain.

Define:

- Certification process
- Required tests
- Certification metadata
- Badge format
- Verification method
- How certification can be revoked
- How deprecated implementations are handled

---

# PART 14 — PERFORMANCE AND BENCHMARKING

Do NOT claim ORC is faster merely because it has a different name.

If Ozone-specific implementations provide performance improvements, those improvements must be measurable.

Create:

# ORC Performance & Benchmarking Specification

Define:

- Benchmark environment
- Ozone Chain version
- Solidity version
- Compiler optimization
- Gas measurement methodology
- Transaction measurement methodology
- Number of test iterations
- Baseline implementation
- ORC implementation

Benchmark:

```text
Deployment
Transfer
Approve
TransferFrom
Mint
Burn
```

Compare:

```text
Baseline ERC-20 implementation
vs
ORC reference implementation
```

If there is no measurable improvement, explicitly say so.

Do not manufacture performance claims.

---

# PART 15 — SECURITY DOCUMENTATION

Create:

# ORC Security Guidelines

Cover:

- Reentrancy
- Access control
- Ownership
- Mint permissions
- Burn permissions
- Upgradeability
- Proxy contracts
- Allowance race conditions
- Signature replay
- Nonces
- Chain ID
- Permit extensions
- Flash-loan considerations
- Event correctness
- Storage layout
- External calls
- Denial of service
- Integer arithmetic
- Compiler issues

Define minimum security requirements for ORC standards.

---

# PART 16 — CONTRIBUTING

Create:

```text
CONTRIBUTING.md
```

Explain:

- How to propose an ORC
- How to select a number
- How to create a draft
- Required documentation
- Required tests
- Review process
- Security review
- Community review
- Finalization
- Deprecation

Provide an ORC proposal checklist.

---

# PART 17 — ORC AUTHOR CHECKLIST

Create a reusable checklist:

```text
- [ ] ORC number assigned
- [ ] Title defined
- [ ] Abstract written
- [ ] Motivation documented
- [ ] Specification complete
- [ ] Compatibility documented
- [ ] Security considerations documented
- [ ] Gas considerations documented
- [ ] Reference implementation provided
- [ ] Tests provided
- [ ] Edge cases tested
- [ ] Backward compatibility reviewed
- [ ] Documentation reviewed
- [ ] Technical review completed
- [ ] Security review completed
- [ ] Community review completed
```

---

# PART 18 — ORC MAINTAINER CHECKLIST

Create a separate checklist:

```text
- [ ] Specification is technically complete
- [ ] No ambiguity in normative requirements
- [ ] Existing standards checked
- [ ] Compatibility verified
- [ ] Security risks reviewed
- [ ] Reference implementation reviewed
- [ ] Tests pass
- [ ] Documentation complete
- [ ] Breaking changes identified
- [ ] Dependencies documented
- [ ] Community feedback addressed
- [ ] Final approval obtained
```

---

# PART 19 — ORC DEVELOPER DOCUMENTATION

Create developer documentation explaining:

1. What ORC is
2. How to implement ORC-20
3. How to test ORC-20
4. How to certify a token
5. How to submit an ORC
6. How to create an ORC-compatible dApp
7. How wallets can detect ORC
8. How explorers can display ORC
9. How DEXes can support ORC
10. How future standards should extend ORC

---

# PART 20 — FUTURE ORC ROADMAP

Do not fully implement all of these initially.

Create a roadmap for:

```text
ORC-20    Fungible Tokens
ORC-721   NFTs
ORC-1155  Multi Tokens
ORC-165   Interface Detection
ORC-2612  Permit
ORC-4626  Tokenized Vaults
```

For each proposed future standard explain:

- Why it might be needed
- Whether it should mirror an Ethereum standard
- Whether it needs an Ozone-specific extension
- Whether it requires chain-level changes
- Whether it can remain fully EVM compatible

Do not create a new ORC standard merely for marketing.

---

# PART 21 — WEBSITE DOCUMENTATION

Design the documentation website structure:

```text
ORC Documentation
│
├── Introduction
├── What is ORC?
├── Why ORC?
├── Compatibility
│
├── Standards
│   ├── ORC-1
│   ├── ORC-20
│   └── Future Standards
│
├── Developers
│   ├── Getting Started
│   ├── Implementing ORC
│   ├── Testing
│   └── Certification
│
├── Governance
├── Security
├── Compliance
├── Benchmarks
└── Contributing
```

Recommend a suitable documentation stack if necessary.

---

# PART 22 — REPOSITORY STRUCTURE

Produce a professional repository structure.

Recommended starting point:

```text
ORC/
├── README.md
├── LICENSE
├── GOVERNANCE.md
├── CONTRIBUTING.md
├── SECURITY.md
│
├── process/
│   ├── ORC-1.md
│   ├── lifecycle.md
│   ├── numbering.md
│   └── template.md
│
├── standards/
│   └── ORC-20.md
│
├── interfaces/
│   └── IORC20.sol
│
├── implementations/
│   └── ORC20.sol
│
├── test/
│   └── ORC20Compliance.t.sol
│
├── benchmarks/
│   └── ORC20Benchmark.md
│
└── docs/
    ├── introduction.md
    ├── compatibility.md
    ├── developer-guide.md
    ├── certification.md
    └── security.md
```

Improve this structure if you identify a better architecture.

---

# PART 23 — DOCUMENTATION QUALITY REQUIREMENTS

All specifications must distinguish between:

### MUST

Normative requirement.

### MUST NOT

Prohibited behavior.

### SHOULD

Strong recommendation.

### SHOULD NOT

Strong recommendation against.

### MAY

Optional behavior.

Use RFC-style normative language consistently.

Avoid marketing language inside technical specifications.

For example, do NOT write:

> ORC is the world's fastest token standard.

Instead write:

> ORC implementations MAY define implementation-specific optimizations. Such optimizations MUST be supported by reproducible benchmarks.

---

# PART 24 — MARKETING VS TECHNICAL DOCUMENTATION

Separate these clearly.

## Technical documentation

Must be:

- Precise
- Testable
- Conservative
- Reproducible
- Versioned

## Marketing documentation

Can explain:

- Ozone-native standards
- Developer ecosystem
- Compatibility
- Standardization
- Future roadmap

But marketing MUST NOT make unsupported technical claims.

Especially do not claim:

> ORC is faster than ERC-20

unless benchmarks prove it.

---

# PART 25 — IMPORTANT QUESTIONS BEFORE FINALIZING

Before implementing anything that could be ambiguous, ask me questions.

Do NOT silently assume important architectural decisions.

Ask questions such as:

1. Should ORC-20 be 100% ERC-20 ABI compatible?
2. Should existing ERC-20 tokens qualify for ORC-20 automatically if they pass compliance?
3. Who will initially control ORC governance?
4. Should ORC standards be legally/open-source licensed?
5. Which GitHub repository should contain ORC?
6. Which documentation platform should be used?
7. Should ORC-20 have any Ozone-specific functions?
8. Should ORC use ERC-165 interface detection?
9. Do we have an existing Ozone token implementation that should be used as the reference?
10. Do we have real performance benchmarks?
11. Should ORC certification be centralized by Ozone initially?
12. What naming/versioning conventions should be official?

If an answer affects architecture, STOP and ask me before implementing that portion.

---

# PART 26 — DO NOT DO THESE THINGS

Do NOT:

- Rename ERC-20 functions
- Break MetaMask compatibility
- Break ethers/viem compatibility
- Create unnecessary custom cryptography
- Modify the EVM without justification
- Claim performance improvements without benchmarks
- Fork OpenZeppelin unnecessarily
- Create standards only for marketing
- Copy Ethereum EIPs verbatim
- Claim ORC replaces ERC
- Claim ORC makes an ERC contract quantum resistant
- Introduce chain-level changes without explicit approval

---

# FINAL DELIVERABLE

Do not merely give me an explanation.

Produce a complete implementation plan and starter repository for ORC.

The final result should include:

```text
1. ORC architecture
2. ORC governance model
3. ORC-1 specification
4. ORC document template
5. ORC-20 specification
6. ORC-20 compatibility rules
7. ORC-20 reference implementation
8. ORC interfaces
9. ORC-20 compliance tests
10. ORC certification model
11. Security guidelines
12. Performance benchmark methodology
13. Contribution guide
14. Author checklist
15. Maintainer checklist
16. Developer documentation
17. Repository structure
18. Website documentation structure
19. Future ORC roadmap
20. Implementation roadmap
```

For every file you propose, provide:

```text
FILE:
PATH:
PURPOSE:
CONTENT:
DEPENDENCIES:
STATUS:
```

Mark every item as:

```text
[ ] Not started
[ ] In progress
[ ] Draft
[ ] Review
[ ] Complete
```

At the end, provide a master:

# ORC v1 Launch Checklist

with every task required before publicly announcing ORC.

The implementation should prioritize **technical credibility, EVM/ERC compatibility, security, reproducibility, developer usability and long-term maintainability over marketing claims.**

Start by reviewing the requirements and identifying any questions that must be answered before you begin implementation.
