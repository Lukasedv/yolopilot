#!/bin/bash
set -e

echo "🚀 Installing YoloPilot..."

# Pull the latest image
echo "📦 Pulling container image..."
docker pull ghcr.io/lukasedv/yolopilot:latest

# Determine install location
if [ "$(id -u)" = "0" ]; then
    INSTALL_DIR="/usr/local/bin"
else
    INSTALL_DIR="$HOME/.local/bin"
    mkdir -p "$INSTALL_DIR"
fi

# Create the yolopilot script
cat > "$INSTALL_DIR/yolopilot" << 'EOF'
#!/bin/bash
docker run -it --rm -v "$(pwd):/workspace" -w /workspace ghcr.io/lukasedv/yolopilot:latest sh -c "copilot --yolo; exec zsh"
EOF

chmod +x "$INSTALL_DIR/yolopilot"

# Check if install dir is in PATH
if [[ ":$PATH:" != *":$INSTALL_DIR:"* ]]; then
    echo ""
    echo "⚠️  Add this to your shell profile (.bashrc, .zshrc, etc.):"
    echo "   export PATH=\"\$PATH:$INSTALL_DIR\""
    echo ""
fi

echo "✅ YoloPilot installed! Run 'yolopilot' in any directory to start."
