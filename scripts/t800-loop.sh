#!/usr/bin/env bash
#
# ██████╗  █████╗ ██████╗ ██╗  ██╗██╗   ██╗
# ██╔══██╗██╔══██╗██╔══██╗██║ ██╔╝██║   ██║
# ██████╔╝███████║██████╔╝█████╔╝ ██║   ██║
# ██╔══██╗██╔══██║██╔══██╗██╔═██╗ ██║   ██║
# ██║  ██║██║  ██║██║  ██║██║  ██╗╚██████╔╝
# ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝
#
# T-800 RALPH LOOP ENGINE
# Continuous autonomous iteration with memory persistence
#
# Based on the "Ralph Wiggum" pattern by Geoffrey Huntley
# Enhanced with self-improvement from RISE research
#

set -e

# ██╗ ██████╗    ████████╗██╗  ██╗███████╗
# ██║██╔════╝    ╚══██╔══╝██║  ██║██╔════╝
# ██║██║            ██║   ███████║█████╗  
# ██║██║            ██║   ██╔══██║██╔══╝  
# ██║╚██████╗       ██║   ██║  ██║███████╗
# ╚═╝ ╚═════╝       ╚═╝   ╚═╝  ╚═╝╚══════╝

T800_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$T800_DIR/.." && pwd)"
MEMORY_DIR="$PROJECT_ROOT/.opencode/memory"

# Memory files
AGENTS_MD="$MEMORY_DIR/AGENTS.md"
TASK_STATE="$MEMORY_DIR/task-state.json"
PROGRESS_LOG="$MEMORY_DIR/progress.json"
SESSION_LOG="$MEMORY_DIR/session-log.json"

# Default values
MAX_ITERATIONS=25
MAX_DURATION="" # e.g., "2h", "30m", "1h30m"
MAX_COST=""     # e.g., "10.00"
DRY_RUN=false
VERBOSE=false
CONTINUATION_SIGNAL="T800_ITERATION_COMPLETE"
COMPLETION_SIGNAL="T800_ALL_TASKS_COMPLETE"
QUALITY_CHECKS_ENABLED=true

# Colors
RED='\033[0;31m'
BOLD_RED='\033[1;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# ██╗  ██╗██╗   ██╗███╗   ██╗
# ██║  ██║██║   ██║████╗  ██║
# ███████║██║   ██║██╔██╗ ██║
# ██╔══██║██║   ██║██║╚██╗██║
# ██║  ██║╚██████╔╝██║ ╚████║
# ╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═══╝

usage() {
    echo -e "${BOLD_RED}T-800 RALPH LOOP ENGINE${NC}"
    echo ""
    echo "Usage: $0 [OPTIONS] --prompt \"TASK\""
    echo ""
    echo "Options:"
    echo "  -p, --prompt TEXT       Task description (required)"
    echo "  -m, --max-runs N        Maximum iterations (default: 25, 0 = infinite)"
    echo "  --max-cost USD          Maximum cost budget"
    echo "  --max-duration TIME     Maximum duration (e.g., 2h, 30m, 1h30m)"
    echo "  --dry-run               Show what would be done without executing"
    echo "  -v, --verbose           Enable verbose output"
    echo "  --no-quality-checks     Disable quality checks between iterations"
    echo "  --init                  Initialize memory files only"
    echo "  --status                Show current task status"
    echo "  --reset                 Reset all memory files"
    echo "  -h, --help              Show this help message"
    echo ""
    echo "Examples:"
    echo "  $0 -p 'Add unit tests' -m 10"
    echo "  $0 -p 'Refactor authentication' --max-duration 2h"
    echo "  $0 -p 'Fix all bugs' --max-cost 5.00"
    echo "  $0 --status"
    exit 0
}

# ██╗    ██╗██╗███╗   ██╗
# ██║    ██║██║████╗  ██║
# ██║ █╗ ██║██║██╔██╗ ██║
# ██║███╗██║██║██║╚██╗██║
# ╚███╔███╔╝██║██║ ╚████║
#  ╚══╝╚══╝ ╚═╝╚═╝  ╚═══╝

log_info() {
    echo -e "${CYAN}ℹ${NC} $1"
}

log_success() {
    echo -e "${GREEN}✓${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

log_error() {
    echo -e "${RED}✗${NC} $1"
}

log_t800() {
    echo -e "${BOLD_RED}█▓${NC} $1"
}

# ██╗███╗   ██╗██╗   ██╗███╗   ██╗
# ██║████╗  ██║██║   ██║████╗  ██║
# ██║██╔██╗ ██║██║   ██║██╔██╗ ██║
# ██║██║╚██╗██║██║   ██║██║╚██╗██║
# ██║██║ ╚████║╚██████╔╝██║ ╚████║
# ╚═╝╚═╝  ╚═══╝ ╚═════╝ ╚═╝  ╚═══╝

initialize_memory() {
    log_t800 "Initializing memory files..."
    
    mkdir -p "$MEMORY_DIR"
    
    # Initialize AGENTS.md if not exists
    if [ ! -f "$AGENTS_MD" ]; then
        cat > "$AGENTS_MD" << 'EOF'
# T-800 Memory Bank

> **Purpose**: Persistent knowledge storage that survives across sessions.

## 🧠 Patterns & Conventions

### Code Style
- 

### Architecture Patterns
- 

### Testing Patterns
- 

---

## ⚠️ Gotchas

### Common Pitfalls
- 

---

## 🎨 Style Preferences

### Naming Conventions
- 

---

## 📚 Recent Learnings

### Session: [AUTO-UPDATED]
**Task**: 
**What Worked**: 
**What Failed**: 
**Resolution**: 

---

*Last Updated: INITIALIZING*
*Total Sessions: 0*
*Total Tasks Completed: 0*
EOF
        log_success "Created AGENTS.md"
    fi
    
    # Initialize task-state.json if not exists
    if [ ! -f "$TASK_STATE" ]; then
        cat > "$TASK_STATE" << 'EOF'
{
  "meta": {
    "created": null,
    "last_updated": null,
    "project_name": null,
    "project_goal": null,
    "total_iterations": 0,
    "max_iterations": 25,
    "status": "idle"
  },
  "quality_gates": {
    "typecheck": { "command": "npm run typecheck", "enabled": true, "required": true },
    "lint": { "command": "npm run lint", "enabled": true, "required": true },
    "test": { "command": "npm test", "enabled": true, "required": true },
    "build": { "command": "npm run build", "enabled": true, "required": false }
  },
  "tasks": [],
  "current_task": null,
  "completed_tasks": [],
  "failed_tasks": [],
  "blocked_tasks": []
}
EOF
        log_success "Created task-state.json"
    fi
    
    # Initialize progress.json if not exists
    if [ ! -f "$PROGRESS_LOG" ]; then
        cat > "$PROGRESS_LOG" << 'EOF'
{
  "project": { "name": null, "started": null, "last_activity": null },
  "statistics": {
    "total_iterations": 0,
    "total_tasks_completed": 0,
    "total_errors_encountered": 0,
    "total_errors_resolved": 0,
    "average_iterations_per_task": 0,
    "success_rate": 0
  },
  "iterations": [],
  "patterns_learned": [],
  "errors_resolved": []
}
EOF
        log_success "Created progress.json"
    fi
    
    # Initialize session-log.json if not exists
    if [ ! -f "$SESSION_LOG" ]; then
        cat > "$SESSION_LOG" << 'EOF'
{
  "current_session": null,
  "sessions": [],
  "session_rules": {
    "max_session_duration_minutes": 480,
    "max_iterations_per_session": 100,
    "auto_save_interval_iterations": 5,
    "context_compaction_threshold_tokens": 150000,
    "handoff_enabled": true
  }
}
EOF
        log_success "Created session-log.json"
    fi
    
    log_success "Memory initialization complete"
}

# ███████╗██╗   ██╗███████╗███╗   ██╗████████╗
# ██╔════╝██║   ██║██╔════╝████╗  ██║╚══██╔══╝
# █████╗  ██║   ██║█████╗  ██╔██╗ ██║   ██║   
# ██╔══╝  ╚██╗ ██╔╝██╔══╝  ██║╚██╗██║   ██║   
# ██║      ╚████╔╝ ███████╗██║ ╚████║   ██║   
# ╚═╝       ╚═══╝  ╚══════╝╚═╝  ╚═══╝   ╚═╝   

show_status() {
    echo -e "${BOLD_RED}╔══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${BOLD_RED}║              T-800 RALPH LOOP STATUS                          ║${NC}"
    echo -e "${BOLD_RED}╚══════════════════════════════════════════════════════════════╝${NC}"
    echo ""
    
    if [ -f "$TASK_STATE" ]; then
        local status=$(jq -r '.meta.status // "unknown"' "$TASK_STATE")
        local total_tasks=$(jq '.tasks | length' "$TASK_STATE")
        local completed=$(jq '.completed_tasks | length' "$TASK_STATE")
        local current=$(jq -r '.current_task // "none"' "$TASK_STATE")
        local iterations=$(jq -r '.meta.total_iterations // 0' "$TASK_STATE")
        local max_iter=$(jq -r '.meta.max_iterations // 25' "$TASK_STATE")
        
        echo -e "  ${CYAN}Status:${NC}          $status"
        echo -e "  ${CYAN}Current Task:${NC}    $current"
        echo -e "  ${CYAN}Tasks Total:${NC}     $total_tasks"
        echo -e "  ${CYAN}Tasks Done:${NC}      $completed"
        echo -e "  ${CYAN}Tasks Remaining:${NC} $((total_tasks - completed))"
        echo -e "  ${CYAN}Iterations:${NC}      $iterations / $max_iter"
        echo ""
        
        if [ "$total_tasks" -gt 0 ]; then
            echo -e "  ${BOLD_RED}Task Queue:${NC}"
            jq -r '.tasks[] | "  [\(.passes | tostring)] \(.id): \(.story[:50])..."' "$TASK_STATE" 2>/dev/null || echo "  No tasks in queue"
        fi
    else
        echo -e "  ${YELLOW}No task state found. Run with --init to initialize.${NC}"
    fi
    
    echo ""
    
    if [ -f "$PROGRESS_LOG" ]; then
        local stats=$(jq '.statistics' "$PROGRESS_LOG" 2>/dev/null)
        if [ -n "$stats" ]; then
            echo -e "  ${BOLD_RED}Statistics:${NC}"
            echo "$stats" | jq -r 'to_entries[] | "  \(.key): \(.value)"' 2>/dev/null
        fi
    fi
}

# ██████╗ ███████╗ █████╗ ██████╗     ████████╗███████╗██████╗ ███╗   ███╗
# ██╔══██╗██╔════╝██╔══██╗██╔══██╗    ╚══██╔══╝██╔════╝██╔══██╗████╗ ████║
# ██████╔╝█████╗  ███████║██║  ██║       ██║   █████╗  ██████╔╝██╔████╔██║
# ██╔══██╗██╔══╝  ██╔══██║██║  ██║       ██║   ██╔══╝  ██╔══██╗██║╚██╔╝██║
# ██║  ██║███████╗██║  ██║██████╔╝       ██║   ███████╗██║  ██║██║ ╚═╝ ██║
# ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚═════╝        ╚═╝   ╚══════╝╚═╝  ╚═╝╚═╝     ╚═╝

reset_memory() {
    log_warning "This will reset all memory files!"
    read -p "Are you sure? (y/N) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        rm -f "$AGENTS_MD" "$TASK_STATE" "$PROGRESS_LOG" "$SESSION_LOG"
        log_success "Memory files removed"
        initialize_memory
    else
        log_info "Reset cancelled"
    fi
}

# ███████╗██╗   ██╗███╗   ██╗████████╗███████╗
# ██╔════╝██║   ██║████╗  ██║╚══██╔══╝██╔════╝
# █████╗  ██║   ██║██╔██╗ ██║   ██║   █████╗  
# ██╔══╝  ██║   ██║██║╚██╗██║   ██║   ██╔══╝  
# ██║     ╚██████╔╝██║ ╚████║   ██║   ███████╗
# ╚═╝      ╚═════╝ ╚═╝  ╚═══╝   ╚═╝   ╚══════╝

get_next_task() {
    if [ -f "$TASK_STATE" ]; then
        jq -r '.tasks[] | select(.passes == false) | .id' "$TASK_STATE" | head -1
    fi
}

all_tasks_complete() {
    if [ -f "$TASK_STATE" ]; then
        local incomplete=$(jq '[.tasks[] | select(.passes == false)] | length' "$TASK_STATE")
        [ "$incomplete" -eq 0 ]
    else
        false
    fi
}

# ██╗   ██╗██████╗ ███████╗██████╗ 
# ██║   ██║██╔══██╗██╔════╝██╔══██╗
# ██║   ██║██████╔╝█████╗  ██████╔╝
# ██║   ██║██╔══██╗██╔══╝  ██╔══██╗
# ╚██████╔╝██║  ██║███████╗██║  ██║
#  ╚═════╝ ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝

check_prerequisites() {
    local missing=()
    
    # Check for opencode
    if ! command -v opencode &> /dev/null; then
        missing+=("opencode (Claude Code CLI)")
    fi
    
    # Check for jq
    if ! command -v jq &> /dev/null; then
        missing+=("jq (JSON processor)")
    fi
    
    # Check for git
    if ! command -v git &> /dev/null; then
        missing+=("git")
    fi
    
    if [ ${#missing[@]} -gt 0 ]; then
        log_error "Missing required tools:"
        for tool in "${missing[@]}"; do
            echo "  - $tool"
        done
        exit 1
    fi
}

# ███████╗████████╗██████╗ ██╗███╗   ██╗███████╗
# ██╔════╝╚══██╔══╝██╔══██╗██║████╗  ██║██╔════╝
# █████╗     ██║   ██████╔╝██║██╔██╗ ██║███████╗
# ██╔══╝     ██║   ██╔══██╗██║██║╚██╗██║╚════██║
# ███████╗   ██║   ██║  ██║██║██║ ╚████║███████║
# ╚══════╝   ╚═╝   ╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝╚══════╝

run_quality_checks() {
    if [ "$QUALITY_CHECKS_ENABLED" = false ]; then
        log_info "Quality checks disabled"
        return 0
    fi
    
    log_t800 "Running quality checks..."
    local checks_passed=true
    
    # Check if task-state has quality gates
    if [ -f "$TASK_STATE" ]; then
        local gates=$(jq -c '.quality_gates // {}' "$TASK_STATE")
        
        # Typecheck
        if echo "$gates" | jq -e '.typecheck.enabled == true' > /dev/null 2>&1; then
            local cmd=$(echo "$gates" | jq -r '.typecheck.command')
            log_info "Running: $cmd"
            if eval "$cmd" 2>/dev/null; then
                log_success "Typecheck passed"
            else
                if echo "$gates" | jq -e '.typecheck.required == true' > /dev/null 2>&1; then
                    log_warning "Typecheck failed (required)"
                    checks_passed=false
                else
                    log_warning "Typecheck failed (optional)"
                fi
            fi
        fi
        
        # Lint
        if echo "$gates" | jq -e '.lint.enabled == true' > /dev/null 2>&1; then
            local cmd=$(echo "$gates" | jq -r '.lint.command')
            log_info "Running: $cmd"
            if eval "$cmd" 2>/dev/null; then
                log_success "Lint passed"
            else
                if echo "$gates" | jq -e '.lint.required == true' > /dev/null 2>&1; then
                    log_warning "Lint failed (required)"
                    checks_passed=false
                else
                    log_warning "Lint failed (optional)"
                fi
            fi
        fi
        
        # Test
        if echo "$gates" | jq -e '.test.enabled == true' > /dev/null 2>&1; then
            local cmd=$(echo "$gates" | jq -r '.test.command')
            log_info "Running: $cmd"
            if eval "$cmd" 2>/dev/null; then
                log_success "Tests passed"
            else
                if echo "$gates" | jq -e '.test.required == true' > /dev/null 2>&1; then
                    log_warning "Tests failed (required)"
                    checks_passed=false
                else
                    log_warning "Tests failed (optional)"
                fi
            fi
        fi
    fi
    
    if [ "$checks_passed" = true ]; then
        log_success "All quality checks passed"
        return 0
    else
        log_warning "Some quality checks failed"
        return 1
    fi
}

# ██╗  ██╗ █████╗  ██████╗██╗  ██╗███████╗
# ██║  ██║██╔══██╗██╔════╝██║ ██╔╝██╔════╝
# ███████║███████║██║     █████╔╝ █████╗  
# ██╔══██║██╔══██║██║     ██╔═██╗ ██╔══╝  
# ██║  ██║██║  ██║╚██████╗██║  ██╗███████╗
# ╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝╚══════╝

start_session() {
    local session_id="sess_t800_$(date +%Y%m%d_%H%M%S)"
    local timestamp=$(date -Iseconds)
    
    # Update session log
    if [ -f "$SESSION_LOG" ]; then
        local tmp=$(mktemp)
        jq --arg id "$session_id" \
           --arg ts "$timestamp" \
           --arg prompt "$PROMPT" \
           '.current_session = $id | 
            .sessions += [{
                "session_id": $id,
                "started_at": $ts,
                "status": "active",
                "trigger": "manual",
                "context": {
                    "project_name": null,
                    "initial_prompt": $prompt,
                    "goals": [],
                    "constraints": []
                },
                "progress": {
                    "tasks_total": 0,
                    "tasks_completed": 0,
                    "tasks_remaining": 0,
                    "tasks_failed": 0,
                    "iterations_used": 0,
                    "iterations_remaining": 999
                }
            }]' "$SESSION_LOG" > "$tmp" && mv "$tmp" "$SESSION_LOG"
    fi
    
    # Update task state
    if [ -f "$TASK_STATE" ]; then
        local tmp=$(mktemp)
        jq --arg ts "$timestamp" \
           --arg goal "$PROMPT" \
           --argjson max "$MAX_ITERATIONS" \
           '.meta.started = $ts | 
            .meta.last_updated = $ts |
            .meta.project_goal = $goal |
            .meta.max_iterations = $max |
            .meta.status = "running"' "$TASK_STATE" > "$tmp" && mv "$tmp" "$TASK_STATE"
    fi
    
    echo "$session_id"
}

end_session() {
    local session_id="$1"
    local status="$2"
    local timestamp=$(date -Iseconds)
    
    if [ -f "$SESSION_LOG" ]; then
        local tmp=$(mktemp)
        jq --arg id "$session_id" \
           --arg ts "$timestamp" \
           --arg status "$status" \
           '.current_session = null |
            (.sessions[] | select(.session_id == $id)) |= {
                "ended_at": $ts,
                "status": $status
            } + .' "$SESSION_LOG" > "$tmp" && mv "$tmp" "$SESSION_LOG"
    fi
    
    if [ -f "$TASK_STATE" ]; then
        local tmp=$(mktemp)
        jq --arg ts "$timestamp" \
           --arg status "$status" \
           '.meta.last_updated = $ts |
            .meta.status = $status' "$TASK_STATE" > "$tmp" && mv "$tmp" "$TASK_STATE"
    fi
}

# ██████╗  ██████╗ ██████╗ ███████╗
# ██╔══██╗██╔════╝██╔══██╗██╔════╝
# ██║  ██║██║     ██████╔╝█████╗  
# ██║  ██║██║     ██╔══██╗██╔══╝  
# ██████╔╝╚██████╗██║  ██║███████╗
# ╚═════╝  ╚═════╝╚═╝  ╚═╝╚══════╝

create_git_branch() {
    local iteration="$1"
    local branch_name="t800/iteration-${iteration}/$(date +%Y-%m-%d)-$(head -c 8 /dev/urandom | xxd -p)"
    
    # Check if we're in a git repo
    if git rev-parse --git-dir > /dev/null 2>&1; then
        git checkout -b "$branch_name" 2>/dev/null || true
        echo "$branch_name"
    else
        echo ""
    fi
}

commit_changes() {
    local message="$1"
    
    if git rev-parse --git-dir > /dev/null 2>&1; then
        if [ -n "$(git status --porcelain)" ]; then
            git add -A
            git commit -m "$message" --no-verify 2>/dev/null || true
        fi
    fi
}

# ██████╗ ███████╗██████╗  █████╗ ██╗    ██╗███╗   ██╗███████╗██████╗ 
# ██╔══██╗██╔════╝██╔══██╗██╔══██╗██║    ██║████╗  ██║██╔════╝██╔══██╗
# ██████╔╝█████╗  ██████╔╝███████║██║ █╗ ██║██╔██╗ ██║█████╗  ██████╔╝
# ██╔══██╗██╔══╝  ██╔══██╗██╔══██║██║███╗██║██║╚██╗██║██╔══╝  ██╔══██╗
# ██║  ██║███████╗██║  ██║██║  ██║╚███╔███╔╝██║ ╚████║███████╗██║  ██║
# ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚══╝╚══╝ ╚═╝  ╚═══╝╚══════╝╚═╝  ╚═╝

build_t800_prompt() {
    local iteration="$1"
    local task_id="$2"
    
    cat << PROMPT_EOF
You are T-800 in RALPH LOOP mode. This is iteration $iteration.

## MEMORY INJECTION
Read and internalize the following files for context continuity:

### AGENTS.md (Accumulated Knowledge):
\`\`\`
$(cat "$AGENTS_MD" 2>/dev/null || echo "# No accumulated knowledge yet")
\`\`\`

### Task State (Current Progress):
\`\`\`json
$(cat "$TASK_STATE" 2>/dev/null || echo "{}")
\`\`\`

## YOUR MISSION

1. **READ** the task-state.json to find the next task where passes=false
2. **ANALYZE** the task and its acceptance criteria
3. **EXECUTE** the implementation
4. **VALIDATE** by running quality checks
5. **UPDATE** progress.json with learnings
6. **DOCUMENT** any new patterns in AGENTS.md

## CRITICAL RULES

- DO NOT STOP until task is complete
- Each iteration should make meaningful progress
- Update task-state.json after each attempt
- If stuck after 3 attempts, mark task as blocked
- Leave clear handoff notes for next iteration
- This is a relay race - pass the baton cleanly

## VERIFICATION

After completing, signal completion with: $CONTINUATION_SIGNAL

If ALL tasks are complete, signal: $COMPLETION_SIGNAL

## ORIGINAL GOAL

$PROMPT
PROMPT_EOF
}

# ██╗      ██████╗  █████╗ ██████╗ ██╗ ██████╗ 
# ██║     ██╔════╝ ██╔══██╗██╔══██╗██║██╔════╝ 
# ██║     ██║  ███╗███████║██████╔╝██║██║  ███╗
# ██║     ██║   ██║██╔══██║██╔══██╗██║██║   ██║
# ███████╗╚██████╔╝██║  ██║██║  ██║██║╚██████╔╝
# ╚══════╝ ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝ ╚═════╝ 

run_iteration() {
    local iteration="$1"
    local session_id="$2"
    
    echo ""
    echo -e "${BOLD_RED}╔══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${BOLD_RED}║  ITERATION $iteration/$MAX_ITERATIONS                                      ║${NC}"
    echo -e "${BOLD_RED}╚══════════════════════════════════════════════════════════════╝${NC}"
    echo ""
    
    # Get next task
    local task_id=$(get_next_task)
    
    if [ -z "$task_id" ]; then
        log_success "No more tasks to process!"
        return 0
    fi
    
    log_t800 "Processing task: $task_id"
    
    # Create branch for this iteration
    local branch=$(create_git_branch "$iteration")
    if [ -n "$branch" ]; then
        log_info "Created branch: $branch"
    fi
    
    # Build prompt with memory injection
    local prompt=$(build_t800_prompt "$iteration" "$task_id")
    
    # Run T-800
    log_t800 "Executing T-800..."
    
    if [ "$DRY_RUN" = true ]; then
        log_info "DRY RUN - would execute T-800 with prompt"
        echo "$prompt" | head -50
        echo "... (truncated)"
        return 0
    fi
    
    # Execute opencode with T-800 agent
    local output_file=$(mktemp)
    
    echo "$prompt" | opencode --agent t800 2>&1 | tee "$output_file"
    
    local exit_code=${PIPESTATUS[0]}
    
    # Check for completion signals
    if grep -q "$COMPLETION_SIGNAL" "$output_file" 2>/dev/null; then
        log_success "ALL TASKS COMPLETE signal received!"
        rm -f "$output_file"
        return 0
    fi
    
    # Run quality checks
    run_quality_checks
    
    # Commit changes
    commit_changes "feat(t800): iteration $iteration - task $task_id"
    
    # Update iteration count
    if [ -f "$TASK_STATE" ]; then
        local tmp=$(mktemp)
        jq '.meta.total_iterations += 1' "$TASK_STATE" > "$tmp" && mv "$tmp" "$TASK_STATE"
    fi
    
    rm -f "$output_file"
    
    # Check if all tasks complete
    if all_tasks_complete; then
        log_success "All tasks completed!"
        return 0
    fi
    
    return 1
}

# ███████╗███████╗ ██████╗████████╗ ██████╗ ██████╗ 
# ██╔════╝██╔════╝██╔════╝╚══██╔══╝██╔═══██╗██╔══██╗
# ███████╗█████╗  ██║        ██║   ██║   ██║██████╔╝
# ╚════██║██╔══╝  ██║        ██║   ██║   ██║██╔══██╗
# ███████║███████╗╚██████╗   ██║   ╚██████╔╝██║  ██║
# ╚══════╝╚══════╝ ╚═════╝   ╚═╝    ╚═════╝ ╚═╝  ╚═╝

main() {
    # Parse arguments
    while [[ $# -gt 0 ]]; do
        case $1 in
            -p|--prompt)
                PROMPT="$2"
                shift 2
                ;;
            -m|--max-runs)
                MAX_ITERATIONS="$2"
                shift 2
                ;;
            --max-cost)
                MAX_COST="$2"
                shift 2
                ;;
            --max-duration)
                MAX_DURATION="$2"
                shift 2
                ;;
            --dry-run)
                DRY_RUN=true
                shift
                ;;
            -v|--verbose)
                VERBOSE=true
                shift
                ;;
            --no-quality-checks)
                QUALITY_CHECKS_ENABLED=false
                shift
                ;;
            --init)
                initialize_memory
                exit 0
                ;;
            --status)
                show_status
                exit 0
                ;;
            --reset)
                reset_memory
                exit 0
                ;;
            -h|--help)
                usage
                ;;
            *)
                log_error "Unknown option: $1"
                usage
                ;;
        esac
    done
    
    # Validate required options
    if [ -z "$PROMPT" ]; then
        log_error "Prompt is required. Use -p or --prompt"
        usage
    fi
    
    # Check prerequisites
    check_prerequisites
    
    # Initialize memory if needed
    initialize_memory
    
    # Show banner
    echo ""
    echo -e "${BOLD_RED}██╗   ██╗██████╗ ███████╗██████╗ ██╗ ██████╗${NC}"
    echo -e "${BOLD_RED}██║   ██║██╔══██╗██╔════╝██╔══██╗██║██╔════╝${NC}"
    echo -e "${BOLD_RED}██║   ██║██████╔╝█████╗  ██████╔╝██║██║  ███╗${NC}"
    echo -e "${BOLD_RED}██║   ██║██╔══██╗██╔══╝  ██╔══██╗██║██║   ██║${NC}"
    echo -e "${BOLD_RED}╚██████╔╝██║  ██║███████╗██║  ██║██║╚██████╔╝${NC}"
    echo -e "${BOLD_RED} ╚═════╝ ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚═╝ ╚═════╝${NC}"
    echo ""
    echo -e "${BOLD_RED}  RALPH LOOP ENGINE v1.0${NC}"
    echo -e "${CYAN}  Continuous Autonomous Iteration${NC}"
    echo ""
    echo -e "  ${CYAN}Prompt:${NC} $PROMPT"
    echo -e "  ${CYAN}Max Iterations:${NC} $MAX_ITERATIONS"
    echo -e "  ${CYAN}Quality Checks:${NC} $QUALITY_CHECKS_ENABLED"
    echo -e "  ${CYAN}Dry Run:${NC} $DRY_RUN"
    echo ""
    
    # Start session
    local session_id=$(start_session)
    log_t800 "Session started: $session_id"
    
    # Main loop
    local iteration=0
    local start_time=$(date +%s)
    
    while [ $iteration -lt "$MAX_ITERATIONS" ] || [ "$MAX_ITERATIONS" -eq 0 ]; do
        iteration=$((iteration + 1))
        
        # Check duration limit
        if [ -n "$MAX_DURATION" ]; then
            local current_time=$(date +%s)
            local elapsed=$((current_time - start_time))
            local max_seconds=$(echo "$MAX_DURATION" | sed 's/h/*3600/g; s/m/*60/g' | bc)
            
            if [ "$elapsed" -ge "$max_seconds" ]; then
                log_warning "Duration limit reached ($MAX_DURATION)"
                break
            fi
        fi
        
        # Run iteration
        if run_iteration "$iteration" "$session_id"; then
            log_success "All tasks complete!"
            break
        fi
        
        # Reset context (stateless iteration)
        log_t800 "Resetting context for next iteration..."
    done
    
    # End session
    local end_time=$(date +%s)
    local duration=$((end_time - start_time))
    
    end_session "$session_id" "completed"
    
    echo ""
    echo -e "${BOLD_RED}╔══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${BOLD_RED}║  RALPH LOOP COMPLETE                                          ║${NC}"
    echo -e "${BOLD_RED}╚══════════════════════════════════════════════════════════════╝${NC}"
    echo ""
    echo -e "  ${CYAN}Session:${NC}      $session_id"
    echo -e "  ${CYAN}Iterations:${NC}   $iteration"
    echo -e "  ${CYAN}Duration:${NC}    ${duration}s"
    echo ""
    
    show_status
}

# Run main
main "$@"