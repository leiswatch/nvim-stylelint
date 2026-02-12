# Version Check Automation

This directory contains scripts for automatically checking if a new version of `stylelint/vscode-stylelint` is available.

## Files

- **check-vscode-stylelint-version.sh**: Shell script that compares the current version in `build-eslint-language-server.sh` with the latest release from the `stylelint/vscode-stylelint` repository.

## How It Works

The script:

1. Extracts the current version from `VSCODE_STYLELINT_VERSION` variable in `build-stylelint-language-server.sh`
2. Fetches the latest non-prerelease version from the `stylelitn/vscode-stylelint` GitHub repository using the GitHub CLI
3. Compares the two versions
4. Sets GitHub Actions outputs for use in the workflow:
   - `up-to-date`: "true" if versions match, "false" otherwise
   - `current-version`: The version currently in use
   - `latest-version`: The latest available version

## GitHub Actions Workflow

The workflow (`.github/workflows/check-vscode-stylelint-version.yml`) runs:

- **Automatically**: Every Monday at 12:00 UTC
- **Manually**: Via workflow_dispatch trigger

When a new version is detected, it:

1. Creates a GitHub issue with:
   - Title: "Update vscode-stylelint to version X.Y.Z"
   - Detailed steps for upgrading
   - Links to release notes and relevant documentation
   - Labels: `dependencies`, `automation`

2. Checks for duplicate issues before creating a new one

## Testing

You can manually trigger the workflow from the GitHub Actions tab to test it:

1. Go to Actions → Check vscode-eslint Version
2. Click "Run workflow"
3. Select the branch
4. Click "Run workflow"

## Local Testing

To test the version check script locally:

```bash
# Set required environment variable for output
export GITHUB_OUTPUT=/tmp/github_output.txt

# Run the script
bash .github/scripts/check-vscode-stylelint-version.sh

# Check the outputs
cat $GITHUB_OUTPUT
```

Note: You'll need the GitHub CLI (`gh`) installed and authenticated to test locally.
