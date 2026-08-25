# Contributing to ORC

Thank you for your interest in contributing to **ORC (Ozone Request for Comments)**!

This guide explains how to propose, write, review, and maintain standards for the Ozone Chain ecosystem.

---

## 1. Before You Propose an ORC

Before writing a new specification:
1. **Search Existing Standards**: Check `standards/` and open pull requests to ensure your idea is not already covered or in progress.
2. **Community Discussion**: Post an initial pitch or RFC idea on the Ozone Chain developer forums or Discord. Solicit early feedback from fellow builders.
3. **Verify EVM Compatibility**: Ensure your proposal adheres to standard EVM execution principles and does not introduce breaking inconsistencies.

---

## 2. ORC Proposal Workflow

### Step 1: Fork and Branch
Fork the [Ozone-chain/ORC](https://github.com/Ozone-chain/ORC) repository and create a new feature branch:
```bash
git checkout -b orc/my-proposal-title
```

### Step 2: Copy the Template
Copy `process/template.md` into `standards/ORC-XXXX.md` (use `XXXX` as a temporary placeholder until an Editor assigns an official number):
```bash
cp process/template.md standards/ORC-XXXX.md
```

### Step 3: Fill Out the Proposal
Complete all required frontmatter and sections:
- Use RFC 2119 normative terms (**MUST**, **MUST NOT**, **SHOULD**, **MAY**).
- Avoid speculative marketing language.
- Provide explicit Solidity interface files under `contracts/interfaces/`.
- Provide working reference code under `contracts/reference/`.
- Provide automated Foundry tests under `test/`.

### Step 4: Open a Pull Request
Submit a Pull Request with the title: `ORC-XXXX: <Short Title of Your Proposal>`.
In the PR description, explain the motivation, link community discussions, and tag relevant working groups.

### Step 5: Editorial Review and Number Assignment
An ORC Editor will review your PR for formatting completeness, assign an official number according to `process/numbering.md`, and merge the initial `Draft`.

---

## 3. ORC Author Checklist

Before requesting `Review` or `Candidate` status, authors must complete the following checklist:

- [ ] **ORC Number Assigned**: Official number obtained from an ORC Editor.
- [ ] **Frontmatter Complete**: Valid YAML header with `orc`, `title`, `author`, `status`, `type`, `category`, and `created`.
- [ ] **Abstract**: Clear summary under 200 words explaining the technical standard.
- [ ] **Motivation**: Justification for why this standard is needed on Ozone Chain.
- [ ] **Specification**: Complete and unambiguous normative requirements, function signatures, event definitions, and parameters.
- [ ] **Compatibility**: Full analysis of backwards compatibility with EVM/ERC tooling (MetaMask, ethers/viem, DEXes).
- [ ] **Security Considerations**: Comprehensive analysis of threat models, reentrancy, access control, front-running, and signatures.
- [ ] **Gas Considerations**: Gas profiles, storage optimization, and loops analysis.
- [ ] **Reference Implementation**: Working, audited or audit-ready Solidity contracts adhering to modern best practices (e.g., Solidity 0.8.20+, custom errors, NatSpec).
- [ ] **Compliance Tests**: Comprehensive Foundry test suite covering nominal paths and edge cases.
- [ ] **Community Feedback**: Addressed all public issues and editorial review comments.

---

## 4. ORC Maintainer / Editor Checklist

ORC Editors evaluate proposals before merging or advancing status using this checklist:

- [ ] **Formatting and Structure**: Matches `process/template.md` and uses RFC 2119 keywords appropriately.
- [ ] **Technical Completeness**: All interfaces, methods, errors, and events are unambiguously defined.
- [ ] **No Unjustified Conflicts**: Does not duplicate or subtly break existing standards without technical justification.
- [ ] **EVM Safety**: Does not assume non-standard consensus or EVM modifications.
- [ ] **Test Validation**: Test suites compile cleanly and pass in automated CI (`forge test`).
- [ ] **Licensing**: Documentation is CC0-1.0 and code is MIT licensed.
- [ ] **Peer Review**: At least one subject-matter expert or working group member has reviewed the smart contract logic.

---

## 5. Coding Standards for Smart Contracts

Smart contracts provided as reference implementations in ORC must:
- Target modern Solidity compiler versions (`^0.8.20`).
- Utilize **custom errors** instead of expensive require strings for gas efficiency and error clarity.
- Include complete **NatSpec documentation** (`@notice`, `@dev`, `@param`, `@return`).
- Avoid unnecessary external dependencies or massive library forks.
- Maintain compatibility with standard OpenZeppelin Contracts v5 conventions.
