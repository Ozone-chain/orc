# Ecosystem Integration Guide (Wallets, DEXes, Explorers & Bridges)

This document provides technical integration specifications for infrastructure providers and dApp builders on **Ozone Chain**.

---

## 1. Wallet Integration (MetaMask, Rabby, Rainbow)

Wallets can treat ORC-20 tokens identically to ERC-20 tokens.

### 1.1 Adding Ozone Chain Network to Wallet (`wallet_addEthereumChain`)
```javascript
await window.ethereum.request({
  method: 'wallet_addEthereumChain',
  params: [
    {
      chainId: '0xFA0', // 4000 in hex
      chainName: 'Ozone Chain Mainnet',
      nativeCurrency: {
        name: 'Ozone',
        symbol: 'OZO',
        decimals: 18,
      },
      rpcUrls: ['https://node1.ozonechain.io'],
      blockExplorerUrls: ['https://ozonescan.io'],
    },
  ],
});
```

### 1.2 Adding an ORC-20 Token to Wallet (`wallet_watchAsset`)
```javascript
await window.ethereum.request({
  method: 'wallet_watchAsset',
  params: {
    type: 'ERC20', // Supported by standard EVM wallets
    options: {
      address: '0xYourTokenAddressHere',
      symbol: 'ORC',
      decimals: 18,
      image: 'https://ozonechain.io/assets/token.png',
    },
  },
});
```

---

## 2. Decentralized Exchange (DEX) Integration

DEXes (such as Uniswap v2/v3 style AMMs) can interact with ORC-20 tokens using standard router and factory patterns:

```solidity
// Standard UniswapV2Factory createPair works directly
address pair = factory.createPair(tokenA, tokenB);

// Standard UniswapV2Router02 swap works directly
router.swapExactTokensForTokens(
    amountIn,
    amountOutMin,
    path,
    msg.sender,
    deadline
);
```

### Critical Rules for DEX Integrators:
1. **Fee-on-Transfer Tokens**: Always verify actual balance changes using `balanceOf(address(this))` before and after transfers if supporting tokens with custom fee mechanics.
2. **Infinite Approvals**: ORC-20 reference tokens preserve `type(uint256).max` without decrementing allowances, saving gas on repeated user swaps.

---

## 3. Block Explorer Integration

Block explorers on Ozone Chain index ORC-20 transactions by listening to standard EVM event logs:

- **Transfer Event Topic**: `0xddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef`
- **Approval Event Topic**: `0x8c5be1e5ebec7d5bd14f71427d1e84f3dd0314c0f7b2291e5b200ac8c7c3b925`

No custom event schemas are required.
