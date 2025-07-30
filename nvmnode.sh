#!/bin/bash

# Complete NVM + Node.js + NPM Installation Fix
set -e

echo "🔧 Fixing NVM + Node.js + NPM installation..."

# Install curl if not available
apt-get update && apt-get install -y curl

# Remove any existing nvm installation
rm -rf ~/.nvm

# Fresh install of NVM
echo "⬇️ Fresh NVM installation..."
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash

# Load NVM immediately
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Verify NVM is loaded
echo "✅ NVM version: $(nvm --version)"

# Install latest Node.js (which includes npm)
echo "⬇️ Installing latest Node.js with npm..."
nvm install node
nvm use node
nvm alias default node

# Verify installations
echo "✅ Node.js version: $(node --version)"
echo "✅ NPM version: $(npm --version)"

# Update npm to latest
npm install -g npm@latest
echo "✅ Updated NPM version: $(npm --version)"

# Add to bashrc for persistence
echo "" >> ~/.bashrc
echo "# NVM Configuration" >> ~/.bashrc
echo 'export NVM_DIR="$HOME/.nvm"' >> ~/.bashrc
echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"' >> ~/.bashrc
echo '[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"' >> ~/.bashrc

echo "🎉 Installation complete! Run 'source ~/.bashrc' in new terminals."
echo "Current session is ready to use node and npm."
