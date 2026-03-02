#!/bin/bash
set -e

echo "=== Claude Code Global Setup ==="
echo ""

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# -----------------------------------
# Step 1: Create ~/.claude directory
# -----------------------------------
echo "[1/5] Creating ~/.claude directory..."
mkdir -p ~/.claude
mkdir -p ~/.claude/agents

# -----------------------------------
# Step 2: Copy global CLAUDE.md
# -----------------------------------
echo "[2/5] Installing global CLAUDE.md..."
cp "$SCRIPT_DIR/CLAUDE.md" ~/.claude/CLAUDE.md
echo "  → ~/.claude/CLAUDE.md"

# -----------------------------------
# Step 3: Copy global settings.json
# -----------------------------------
echo "[3/5] Installing global settings.json..."
cp "$SCRIPT_DIR/settings.json" ~/.claude/settings.json
echo "  → ~/.claude/settings.json"

# -----------------------------------
# Step 4: Copy global agents
# -----------------------------------
echo "[4/5] Installing global agents..."
cp "$SCRIPT_DIR"/.claude/agents/*.md ~/.claude/agents/
echo "  → ~/.claude/agents/explorer.md"
echo "  → ~/.claude/agents/implementer.md"
echo "  → ~/.claude/agents/reviewer.md"

# -----------------------------------
# Step 5: Install Linear MCP server
# -----------------------------------
echo "[5/5] Linear MCP setup..."
echo ""

if command -v claude &> /dev/null; then
  echo "  To install the Linear MCP server, you need a Linear API key."
  echo "  Get one from: https://linear.app/settings/api"
  echo ""
  read -p "  Enter your Linear API key (or press Enter to skip): " LINEAR_KEY

  if [ -n "$LINEAR_KEY" ]; then
    claude mcp add --transport http linear --scope user \
      "https://mcp.linear.app/mcp" \
      --header "Authorization: Bearer $LINEAR_KEY"
    echo "  → Linear MCP server added!"
  else
    echo "  → Skipped. Run this later:"
    echo "    claude mcp add --transport http linear --scope user \\"
    echo "      https://mcp.linear.app/mcp \\"
    echo "      --header \"Authorization: Bearer YOUR_API_KEY\""
  fi
else
  echo "  → Claude CLI not found. Install it first, then run:"
  echo "    claude mcp add --transport http linear --scope user \\"
  echo "      https://mcp.linear.app/mcp \\"
  echo "      --header \"Authorization: Bearer YOUR_API_KEY\""
fi

echo ""
echo "=== Setup Complete ==="
echo ""
echo "Installed globally:"
echo "  ~/.claude/CLAUDE.md          → Workflow rules"
echo "  ~/.claude/settings.json      → Permissions & hooks"
echo "  ~/.claude/agents/            → Explorer, implementer, reviewer"
echo ""
echo "Per-repo (copy into any project):"
echo "  cp -r $SCRIPT_DIR/tasks your-repo/tasks"
echo ""
echo "Optional alias (add to ~/.zshrc or ~/.bashrc):"
echo "  alias cc='claude --permission-mode plan'"
