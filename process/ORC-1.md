---
orc: 1
title: ORC Purpose, Process, and Governance
description: Guidelines and procedures for creating, reviewing, and formalizing Ozone Request for Comments.
author: Ozone Chain Core Architecture Team <standards@ozonechain.io>
status: Final
type: Process
category: Process
created: 2026-08-24
---

# ORC-1: ORC Purpose, Process, and Governance

## Abstract

This document describes the Ozone Request for Comments (ORC) process. ORCs are the primary mechanism for proposing new features, documenting standard interfaces, collecting technical consensus, and publishing reference implementations for the Ozone Chain ecosystem. This specification defines the proposal lifecycle, document formatting, participant roles, and governance rules.

---

## Motivation

To foster a robust, interoperable, and secure decentralized application ecosystem, Ozone Chain requires a structured, transparent, and developer-friendly standards process. 

Ethereum established the EIP/ERC model, which has become the gold standard for EVM interoperability. Ozone Chain adopts an adapted, high-rigor framework—**ORC (Ozone Request for Comments)**—that preserves complete compatibility with EVM/ERC standards while providing a tailored forum for Ozone Chain developers, infrastructure providers, and ecosystem participants.

---

## Specification

### 1. ORC Categories

Every ORC MUST belong to one of the following tracks:

1. **Standards Track**: Describes any change or standard that affects applications, smart contracts, interfaces, or ecosystem interoperability on Ozone Chain. Standards Track ORCs are divided into categories:
   - **Core**: Core contract interfaces or infrastructure standards.
   - **Interface**: Interoperability interfaces for contract-to-contract or client-to-contract communication (e.g., interface detection, metadata).
   - **Token**: Fungible, non-fungible, or multi-token asset standards (e.g., ORC-20, ORC-721).
   - **Application**: Application-level protocols, decentralized exchanges, or vault standards (e.g., ORC-4626).
   - **Security**: Standardized security patterns, multi-signature protocols, or recovery modules.
2. **Process Track**: Describes a process surrounding ORC development, governance, or changes to the editorial guidelines (e.g., ORC-1).
3. **Informational Track**: Outlines an architectural design, best practice, or information relevant to the Ozone community without proposing a normative standard.

---

### 2. Proposal Lifecycle

An ORC progresses through the following sequential statuses:

```text
  [ IDEA ]
     │
     ▼
  [ DRAFT ]
     │
     ▼
  [ REVIEW ]  ◄────────┐
     │                 │ (Revisions Needed)
     ▼                 │
[ CANDIDATE ] ─────────┘
     │
     ▼
  [ FINAL ]
```

Additional terminal or transitional states:
- **STAGNANT**: Any `Draft` or `Review` inactive for >6 months without author activity.
- **WITHDRAWN**: Explicitly withdrawn by the author.
- **REJECTED**: Formally rejected due to critical technical flaws or consensus refusal.
- **DEPRECATED**: A previously `Final` ORC that has been superseded by a newer standard.

#### Status Definitions

1. **Idea**: An informal concept discussed on Ozone Chain developer forums or chat channels.
2. **Draft**: A formally formatted proposal PR merged into the repository by an ORC Editor. The proposal is open for active development.
3. **Review**: The author marks the proposal as complete and requests ecosystem-wide technical and security review. Minimum review period: **14 days**.
4. **Candidate**: The specification is technically complete, has undergone peer review, includes a passing reference test suite, and is undergoing final validation on Ozone Chain testnets. Minimum period: **14 days**.
5. **Final**: The standard is finalized, immutable, and represents an official Ozone Chain ecosystem standard. Changes to a Final ORC require a new ORC number.

---

### 3. ORC Metadata Header (Frontmatter)

Every ORC MUST begin with an RFC 822 / YAML frontmatter header structured as follows:

```yaml
---
orc: <assigned-number>
title: <short descriptive title>
description: <concise summary in 1-2 sentences>
author: <Name and/or GitHub handle> <email optional>
status: <Draft | Review | Candidate | Final | Stagnant | Withdrawn | Deprecated>
type: <Standards Track | Process | Informational>
category: <Core | Interface | Token | Application | Security | Process | Informational>
created: <YYYY-MM-DD>
requires: <comma-separated ORC numbers, optional>
replaces: <comma-separated ORC numbers, optional>
superseded-by: <comma-separated ORC numbers, optional>
---
```

---

### 4. Mandatory Document Structure

A Standards Track ORC MUST contain the following sections:

1. **Abstract**: Short technical summary.
2. **Motivation**: Why the standard is needed.
3. **Specification**: Exact technical requirements, function signatures, errors, events, and parameters using RFC 2119 keywords (**MUST**, **MUST NOT**, **SHOULD**, **MAY**).
4. **Compatibility**: Backwards compatibility analysis with EVM tooling, ERC standards, and existing contracts.
5. **Security Considerations**: Explicit threat modeling and mitigation strategies.
6. **Gas Considerations**: Analysis of execution costs and optimization advice.
7. **Reference Implementation**: Link or inline Solidity contract(s) under `contracts/reference/`.
8. **Compliance Test Cases**: Automated test suites in Foundry under `test/`.
9. **References**: Citations to relevant EIPs, RFCs, or technical papers.

---

## Governance & Participant Responsibilities

### ORC Editors
Editors maintain the repository and are responsible for:
- Checking metadata and structure formatting.
- Ensuring language is objective and devoid of unsubstantiated marketing claims.
- Assigning official numbers.
- Managing PR transitions.

### ORC Authors
Authors are responsible for:
- Writing rigorous technical specifications.
- Implementing reference contracts and Foundry compliance tests.
- Responding to community feedback and security reviews.

---

## Copyright

All ORC specification documents are dedicated to the public domain under **Creative Commons CC0 1.0 Universal**.
