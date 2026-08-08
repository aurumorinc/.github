# `.github` — Aurumor Inc. Organization Health & Governance

Welcome to the central `.github` repository for **Aurumor Inc.** This repository serves as the single source of truth for organization-wide governance, shared CI/CD workflows, semantic versioning policies, default issue/PR templates, and pre-built GitHub Actions infrastructure.

---

## 🚀 Repository Contents

```text
.github/
├── .github/
│   ├── pull_request_template.md             # Default Pull Request template for org repositories
│   └── workflows/
│       ├── release.yaml                     # Reusable Semantic Release workflow (LLM-driven)
│       └── build-llm-release-action.yaml    # Maintenance workflow for pre-built action container
├── .agents/                                 # Agent skills and MCP configurations
│   └── skills/
│       └── llm-release-action/             # AI Agent skill for llm-release-action
├── images/
│   └── llm-action-release/                  # Container build & Goss test specifications
│       ├── action.yaml                      # Action definition
│       ├── Dockerfile                       # Container image setup
│       ├── entrypoint.sh                    # Action entrypoint script
│       └── goss.yaml                        # Goss test suite for container health
├── scripts/
│   ├── build.sh                             # Script to build Docker image
│   └── test.sh                              # Script to run dgoss validation tests
├── Makefile                                 # Build automation (make build, test, push)
└── VERSIONING.md                            # Global Semantic Versioning 2.0.0 policy
```

---

## 🛠 Shared Workflows

### 1. Reusable Semantic Release Workflow ([`.github/workflows/release.yaml`](.github/workflows/release.yaml:1))

A central, reusable workflow designed to automate releases across Aurumor Inc. repositories using AI-powered commit analysis and automated version bumping (`bumpver`).

#### Usage in Downstream Repositories

Add a `.github/workflows/release.yml` file in your repository:

```yaml
name: Release

on:
  push:
    branches:
      - main

jobs:
  release:
    uses: aurumorinc/.github/.github/workflows/release.yaml@main
    with:
      model: 'gemini/gemini-3.5-flash-lite'
      versioning: 'global'
      dry_run: false
    secrets:
      RELEASE_TOKEN: ${{ secrets.GITHUB_TOKEN }}
      GEMINI_API_KEY: ${{ secrets.GEMINI_API_KEY }}
```

#### Inputs & Options

| Input | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `model` | `string` | `gemini/gemini-3.5-flash-lite` | LiteLLM model string used for commit analysis. |
| `dry_run` | `boolean` | `false` | When `true`, analyzes commits without creating git tags or GitHub releases. |
| `versioning` | `string` | `global` | `global` combines global `VERSIONING.md` with local guidelines; `workspace` uses local only. |

---

### 2. LLM Release Action Container Maintenance ([`.github/workflows/build-llm-release-action.yaml`](.github/workflows/build-llm-release-action.yaml:1))

A scheduled maintenance workflow that periodically builds, validates, and publishes the pre-built Docker image for `llm-release-action` to GitHub Container Registry (`ghcr.io/aurumorinc/llm-action-release:latest`).

* **Triggers**: Schedule (Weekly on Sundays at 03:00 UTC), manual `workflow_dispatch`, and re-usable `workflow_call`.

---

## 📜 Governance & Versioning Policy

### Global Versioning ([`VERSIONING.md`](VERSIONING.md:1))

All repositories under Aurumor Inc. adhere to [Semantic Versioning 2.0.0](https://semver.org/) with specific organizational rules:

1. **Initial Development Phase (`0.x.x`)**:
   * Automated systems MUST NOT produce a `major` bump while current version starts with `0.y.z`. All breaking changes produce a `minor` bump instead.
2. **`1.0.0` Baseline Transition**:
   * Transitioning from `0.x.x` to `1.0.0` establishes the public API baseline. Any breaking changes in that transition establish `1.0.0` and MUST NOT trigger `2.0.0`.
3. **Environment Variables**:
   * Changes to environment variables are NOT treated as breaking API changes.

---

## 🧪 Local Container Build & Testing

The pre-built action container image can be built, tested, and published locally using the included [`Makefile`](Makefile:1) and Goss test suite.

### Available Makefile Commands

```bash
# Build the Docker image locally
make build IMAGE=llm-action-release TAG=latest

# Run Goss container validation tests using dgoss
make test IMAGE=llm-action-release TAG=latest

# Execute both build and test in sequence
make all IMAGE=llm-action-release TAG=latest

# Push the built image to GHCR
make push IMAGE=llm-action-release TAG=latest
```

### Testing Harness details

* [`scripts/test.sh`](scripts/test.sh:1) downloads a pinned version of `goss` and `dgoss` (`v0.4.8`) into `./.bin/`.
* [`images/llm-action-release/goss.yaml`](images/llm-action-release/goss.yaml:1) validates required system tools (`git`, `jq`, `curl`, `python3`), source code structure, and Python package imports (`litellm`, `boto3`, `pydantic`, `yaml`, `langcodes`, etc.).

---

## 📄 License

All shared workflows, scripts, and documentation in this repository are licensed under the terms of the [MIT License](LICENSE).
