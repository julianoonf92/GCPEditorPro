#!/usr/bin/env bash

set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$repo_root"

npm ci --legacy-peer-deps
rm -rf dist
NODE_OPTIONS="${NODE_OPTIONS:+${NODE_OPTIONS} }--openssl-legacy-provider" npm run electron-build

# Make WebODM plugin
mkdir -p dist/plugin-staging/gcp-editor-pro
cp -R plugin/. dist/plugin-staging/gcp-editor-pro/
cp -R dist/gcp-editor-pro dist/plugin-staging/gcp-editor-pro/public
(
    cd dist/plugin-staging
    zip -qr ../GCPEditorPro-WebODM-Plugin.zip gcp-editor-pro
)

echo "Plugin created at $repo_root/dist/GCPEditorPro-WebODM-Plugin.zip"
