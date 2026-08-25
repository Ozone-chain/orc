# ORC Token Certification Framework

This document outlines the official certification model for tokens deployed on **Ozone Chain**.

---

## 1. Certification Tiers

To provide transparent security and compliance information to DEXes, wallets, block explorers, and users, tokens on Ozone Chain are classified into four distinct tiers:

```text
┌─────────────────────────────────────────────────────────────┐
│  Tier 4: ORC-20 Reference Implementation                   │
│  - Maintained directly by Ozone Chain Core Team             │
│  - 100% compliant, audited, open-source                    │
├─────────────────────────────────────────────────────────────┤
│  Tier 3: ORC-20 Certified                                   │
│  - Passes 100% of official Foundry Compliance Suite         │
│  - Verified source code on Ozone Chain Block Explorer       │
│  - Public compliance receipt & badge granted                │
├─────────────────────────────────────────────────────────────┤
│  Tier 2: ORC-20 Compatible                                  │
│  - Implements canonical ORC-20 interface & semantics        │
│  - Handles zero-value transfers and standard allowances     │
├─────────────────────────────────────────────────────────────┤
│  Tier 1: ERC-20 Compatible                                  │
│  - Implements basic standard ERC-20 functions               │
│  - Legacy or migrated tokens from other EVM networks        │
└─────────────────────────────────────────────────────────────┘
```

---

## 2. Requirements per Tier

| Criteria | ERC-20 Compatible | ORC-20 Compatible | ORC-20 Certified | ORC Reference Implementation |
|:---|:---:|:---:|:---:|:---:|
| **Standard ABI Selectors** | Required | Required | Required | Required |
| **Zero-Value Transfer Success** | Optional | Required | Required | Required |
| **Standard Event Signatures** | Required | Required | Required | Required |
| **Infinite Allowance Opt.** | Optional | Recommended | Required | Required |
| **Passes `ORC20ComplianceTest`** | Not Tested | Manual Check | **100% Automated Pass** | **100% Automated Pass** |
| **Verified Source on Explorer** | Optional | Recommended | **Mandatory** | **Mandatory** |
| **Security Audit** | Optional | Recommended | Recommended | **Mandatory** |
| **Maintained by Ozone Core** | No | No | No | **Yes** |

---

## 3. How to Obtain "ORC-20 Certified" Status

1. **Implement Contract**: Author your token contract ensuring compliance with `IORC20` and `standards/ORC-20.md`.
2. **Run Compliance Suite**:
   ```bash
   ./certification/verify-compliance.sh contracts/your-token/MyToken.sol
   ```
3. **Deploy & Verify**: Deploy your contract to Ozone Chain Mainnet or Testnet and verify the source code on the official Ozone Chain Explorer.
4. **Submit Certification PR**:
   - Open a PR to the ORC repository adding a record under `certification/registry.json` containing:
     - Contract Address
     - Token Name & Symbol
     - Network (Mainnet / Testnet)
     - Explorer Verification Link
     - Link to CI Test Run / Verification Proof
5. **Badge Issuance**: Once verified by an ORC Editor, the official `ORC-20 Certified` badge is granted.

---

## 4. Official Badges

### ORC-20 Certified Badge
```markdown
[![ORC-20 Certified](https://img.shields.io/badge/ORC--20-Certified-success?logo=ethereum&logoColor=white)](https://github.com/Ozone-chain/ORC)
```

### ORC-20 Compatible Badge
```markdown
[![ORC-20 Compatible](https://img.shields.io/badge/ORC--20-Compatible-blue?logo=ethereum&logoColor=white)](https://github.com/Ozone-chain/ORC)
```

---

## 5. Revocation & Deprecation

Certification may be revoked if:
1. The contract is upgraded (via proxy) to a state that fails compliance checks.
2. A critical unmitigated security vulnerability or malicious backdoor is identified.
3. The token breaks standard ERC/ORC transfer semantics without clear documentation.
