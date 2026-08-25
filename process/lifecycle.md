# ORC Proposal Lifecycle

This document provides a detailed breakdown of the status state machine, criteria for advancement, and handling of inactive or superseded standards within the **Ozone Request for Comments (ORC)** ecosystem.

---

## State Transition Diagram

```text
               ┌──────────────┐
               │     IDEA     │  (Forum discussions / Discord)
               └──────┬───────┘
                      │ Author submits initial PR
                      ▼
               ┌──────────────┐
               │    DRAFT     │  (Active drafting & initial implementation)
               └──────┬───────┘
                      │ Author completes specification & tests
                      ▼
               ┌──────────────┐
  ┌───────────►│    REVIEW    │  (Public peer review & security audit, min 14d)
  │            └──────┬───────┘
  │                   │ Editors confirm all concerns addressed
  │                   ▼
  │            ┌──────────────┐
  │ Revisions  │  CANDIDATE   │  (Testnet validation & trial period, min 14d)
  └────────────┤              │
               └──────┬───────┘
                      │ Final Editorial Sign-off (>= 2 Editors)
                      ▼
               ┌──────────────┐
               │    FINAL     │  (Frozen standard, immutable)
               └──────┬───────┘
                      │ Superseded by newer standard
                      ▼
               ┌──────────────┐
               │  DEPRECATED  │
               └──────────────┘

Alternative Paths:
[Draft / Review] ──► [STAGNANT]  (No activity for > 6 months)
[Draft / Review] ──► [WITHDRAWN] (Withdrawn by author)
[Draft / Review] ──► [REJECTED]  (Critical unresolvable flaw or consensus failure)
```

---

## Detailed State Criteria

### 1. Idea
- **Location**: Ozone Chain Developer Forums / Community Discord.
- **Goal**: Gather feedback, assess developer appetite, and verify whether a new standard is warranted.
- **Exit Criteria**: Author has sufficient community validation to draft a formal specification.

### 2. Draft
- **Location**: Merged markdown file under `standards/ORC-XXXX.md` in the GitHub repository.
- **Requirements**:
  - Valid metadata frontmatter.
  - Basic outline with all mandatory sections present.
- **Editorial Action**: Editor assigns an official ORC number and merges the initial PR.

### 3. Review
- **Requirements**:
  - The specification is structurally and technically complete.
  - Complete NatSpec interfaces created in `contracts/interfaces/`.
  - Preliminary reference implementation created in `contracts/reference/`.
  - Minimum review window: **14 days**.
- **Activities**: Smart contract auditors, DeFi developers, and working groups review the code and specification for security or design flaws.

### 4. Candidate
- **Requirements**:
  - All critical review feedback addressed and merged.
  - Complete, passing Foundry compliance test suite in `test/`.
  - Deployment and trial integration on Ozone Chain Testnet.
  - Minimum candidate window: **14 days**.
- **Exit Criteria**: No unresolved technical objections or security vulnerabilities.

### 5. Final
- **Requirements**:
  - Approved by at least two ORC Editors and the Ozone Chain Advisory Board.
  - Verified on-chain deployments demonstrating real-world interoperability.
- **Immutability**: Once `Final`, the specification is locked. Any breaking modification or significant extension requires authoring a new ORC (e.g., ORC-20 -> ORC-2612).

---

## Exceptional States

### Stagnant
- A proposal in `Draft` or `Review` that experiences no activity (commits, PR updates, or author responses) for **6 consecutive months** is automatically transitioned to `Stagnant`.
- A stagnant proposal can be revived back to `Draft` at any time by the author or a new champion submitting a PR.

### Withdrawn
- The author may voluntarily withdraw a proposal if they decide the approach is obsolete or unviable.

### Rejected
- An ORC may be marked `Rejected` if the Editorial Board determines it has fatal security flaws, violates EVM compatibility invariants, or fails to achieve consensus.

### Deprecated
- A `Final` standard that is replaced or discouraged in favor of a newer standard (e.g., if a legacy token standard is superseded) is updated to `Deprecated` with a pointer to the new ORC via the `superseded-by` header.
