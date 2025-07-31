#!/bin/bash
# Complete NVM + Node.js + NPM + rsync + Claude Code Installation
set -e
echo "🔧 Installing development tools and dependencies..."

# Install essential packages including curl and rsync
echo "📦 Installing system packages..."
apt-get update && apt-get install -y curl rsync
echo "✅ rsync installed: $(rsync --version | head -1)"

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
echo "Current session is ready to use node, npm, rsync, and claude."

# Install Claude Code
echo "⬇️ Installing Claude Code..."
npm install -g @anthropic-ai/claude-code
echo "✅ Claude Code installed successfully!"

echo ""
echo "🎉 All tools installed successfully!"
echo "Available commands:"
echo "- node: Node.js JavaScript runtime"
echo "- npm: Node.js package manager"
echo "- rsync: File synchronization tool"
echo "- claude: AI-powered coding assistant"
echo ""
echo "📝 To start using Claude Code:"
echo "1. Navigate to your project directory: cd your-project"
echo "2. Run: claude"
echo "3. Follow the OAuth setup on first run"
