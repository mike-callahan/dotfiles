#!/usr/bin/env bash
# Bootstrap script: installs Homebrew (if missing) then applies the Brewfile
# alongside this script.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BREWFILE="$SCRIPT_DIR/Brewfile"

if ! command -v brew >/dev/null 2>&1; then
	echo "==> Installing Homebrew"
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	if [[ -x /opt/homebrew/bin/brew ]]; then
		eval "$(/opt/homebrew/bin/brew shellenv)"
	fi
fi

echo "==> Applying Brewfile: $BREWFILE"
brew bundle install --file="$BREWFILE"
