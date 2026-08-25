# Ozone Chain Deployment & Verification Guide

This guide describes how to deploy and verify **ORC-20** contracts on **Ozone Chain** (Testnet and Mainnet) using Foundry.

---

## 1. Network Parameters

| Parameter | Value |
|:---|:---|
| **Network Name** | Ozone Chain Mainnet |
| **RPC Endpoint** | `https://node1.ozonechain.io` |
| **Chain ID** | `4000` |
| **Currency Symbol** | `OZO` |
| **Block Explorer** | `https://ozonescan.io` |
| **Verifier API** | `https://ozonescan.io/api` |

---

## 2. Prerequisites

1. Install **Foundry** if you haven't already:
   ```bash
   curl -L https://foundry.paradigm.xyz | bash
   foundryup
   ```
2. Fund your deployer wallet with native **OZO** (Ozone Chain native coin for gas).
3. Copy `.env.example` to `.env` and set your credentials:
   ```bash
   cp .env.example .env
   ```

---

## 2. Deploying via Foundry Script

Run the automated deployment script:

```bash
# Load environment variables
source .env

# Deploy to Ozone Chain Testnet / Mainnet
forge script script/DeployORC20.s.sol:DeployORC20 \
  --rpc-url $OZONE_RPC_URL \
  --broadcast \
  --legacy
```

---

## 3. Alternative: Direct CLI Deployment (`forge create`)

You can also deploy directly using `forge create`:

```bash
forge create contracts/reference/ORC20.sol:ORC20 \
  --rpc-url $OZONE_RPC_URL \
  --private-key $PRIVATE_KEY \
  --constructor-args "Ozone Reference Token" "ORC" \
  --legacy
```

---

## 4. Contract Verification on Ozone Block Explorer

To verify the deployed contract source code on the Ozone Chain Block Explorer:

```bash
forge verify-contract <DEPLOYED_CONTRACT_ADDRESS> contracts/reference/ORC20.sol:ORC20 \
  --verifier-url https://ozonescan.io/api \
  --constructor-args $(cast abi-encode "constructor(string,string)" "Ozone Reference Token" "ORC")
```

---

## 5. Updating the Official Registry

Once deployed and verified:
1. Open `certification/registry.json`.
2. Add or update the deployed contract entry with its network, contract address, and explorer verification link:
   ```json
   {
     "name": "Ozone Reference Token",
     "symbol": "ORC",
     "address": "0xYourDeployedAddressHere",
     "network": "ozone-mainnet",
     "explorerUrl": "https://ozonescan.io/token/0xYourDeployedAddressHere",
     "certifiedDate": "2026-08-24",
     "tier": "ORC-20 Reference Implementation",
     "status": "Active"
   }
   ```
3. Commit and submit a PR to update the registry in the official repository.
