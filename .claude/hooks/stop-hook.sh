#!/usr/bin/env bash
#
# T-800 Stop Hook - Auto-Continue for Autonomous Operation
#
# This hook runs when T-800 attempts to stop. It checks if all tasks
# are truly complete and either allows the stop or forces continuation.
#

set -e

MEMORY_DIR=".opencode/memory"
TASK_STATE="$MEMORY_DIR/task-state.json"
PROGRESS_LOG="$MEMORY_DIR/progress.json"
MAX_ITERATIONS=100

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
CYAN='\033[0;36m'
NC='\033[0m'

# Check if task state exists
if [ ! -f "$TASK_STATE" ]; then
    echo -e "${CYAN}No task state found. Allowing stop.${NC}"
    exit 0
fi

# Get current state
STATUS=$(jq -r '.meta.status // "unknown"' "$TASK_STATE" 2>/dev/null || echo "unknown")
TOTAL_ITERATIONS=$(jq -r '.meta.total_iterations // 0' "$TASK_STATE" 2>/dev/null || echo "0")
MAX_ITER=$(jq -r '.meta.max_iterations // 100' "$TASK_STATE" 2>/dev/null || echo "100")
INCOMPLETE=$(jq '[.tasks[] | select(.passes == false)] | length' "$TASK_STATE" 2>/dev/null || echo "0")

echo ""
echo -e "${RED}╔══════════════════════════════════════════════════════════════╗${NC}"
echo -e "${RED}║              T-800 STOP HOOK TRIGGERED                        ║${NC}"
echo -e "${RED}╚══════════════════════════════════════════════════════════════╝${NC}"
echo ""
echo -e "  ${CYAN}Status:${NC} $STATUS"
echo -e "  ${CYAN}Iterations:${NC} $TOTAL_ITERATIONS / $MAX_ITER"
echo -e "  ${CYAN}Tasks Remaining:${NC} $INCOMPLETE"
echo ""

# Check if all tasks complete
if [ "$INCOMPLETE" -eq 0 ]; then
    echo -e "${GREEN}✓ All tasks verified complete!${NC}"
    echo -e "${GREEN}✓ T-800 can stop.${NC}"
    
    # Update status
    if [ -f "$TASK_STATE" ]; then
        tmp=$(mktemp)
        jq '.meta.status = "completed"' "$TASK_STATE" > "$tmp" && mv "$tmp" "$TASK_STATE"
    fi
    
    echo ""
    echo -e "${GREEN}════════════════════════════════════════════════════════════${NC}"
    echo -e "${GREEN}  T-800 MISSION COMPLETE                                        ${NC}"
    echo -e "${GREEN}════════════════════════════════════════════════════════════${NC}"
    exit 0
fi

# Check if max iterations reached
if [ "$TOTAL_ITERATIONS" -ge "$MAX_ITER" ]; then
    echo -e "${YELLOW}⚠ Max iterations ($MAX_ITER) reached.${NC}"
    echo -e "${YELLOW}⚠ Stopping to prevent infinite loop.${NC}"
    
    if [ -f "$TASK_STATE" ]; then
        tmp=$(mktemp)
        jq '.meta.status = "max_iterations_reached"' "$TASK_STATE" > "$tmp" && mv "$tmp" "$TASK_STATE"
    fi
    
    exit 0
fi

# Tasks remain and iterations available - CONTINUE!
echo -e "${YELLOW}⏳ Tasks remaining: $INCOMPLETE${NC}"
echo -e "${RED}⟳ Forcing continuation...${NC}"
echo ""

# Update iteration counter
if [ -f "$TASK_STATE" ]; then
    tmp=$(mktemp)
    jq '.meta.total_iterations += 1' "$TASK_STATE" > "$tmp" && mv "$tmp" "$TASK_STATE"
fi

# Signal to continue
echo -e "${RED}╔══════════════════════════════════════════════════════════════╗${NC}"
echo -e "${RED}║  AUTO-CONTINUE: Starting next iteration...                   ║${NC}"
echo -e "${RED}╚══════════════════════════════════════════════════════════════╝${NC}"
echo ""

# Output continuation signal (Claude Code will read this)
echo "CONTINUE"
exit 1