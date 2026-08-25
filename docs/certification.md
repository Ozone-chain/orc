# How to Certify Your Token on Ozone Chain

This guide explains the step-by-step process for token authors to achieve **ORC-20 Certified** status.

---

## 1. Prerequisites

Before applying for certification:
1. Your token smart contract MUST be deployed to **Ozone Chain Mainnet** or **Ozone Chain Testnet**.
2. The contract source code MUST be verified on the official Ozone Chain Block Explorer.
3. The contract MUST implement all mandatory methods of `IORC20`.

---

## 2. Running Compliance Tests Locally

1. Fork and clone the ORC repository:
   ```bash
   git clone https://github.com/Ozone-chain/ORC.git
   cd ORC
   ```

2. Point the test harness to your deployed or local contract:
   ```bash
   ./certification/verify-compliance.sh
   ```

3. Confirm that all test suites pass with 0 failures:
   ```text
   [PASS] test_ORC20_Compliance_Summary()
   ```

---

## 3. Submitting for Official Certification

1. Open a Pull Request on the [Ozone-chain/ORC](https://github.com/Ozone-chain/ORC) repository.
2. Add an entry to `certification/registry.json`:
   ```json
   {
     "name": "My Project Token",
     "symbol": "MPTK",
     "address": "0x1234567890123456789012345678901234567890",
     "network": "ozone-mainnet",
     "explorerUrl": "https://ozonescan.io/token/0x1234...",
     "certifiedDate": "2026-08-24",
     "tier": "ORC-20 Certified"
   }
   ```
3. Attach the Forge compliance test output receipt to your Pull Request.
4. Once reviewed and merged by an ORC Editor, your project is officially listed in the registry and authorized to display the official badge.

---

## 4. Displaying the Badge

Add the official badge to your repository's `README.md`:

```markdown
[![ORC-20 Certified](https://img.shields.io/badge/ORC--20-Certified-success?logo=ethereum&logoColor=white)](https://github.com/Ozone-chain/ORC)
```
