# NPM Package Release Guide (`@ozonechain/orc`)

This document details the standardized release process and best practices for publishing official updates to the **`@ozonechain/orc`** developer package.

---

## 1. Release Architecture & Versioning Strategy

The repository follows **Semantic Versioning (SemVer)** for the developer SDK (`MAJOR.MINOR.PATCH`):

- **Patch (`1.0.x`)**: Bug fixes, documentation updates, or non-breaking typing improvements.
- **Minor (`1.x.0`)**: Backwards-compatible new standard ABIs, additional helper constants, or new interface types.
- **Major (`x.0.0`)**: Breaking changes in SDK exports, ABI restructuring, or minimum Node.js runtime bumps.

> [!NOTE]
> The **NPM package version** (`@ozonechain/orc`) and the **ORC specification versions** (e.g., ORC-1, ORC-20) are managed as independent concepts. Updating the TypeScript package does not modify official finalized standards documents unless a formal RFC amendment process has completed.

---

## 2. Pre-Release Checklist

Before creating a release, ensure all checks pass locally:

- [ ] All unit tests pass (`npm test`).
- [ ] TypeScript compilation builds cleanly without errors (`npm run build`).
- [ ] Tarball contents verified with dry-run (`npm --prefix packages/orc pack --dry-run`).
- [ ] No uncommitted sensitive files, tokens, or extraneous build artifacts.

---

## 3. Step-by-Step Release Workflow

### Step 1: Update Package Version

Update the version field in `packages/orc/package.json`:

```bash
# In packages/orc/ directory:
npm version patch # or minor / major
```

### Step 2: Build & Test Locally

```bash
# From repository root:
npm install
npm run build
npm test
```

### Step 3: Verify Package Contents (Dry-Run)

Ensure only the intended public distribution files (`dist/`, `README.md`, `LICENSE`, `package.json`) are included:

```bash
cd packages/orc
npm pack --dry-run
cd ../..
```

Expected output:
```text
npm notice package: @ozonechain/orc@1.0.0
npm notice Tarball Contents
npm notice 1.1kB LICENSE
npm notice 4.0kB README.md
npm notice ... dist/...
npm notice 1.2kB package.json
```

### Step 4: Commit Changes & Create Git Tag

```bash
git add .
git commit -m "release: @ozonechain/orc v1.0.0"
git tag -a v1.0.0 -m "Release @ozonechain/orc v1.0.0"
```

### Step 5: Push Branch and Tag

```bash
git push origin main
git push origin v1.0.0
```

---

## 4. Automated CI/CD Publishing (GitHub Actions)

When a version tag (`v*.*.*`) is pushed to GitHub, the workflow [`.github/workflows/npm-publish.yml`](../.github/workflows/npm-publish.yml) will automatically:
1. Check out repository code.
2. Set up Node.js 20.
3. Install dependencies and run test suite.
4. Compile TypeScript to `dist/`.
5. Execute `npm pack --dry-run` validation.
6. Publish to npm registry under `@ozonechain/orc` with `--access public` and `--provenance` cryptographic attestation.

### Required Secrets
Ensure the repository has configured the GitHub secret:
- `NPM_TOKEN`: Granular Automation Token from [npmjs.com](https://www.npmjs.com) with publish permissions for the `@ozonechain` scope.

---

## 5. Post-Release Verification

Test the published package in an external environment:

```bash
mkdir /tmp/verify-orc-pkg && cd /tmp/verify-orc-pkg
npm init -y
npm install @ozonechain/orc@latest

# Run verification one-liner
node -e "const { ORC20_ABI, ORC_STANDARD, OZONE_CHAIN_MAINNET } = require('@ozonechain/orc'); console.log('Verified:', ORC_STANDARD.name, 'Chain ID:', OZONE_CHAIN_MAINNET.id);"
```
