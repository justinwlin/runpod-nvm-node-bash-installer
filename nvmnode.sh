#!/bin/bash
# Complete NVM + Node.js LTS + NPM + rsync + Claude Code Installation
# Uses Node 20 LTS (Iron) for stability and compatibility
set -e
echo "🔧 Installing development tools and dependencies..."

# Install essential packages including curl, rsync, and tmux
echo "📦 Installing system packages..."
apt-get update && apt-get install -y curl rsync tmux
echo "✅ rsync installed: $(rsync --version | head -1)"
echo "✅ tmux installed: $(tmux -V)"

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

# Install Node.js 20 LTS (Iron) for stability
echo "⬇️ Installing Node.js 20 LTS (Iron)..."
nvm install --lts=iron   # Node 20.x LTS
nvm use --lts=iron
nvm alias default lts/iron

# Verify installations
echo "✅ Node.js version: $(node --version)"
echo "✅ NPM version: $(npm --version)"

# Update npm to latest
npm install -g npm@latest
echo "✅ Updated NPM version: $(npm --version)"

# Clean up any existing Claude Code installations from all Node versions
echo "🧹 Cleaning up any existing Claude Code installations..."
for dir in ~/.nvm/versions/node/*; do
  if [ -d "$dir/lib/node_modules/@anthropic-ai/claude-code" ]; then
    echo "  Removing $dir/lib/node_modules/@anthropic-ai/claude-code"
    rm -rf "$dir/lib/node_modules/@anthropic-ai/claude-code"
    rm -f  "$dir/bin/claude" "$dir/bin/claude.cmd" "$dir/bin/claude.ps1"
  fi
done

# Refresh command hash table
hash -r

# Install Claude Code on Node 20 LTS
echo "⬇️ Installing Claude Code on Node 20 LTS..."
npm install -g @anthropic-ai/claude-code
echo "✅ Claude Code installed successfully!"

# Verify Claude Code installation
echo ""
echo "🔍 Verification:"
echo "  Node version: $(node -v)"
echo "  NPM version: $(npm -v)"
echo "  Claude binary: $(which claude || echo 'not found in PATH')"
if command -v claude &> /dev/null; then
  echo "  Claude version: $(claude --version 2>/dev/null || echo 'unable to get version')"
fi

# Add to bashrc for persistence
echo "" >> ~/.bashrc
echo "# NVM Configuration" >> ~/.bashrc
echo 'export NVM_DIR="$HOME/.nvm"' >> ~/.bashrc
echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"' >> ~/.bashrc
echo '[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"' >> ~/.bashrc

echo ""
echo "🎉 All tools installed successfully!"
echo "Available commands:"
echo "- node: Node.js JavaScript runtime (v20 LTS)"
echo "- npm: Node.js package manager"
echo "- rsync: File synchronization tool"
echo "- tmux: Terminal multiplexer"
echo "- claude: AI-powered coding assistant"
echo ""
echo "📝 To start using Claude Code:"
echo "1. Navigate to your project directory: cd your-project"
echo "2. Run: claude"
echo "3. Follow the OAuth setup on first run"
echo ""
echo "💡 Run 'source ~/.bashrc' in new terminals to use these tools."
