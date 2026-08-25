/**
 * Core metadata describing the Ozone Request for Comments (ORC) standards framework.
 */
export const ORC_STANDARD = {
  name: "Ozone Request for Comments",
  shortName: "ORC",
  version: "1.0.0",
  specificationUrl: "https://github.com/Ozone-chain/orc",
} as const;

/**
 * Metadata and specification attributes for the ORC-20 standard.
 */
export const ORC20 = {
  standard: "ORC-20",
  title: "Ozone Fungible Token Standard",
  version: "1.0.0",
  status: "Final",
  compatibleWith: "ERC-20",
  category: "Token",
} as const;

/**
 * Network details for Ozone Chain Mainnet.
 */
export const OZONE_CHAIN_MAINNET = {
  id: 4000,
  name: "Ozone Chain Mainnet",
  network: "ozone-chain",
  nativeCurrency: {
    name: "Ozone",
    symbol: "OZO",
    decimals: 18,
  },
  rpcUrls: {
    default: {
      http: ["https://node1.ozonechain.io"],
    },
    public: {
      http: ["https://node1.ozonechain.io"],
    },
  },
  blockExplorers: {
    default: {
      name: "OzoneScan",
      url: "https://ozonescan.io",
    },
  },
} as const;

/**
 * Canonical ORC-20 event signatures.
 */
export const ORC20_EVENTS = {
  Transfer: "Transfer(address,address,uint256)",
  Approval: "Approval(address,address,uint256)",
} as const;

/**
 * Standard typed custom error signatures.
 */
export const ORC20_ERRORS = [
  "ORC20InsufficientBalance(address,uint256,uint256)",
  "ORC20InvalidSender(address)",
  "ORC20InvalidReceiver(address)",
  "ORC20InsufficientAllowance(address,uint256,uint256)",
  "ORC20InvalidApprover(address)",
  "ORC20InvalidSpender(address)",
] as const;
