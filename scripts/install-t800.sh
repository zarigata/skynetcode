#!/bin/bash
# T-800 Installation Script
# Installs the complete T-800 agent ecosystem

set -e

echo "╔════════════════════════════════════════════════════════════╗"
echo "║              T-800 Agent System Installer                  ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo ""

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Installation counters
INSTALLED=0
SKIPPED=0

# Function to check/create directory
ensure_dir() {
    local dir=$1
    if [ ! -d "$dir" ]; then
        echo -e "${YELLOW}Creating directory: $dir${NC}"
        mkdir -p "$dir"
    fi
}

# Function to verify file
verify_file() {
    local file=$1
    local desc=$2
    
    if [ -f "$file" ]; then
        echo -e "${GREEN}✓ $desc${NC}"
        ((INSTALLED++))
        return 0
    else
        echo -e "${YELLOW}✗ $desc - Not found${NC}"
        return 1
    fi
}

echo "Step 1: Creating directory structure..."
echo ""

ensure_dir ".opencode/agents"
ensure_dir ".opencode/context/core"
ensure_dir ".opencode/context/project-intelligence"
ensure_dir ".opencode/skills"
ensure_dir ".opencode/workflows"
ensure_dir ".opencode/commands"
ensure_dir "tests/agents"
ensure_dir "tests/integration"
ensure_dir "scripts"
ensure_dir "docs"

echo ""
echo "Step 2: Verifying agent files..."
echo ""

verify_file ".opencode/agents/t800.md" "Main T-800 agent"
verify_file ".opencode/agents/t800-questioner.md" "Questioner subagent"
verify_file ".opencode/agents/t800-planner.md" "Planner subagent"
verify_file ".opencode/agents/t800-executor.md" "Executor subagent"

echo ""
echo "Step 3: Verifying context files..."
echo ""

verify_file ".opencode/context/core/t800-standards.md" "Coding standards"
verify_file ".opencode/context/core/t800-workflows.md" "Workflow definitions"
verify_file ".opencode/context/project-intelligence/questioning-strategies.md" "Questioning strategies"
verify_file ".opencode/context/project-intelligence/planning-templates.md" "Planning templates"

echo ""
echo "Step 4: Verifying skill files..."
echo ""

verify_file ".opencode/skills/t800-questioning.md" "Questioning skill"
verify_file ".opencode/skills/t800-planning.md" "Planning skill"
verify_file ".opencode/skills/t800-execution.md" "Execution skill"

echo ""
echo "Step 5: Verifying test files..."
echo ""

verify_file "tests/agents/t800-main.test.md" "Main agent tests"
verify_file "tests/agents/t800-questioner.test.md" "Questioner tests"
verify_file "tests/agents/t800-planner.test.md" "Planner tests"
verify_file "tests/integration/t800-workflow.test.md" "Integration tests"

echo ""
echo "Step 6: Verifying scripts..."
echo ""

verify_file "scripts/test-agents.sh" "Test runner"
verify_file "scripts/validate-config.sh" "Configuration validator"
verify_file "scripts/run-t800.sh" "T-800 runner"

echo ""
echo "Step 7: Verifying documentation..."
echo ""

verify_file "docs/t800-README.md" "README"
verify_file "docs/t800-ARCHITECTURE.md" "Architecture"
verify_file "docs/t800-USAGE.md" "Usage guide"

echo ""
echo "═══════════════════════════════════════════════════════════"
echo -e "${GREEN}Installation Complete!${NC}"
echo ""
echo "Files verified: $INSTALLED"
echo ""
echo "Quick Start:"
echo "  1. Run: ./scripts/run-t800.sh \"your project description\""
echo "  2. Or: opencode --agent t800"
echo ""
echo "Documentation:"
echo "  - docs/t800-README.md - Quick start guide"
echo "  - docs/t800-ARCHITECTURE.md - System architecture"
echo "  - docs/t800-USAGE.md - Detailed usage"
echo "═══════════════════════════════════════════════════════════"
