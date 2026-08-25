# ORC-20 Developer Guide

This guide walks you through creating, testing, and deploying an **ORC-20** token on **Ozone Chain**.

---

## 1. Quick Start: Authoring an ORC-20 Token

Create a new Solidity contract inheriting from the official `ORC20` reference implementation:

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {ORC20} from "@ozone-chain/orc/contracts/reference/ORC20.sol";

contract MyOzoneToken is ORC20 {
    address public owner;

    modifier onlyOwner() {
        require(msg.sender == owner, "Unauthorized");
        _;
    }

    constructor(
        string memory name,
        string memory symbol,
        uint256 initialSupply
    ) ORC20(name, symbol) {
        owner = msg.sender;
        _mint(msg.sender, initialSupply);
    }

    /// @notice Allows the owner to mint additional tokens.
    function mint(address to, uint256 amount) external onlyOwner {
        _mint(to, amount);
    }

    /// @notice Allows any holder to burn their tokens.
    function burn(uint256 amount) external {
        _burn(msg.sender, amount);
    }
}
```

---

## 2. Compiling with Foundry

Install dependencies and compile:

```bash
forge build
```

---

## 3. Writing Unit Tests

Test token functionality using Forge:

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";
import {MyOzoneToken} from "../contracts/MyOzoneToken.sol";

contract MyOzoneTokenTest is Test {
    MyOzoneToken public token;
    address public alice = address(0x1);
    address public bob = address(0x2);

    function setUp() public {
        token = new MyOzoneToken("My Token", "MTK", 1000 ether);
    }

    function test_Transfer() public {
        token.transfer(alice, 100 ether);
        assertEq(token.balanceOf(alice), 100 ether);
    }
}
```

Run tests:
```bash
forge test
```

---

## 4. Ozone Chain Network Details

| Parameter | Value |
|:---|:---|
| **RPC Endpoint** | `https://node1.ozonechain.io` |
| **Chain ID** | `4000` |
| **Currency Symbol** | `OZO` |
| **Block Explorer** | `https://ozonescan.io` |

---

## 5. Deploying to Ozone Chain

Deploy your token using `forge create` or a Foundry script:

```bash
forge create contracts/MyOzoneToken.sol:MyOzoneToken \
  --rpc-url https://node1.ozonechain.io \
  --private-key <YOUR_PRIVATE_KEY> \
  --constructor-args "My Ozone Token" "MOT" 1000000000000000000000000 \
  --legacy
```
