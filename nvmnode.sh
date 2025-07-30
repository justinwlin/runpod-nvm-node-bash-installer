#!/bin/bash

# Install NVM + Latest Node.js Version for Docker
# This script installs nvm and the latest stable Node.js version

set -e  # Exit on any error

echo "🚀 Installing NVM and latest Node.js version..."

# Update system packages
echo "📦 Updating system packages..."
apt-get update

# Install required dependencies
echo "🔧 Installing dependencies..."
apt-get install -y curl wget build-essential

# Download and install NVM
echo "⬇️  Downloading NVM..."
NVM_VERSION="v0.39.5"  # Latest stable version as of Jan 2025
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/${NVM_VERSION}/install.sh | bash

# Load NVM into current shell
echo "🔄 Loading NVM..."
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Verify NVM installation
echo "✅ Verifying NVM installation..."
command -v nvm >/dev/null 2>&1 || { echo "❌ NVM installation failed"; exit 1; }
echo "NVM version: $(nvm --version)"

# Install latest stable Node.js
echo "⬇️  Installing latest stable Node.js..."
nvm install node  # 'node' is an alias for the latest version
nvm use node
nvm alias default node

# Verify Node.js and npm installation
echo "✅ Verifying Node.js installation..."
echo "Node.js version: $(node --version)"
echo "npm version: $(npm --version)"

# Update npm to latest version
echo "🔄 Updating npm to latest version..."
npm install -g npm@latest

# Add NVM to shell profile for persistence
echo "📝 Adding NVM to shell profile..."
cat >> ~/.bashrc << 'EOL'

# NVM configuration
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
EOL

# Clean up
echo "🧹 Cleaning up..."
apt-get autoremove -y
apt-get clean
rm -rf /var/lib/apt/lists/*

echo "🎉 Installation complete!"
echo "Node.js $(node --version) is now installed and ready to use."
echo ""
echo "To use in new shell sessions, run:"
echo "source ~/.bashrc"
echo ""
echo "Available nvm commands:"
echo "  nvm list                 # List installed versions"
echo "  nvm install <version>    # Install specific version"
echo "  nvm use <version>        # Switch to version"
echo "  nvm current              # Show current version"
