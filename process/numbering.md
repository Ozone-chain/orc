# ORC Numbering Convention

This document outlines the official numbering policy for **Ozone Request for Comments (ORC)** specifications to ensure clarity, ecosystem familiarity, and conflict prevention.

---

## 1. Core Principles

1. **Ecosystem Familiarity & ERC Alignment**: Where an ORC standard represents the direct Ozone-native equivalent of an established Ethereum standard (such as fungible tokens, non-fungible tokens, or permit signatures), the ORC standard SHOULD mirror the corresponding ERC number.
   - Example: `ORC-20` directly corresponds to `ERC-20`.
   - Example: `ORC-721` directly corresponds to `ERC-721`.
   - Example: `ORC-1155` directly corresponds to `ERC-1155`.
   - Example: `ORC-2612` directly corresponds to `ERC-2612`.
   - Example: `ORC-4626` directly corresponds to `ERC-4626`.

2. **Ozone-Native Innovations**: For standards introducing new, Ozone-specific application protocols, consensus-adjacent interfaces, or quantum-safe application extensions, sequential numbers starting from **1000+** will be allocated sequentially by ORC Editors.

3. **Process & Meta Standards**: Numbers 1–19 are reserved for process, governance, and meta specifications (e.g., `ORC-1`).

---

## 2. Number Allocation Procedure

1. **Initial PR Submission**: Authors submit their draft proposal with the placeholder `ORC-XXXX`.
2. **Editorial Verification**: Upon review, an ORC Editor assigns the official number based on:
   - Corresponding ERC number (if standardizing an existing EVM paradigm).
   - The next available sequential integer in the appropriate category block.
3. **Immutability of Assigned Numbers**: Once an ORC number is merged to `main`, that number is permanently associated with that proposal and MUST NOT be reassigned to any other standard, even if the proposal is later Withdrawn or Rejected.

---

## 3. Conflict and Duplication Prevention

- The single source of truth for allocated numbers is the `standards/` directory on the `main` branch of the official repository.
- Authors MUST NOT claim or reserve numbers unilaterally without editorial assignment.
- Sub-specifications or extensions MUST NOT reuse existing numbers with suffixes (e.g., `ORC-20a` is prohibited; use a new distinct number such as `ORC-2612`).
