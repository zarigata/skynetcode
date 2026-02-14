#!/bin/bash
# T-800 Agent Runner
# Runs the T-800 agent system

set -e

echo "╔════════════════════════════════════════════════════════════╗"
echo "║                    T-800 AGENT SYSTEM                      ║"
echo "║     Think → Question → Plan → Execute → Validate           ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo ""

# Check if opencode is installed
if ! command -v opencode &> /dev/null; then
    echo "Error: OpenCode CLI not found"
    echo "Please install OpenCode first: https://opencode.ai"
    exit 1
fi

# Configuration
AGENT_DIR=".opencode/agents"
T800_AGENT="t800"

# Check if T-800 agent exists
if [ ! -f "$AGENT_DIR/$T800_AGENT.md" ]; then
    echo "Error: T-800 agent not found at $AGENT_DIR/$T800_AGENT.md"
    echo "Please run ./scripts/install-t800.sh first"
    exit 1
fi

# Parse arguments
PROJECT_DESC=""
if [ "$1" ]; then
    PROJECT_DESC="$*"
fi

# Run T-800 agent
echo "Starting T-800 agent..."
echo ""

if [ "$PROJECT_DESC" ]; then
    echo "Project: $PROJECT_DESC"
    echo ""
    opencode --agent "$T800_AGENT" "$PROJECT_DESC"
else
    opencode --agent "$T800_AGENT"
fi
