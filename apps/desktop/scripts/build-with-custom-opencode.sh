#!/bin/bash
set -e

# Custom opencode path
CUSTOM_OPENCODE="/Users/jakob.boghdady/myself/github/jakoberpf/fork-opencode/packages/opencode/dist/opencode-darwin-arm64/bin/opencode"
SIDECAR_DIR="$(dirname "$0")/../src-tauri/sidecars"

echo "Building OpenWork with custom opencode..."

# Run prepare-sidecar to get all other sidecars
echo "Preparing sidecars..."
node "$(dirname "$0")/prepare-sidecar.mjs"

# Replace opencode with custom version
echo "Replacing opencode with custom version..."
if [ -f "$CUSTOM_OPENCODE" ]; then
    cp "$CUSTOM_OPENCODE" "$SIDECAR_DIR/opencode"
    cp "$CUSTOM_OPENCODE" "$SIDECAR_DIR/opencode-aarch64-apple-darwin"
    chmod +x "$SIDECAR_DIR/opencode"
    chmod +x "$SIDECAR_DIR/opencode-aarch64-apple-darwin"
    echo "Custom opencode installed successfully"
else
    echo "ERROR: Custom opencode not found at $CUSTOM_OPENCODE"
    exit 1
fi

# Build UI
echo "Building UI..."
cd ../..
pnpm --filter @openwork/app build
