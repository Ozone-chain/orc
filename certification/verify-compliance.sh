#!/usr/bin/env bash
# ==============================================================================
# ORC-20 Compliance Verification Runner
# ==============================================================================
set -eo pipefail

echo "================================================================="
echo "        OZONE CHAIN — ORC-20 COMPLIANCE VERIFIER                 "
echo "================================================================="

if ! command -v forge &> /dev/null; then
    echo "[ERROR] Foundry (forge) is not installed. Please install foundry to run tests."
    exit 1
fi

echo "[INFO] Running official ORC-20 Compliance Test Suite..."
forge test --match-contract ORC20ComplianceTest -vv

echo ""
echo "[INFO] Running Edge Cases & Invariance Test Suite..."
forge test --match-contract ORC20EdgeCasesTest -vv

echo ""
echo "================================================================="
echo "       >>> [VERIFIED] ORC-20 COMPLIANCE TEST: PASSED <<<        "
echo "================================================================="
