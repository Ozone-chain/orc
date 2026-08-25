import test from "node:test";
import assert from "node:assert/strict";
import { createRequire } from "node:module";
import { fileURLToPath } from "node:url";
import path from "node:path";

// 1. ESM Import Verification
import * as esmOrc from "../dist/index.js";

// 2. CommonJS Require Verification
const require = createRequire(import.meta.url);
const cjsOrc = require("../dist/index.js");

test("Package Exports - Metadata & Constants", () => {
  assert.equal(esmOrc.ORC_STANDARD.name, "Ozone Request for Comments");
  assert.equal(esmOrc.ORC_STANDARD.shortName, "ORC");
  assert.equal(esmOrc.ORC_STANDARD.version, "1.0.0");

  assert.equal(esmOrc.ORC20.standard, "ORC-20");
  assert.equal(esmOrc.ORC20.compatibleWith, "ERC-20");
  assert.equal(esmOrc.ORC20.status, "Final");

  assert.equal(esmOrc.OZONE_CHAIN_MAINNET.id, 4000);
  assert.equal(esmOrc.OZONE_CHAIN_MAINNET.nativeCurrency.symbol, "OZO");
});

test("Package Exports - Canonical ORC-20 ABI Functions", () => {
  const abi = esmOrc.ORC20_ABI;
  assert.ok(Array.isArray(abi), "ORC20_ABI must be an array");

  const functionNames = abi
    .filter((item) => item.type === "function")
    .map((item) => item.name);

  const requiredFunctions = [
    "totalSupply",
    "balanceOf",
    "transfer",
    "allowance",
    "approve",
    "transferFrom",
    "name",
    "symbol",
    "decimals",
  ];

  for (const fn of requiredFunctions) {
    assert.ok(functionNames.includes(fn), `Missing canonical function: ${fn}`);
  }
});

test("Package Exports - Canonical Events & Errors", () => {
  const abi = esmOrc.ORC20_ABI;

  const eventNames = abi
    .filter((item) => item.type === "event")
    .map((item) => item.name);

  assert.ok(eventNames.includes("Transfer"), "Missing Transfer event");
  assert.ok(eventNames.includes("Approval"), "Missing Approval event");

  const errorNames = abi
    .filter((item) => item.type === "error")
    .map((item) => item.name);

  assert.ok(errorNames.includes("ORC20InsufficientBalance"));
  assert.ok(errorNames.includes("ORC20InvalidSender"));
  assert.ok(errorNames.includes("ORC20InvalidReceiver"));
  assert.ok(errorNames.includes("ORC20InsufficientAllowance"));
  assert.ok(errorNames.includes("ORC20InvalidApprover"));
  assert.ok(errorNames.includes("ORC20InvalidSpender"));
});

test("CommonJS Compatibility", () => {
  assert.ok(cjsOrc.ORC20_ABI, "CommonJS require must export ORC20_ABI");
  assert.equal(cjsOrc.ORC_STANDARD.shortName, "ORC");
  assert.equal(cjsOrc.ORC20.standard, "ORC-20");
});
