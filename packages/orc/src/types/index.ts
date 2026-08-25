/**
 * Token metadata attributes defined in ORC-20 optional extensions.
 */
export interface ORC20Metadata {
  name: string;
  symbol: string;
  decimals: number;
}

/**
 * Standard parameters for an ORC-20 token deployment or query.
 */
export interface ORC20TokenDetails extends ORC20Metadata {
  address: `0x${string}` | string;
  totalSupply?: bigint | string;
}

/**
 * Metadata descriptor for an ORC standard specification.
 */
export interface ORCStandardInfo {
  standard: string;
  title: string;
  version: string;
  status: "Draft" | "Review" | "Last Call" | "Final" | "Withdrawn" | "Superseded";
  compatibleWith?: string;
  category: "Core" | "Token" | "Interface" | "Application" | "Process";
}

/**
 * Specification details for the ORC framework.
 */
export interface ORCFrameworkConfig {
  name: string;
  shortName: string;
  version: string;
  specificationUrl: string;
}

/**
 * Network configuration object representation.
 */
export interface OzoneNetworkConfig {
  id: number;
  name: string;
  network: string;
  nativeCurrency: {
    name: string;
    symbol: string;
    decimals: number;
  };
  rpcUrls: {
    default: { http: readonly string[] };
    public: { http: readonly string[] };
  };
  blockExplorers?: {
    default: { name: string; url: string };
  };
}
