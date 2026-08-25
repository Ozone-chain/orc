# @ozonechain/orc

Official JavaScript and TypeScript developer package for **Ozone Request for Comments (ORC)** standards on **[Ozone Chain](https://ozonechain.io/)**.

[![npm version](https://img.shields.io/npm/v/@ozonechain/orc.svg)](https://www.npmjs.com/package/@ozonechain/orc)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![EVM Compatible](https://img.shields.io/badge/EVM-100%25_Compatible-brightgreen.svg)](https://ozonechain.io)

---

## Overview

The `@ozonechain/orc` package provides lightweight, zero-dependency, type-safe ABI definitions, constants, network parameters, and TypeScript interfaces for developing decentralized applications and tooling on Ozone Chain.

- **100% ERC-20 Compatibility**: Full interoperability with existing EVM wallets, AMMs, and libraries.
- **Zero Runtime Dependencies**: Ultra-lightweight footprint suitable for frontends, backends, and embedded scripts.
- **Strict TypeScript & `as const` ABIs**: Full type inference out of the box with `viem`, `wagmi`, `ethers`, and `web3.js`.

---

## Installation

```bash
npm install @ozonechain/orc
```

Or using yarn / pnpm:

```bash
yarn add @ozonechain/orc
# or
pnpm add @ozonechain/orc
```

---

## Usage Examples

### 1. With `viem`

```typescript
import { createPublicClient, http } from "viem";
import { ORC20_ABI, OZONE_CHAIN_MAINNET } from "@ozonechain/orc";

const client = createPublicClient({
  transport: http(OZONE_CHAIN_MAINNET.rpcUrls.default.http[0]),
});

async function getTokenBalance(tokenAddress: `0x${string}`, account: `0x${string}`) {
  const balance = await client.readContract({
    address: tokenAddress,
    abi: ORC20_ABI,
    functionName: "balanceOf",
    args: [account],
  });

  console.log(`Balance: ${balance}`);
  return balance;
}
```

### 2. With `ethers.js` (v6)

```typescript
import { ethers } from "ethers";
import { ORC20_ABI, OZONE_CHAIN_MAINNET } from "@ozonechain/orc";

const provider = new ethers.JsonRpcProvider(OZONE_CHAIN_MAINNET.rpcUrls.default.http[0]);

async function getDecimalsAndSymbol(tokenAddress: string) {
  const contract = new ethers.Contract(tokenAddress, ORC20_ABI, provider);

  const [symbol, decimals] = await Promise.all([
    contract.symbol(),
    contract.decimals(),
  ]);

  console.log(`Token: ${symbol}, Decimals: ${decimals}`);
  return { symbol, decimals };
}
```

### 3. Accessing Standard Metadata & Constants

```typescript
import { ORC_STANDARD, ORC20, OZONE_CHAIN_MAINNET } from "@ozonechain/orc";

console.log(ORC_STANDARD.name);       // "Ozone Request for Comments"
console.log(ORC20.standard);          // "ORC-20"
console.log(ORC20.compatibleWith);    // "ERC-20"
console.log(OZONE_CHAIN_MAINNET.id);  // 4000
```

---

## Exports

| Export | Type | Description |
|:---|:---|:---|
| `ORC20_ABI` | `const` array | Canonical ORC-20 ABI with functions, events (`Transfer`, `Approval`), and custom revert errors. |
| `ORC20_CORE_ABI` | `const` array | Minimal core subset of ORC-20 functions and events. |
| `ORC_STANDARD` | `object` | Metadata regarding the ORC specification ecosystem. |
| `ORC20` | `object` | Standard descriptor for the ORC-20 fungible token standard. |
| `OZONE_CHAIN_MAINNET` | `object` | Canonical chain configuration for Ozone Chain (Chain ID: `4000`). |
| `ORC20_EVENTS` | `object` | Event signatures for ORC-20. |
| `ORC20_ERRORS` | `array` | Standard custom error definitions. |

---

## Standards and Compatibility

ORC operates at the smart contract interface layer and is fully compatible with standard EVM technologies. All ORC-20 tokens deployed on Ozone Chain maintain exact function selector and event parity with ERC-20 standards.

- Specification: [ORC-20 Specification](https://github.com/Ozone-chain/orc/blob/main/standards/ORC-20.md)
- Process & Governance: [ORC-1](https://github.com/Ozone-chain/orc/blob/main/process/ORC-1.md)

---

## License

MIT © [Ozone Chain Core Architecture Team](https://ozonechain.io/)
