# Security Policy and Vulnerability Disclosure

Security is a primary pillar of the **Ozone Request for Comments (ORC)** standards framework. We welcome security researchers, smart contract auditors, and developers to responsibly report vulnerabilities.

---

## 1. Scope

This security policy applies to:
- Reference smart contracts under `contracts/reference/`
- Standard interfaces under `contracts/interfaces/`
- Compliance and benchmarking suites under `test/` and `benchmarks/`
- Specification vulnerabilities in `standards/` (e.g., mathematical edge cases, protocol flaws, or front-running vectors)

---

## 2. Reporting a Vulnerability

If you discover a security vulnerability in any ORC specification or reference implementation:

1. **DO NOT** disclose the vulnerability publicly in GitHub issues, public discussions, or social media.
2. Send a detailed report via encrypted email to:
   - **Email**: `security@ozonechain.io`
   - **Subject**: `[ORC Security Disclosure] <Component / Standard Name>`
3. Include the following details in your report:
   - Specific standard or file affected (e.g., `ORC-20`, `contracts/reference/ORC20.sol`).
   - Detailed description of the attack vector or defect.
   - Proof of Concept (PoC) code or Foundry test replicating the issue.
   - Potential impact on funds, state consistency, or network tooling.
   - Suggested remediation or patch.

---

## 3. Response and Remediation Process

- **Acknowledgment**: Our security team will acknowledge receipt of your report within **24 hours**.
- **Assessment**: The core team and standard authors will evaluate severity, impact, and exploitability within **72 hours**.
- **Fix & Testing**: A patch will be authored in a private fork and tested against compliance suites.
- **Coordination**: We will coordinate with affected ecosystem partners (DEXes, token projects, wallets) prior to public release.
- **Public Disclosure**: A security advisory and credit will be published once remediation is safely deployed across the Ozone Chain network.

---

## 4. Minimum Security Requirements for ORC Standards

Every standard submitted to the ORC repository must adhere to the following baseline security rules:

1. **Reentrancy Protection**: State updates MUST precede external calls (Checks-Effects-Interactions pattern).
2. **Access Control**: Administrative and privileged functions MUST be protected by audited access control primitives.
3. **Allowance Front-Running Awareness**: Standards modifying token allowances MUST document race-condition considerations (recommending `approve(0)` patterns, custom errors, or `increaseAllowance`/`decreaseAllowance`).
4. **Signature Replay Protection**: Any EIP-712 / Permit extensions MUST include the `DOMAIN_SEPARATOR`, explicit `chainId`, nonce tracking, and expiration deadlines.
5. **Arithmetic Safety**: Arithmetic operations MUST rely on Solidity 0.8+ checked arithmetic.
6. **Custom Errors**: Reverts SHOULD use typed custom errors (`error InsufficientBalance()`) to avoid gas bloat and clarify revert reasons.

For a detailed security guide, see **[docs/security.md](docs/security.md)**.
