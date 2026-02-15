#!/usr/bin/env bash
#
# ██╗    ██╗ █████╗ ██╗     ██╗     ███████╗██████╗ 
# ██║    ██║██╔══██╗██║     ██║     ██╔════╝██╔══██╗
# ██║ █╗ ██║███████║██║     ██║     █████╗  ██████╔╝
# ██║███╗██║██╔══██║██║     ██║     ██╔══╝  ██╔══██╗
# ╚███╔███╔╝██║  ██║███████╗███████╗███████╗██║  ██║
#  ╚══╝╚══╝ ╚═╝  ╚═╝╚══════╝╚══════╝╚══════╝╚═╝  ╚═╝
#
# WATCHDOG - T-800 Supervisor and Recovery Agent
# Monitors T-800 for stuck states, errors, and loops
# Automatically recovers and restarts when needed
#

set -e

# Configuration
WATCHDOG_DIR=".opencode/memory"
WATCHDOG_LOG="$WATCHDOG_DIR/watchdog.json"
WATCHDOG_CONFIG="$WATCHDOG_DIR/watchdog-config.json"
TASK_STATE="$WATCHDOG_DIR/task-state.json"
PROGRESS_LOG="$WATCHDOG_DIR/progress.json"
AGENTS_MD="$WATCHDOG_DIR/AGENTS.md"

# Default thresholds (can be overridden by config)
CHECK_INTERVAL=30
STUCK_THRESHOLD=120
ERROR_THRESHOLD=3
LOOP_WINDOW=10
LOOP_SIMILARITY_THRESHOLD=0.9
MAX_RECOVERY_ATTEMPTS=3
CONTEXT_OVERFLOW_THRESHOLD=180000

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m'

# State tracking
LAST_ACTIVITY_FILE="/tmp/t800_last_activity"
LAST_TOOL_CALL_FILE="/tmp/t800_last_tool"
STUCK_COUNTER_FILE="/tmp/t800_stuck_counter"
ERROR_COUNTER_FILE="/tmp/t800_error_counter"
LAST_ACTIONS_FILE="/tmp/t800_last_actions"

# Initialize watchdog
init_watchdog() {
    mkdir -p "$WATCHDOG_DIR"
    
    # Create watchdog.json if not exists
    if [ ! -f "$WATCHDOG_LOG" ]; then
        cat > "$WATCHDOG_LOG" << EOF
{
  "session_id": "watchdog_$(date +%Y%m%d_%H%M%S)",
  "started_at": "$(date -Iseconds)",
  "status": "monitoring",
  "health": {
    "last_activity": null,
    "last_file_change": null,
    "last_tool_call": null,
    "current_task": null,
    "stuck_counter": 0,
    "error_counter": 0,
    "loop_counter": 0,
    "recovery_attempts": 0
  },
  "events": [],
  "recovery_history": []
}
EOF
    fi
    
    # Initialize counters
    echo "0" > "$STUCK_COUNTER_FILE" 2>/dev/null || true
    echo "0" > "$ERROR_COUNTER_FILE" 2>/dev/null || true
    echo "" > "$LAST_ACTIONS_FILE" 2>/dev/null || true
    date +%s > "$LAST_ACTIVITY_FILE" 2>/dev/null || true
    
    log_watchdog "initialized" "Watchdog supervisor started"
}

# Log to watchdog.json
log_watchdog() {
    local type="$1"
    local details="$2"
    
    if [ -f "$WATCHDOG_LOG" ]; then
        local tmp=$(mktemp)
        jq --arg type "$type" \
           --arg details "$details" \
           --arg timestamp "$(date -Iseconds)" \
           '.events += [{"timestamp": $timestamp, "type": $type, "details": $details}]' \
           "$WATCHDOG_LOG" > "$tmp" 2>/dev/null && mv "$tmp" "$WATCHDOG_LOG" || true
    fi
}

# Update health status
update_health() {
    local key="$1"
    local value="$2"
    
    if [ -f "$WATCHDOG_LOG" ]; then
        local tmp=$(mktemp)
        jq --arg key "$key" \
           --arg value "$value" \
           '.health[$key] = $value' \
           "$WATCHDOG_LOG" > "$tmp" 2>/dev/null && mv "$tmp" "$WATCHDOG_LOG" || true
    fi
}

# Check if stuck (no activity for threshold seconds)
check_stuck() {
    if [ ! -f "$LAST_ACTIVITY_FILE" ]; then
        return 1
    fi
    
    local last_activity=$(cat "$LAST_ACTIVITY_FILE" 2>/dev/null || echo "0")
    local now=$(date +%s)
    local elapsed=$((now - last_activity))
    
    if [ "$elapsed" -gt "$STUCK_THRESHOLD" ]; then
        echo -e "${YELLOW}⚠ STUCK DETECTED: No activity for ${elapsed}s${NC}"
        return 0
    fi
    
    return 1
}

# Check for loop (repeated actions)
check_loop() {
    if [ ! -f "$LAST_ACTIONS_FILE" ]; then
        return 1
    fi
    
    local actions=$(cat "$LAST_ACTIONS_FILE" 2>/dev/null)
    local unique=$(echo "$actions" | sort | uniq | wc -l)
    local total=$(echo "$actions" | wc -l)
    
    if [ "$total" -ge 3 ] && [ "$unique" -le 2 ]; then
        echo -e "${YELLOW}⚠ LOOP DETECTED: Repeated $unique unique actions out of $total${NC}"
        return 0
    fi
    
    return 1
}

# Record action for loop detection
record_action() {
    local action="$1"
    echo "$action" >> "$LAST_ACTIONS_FILE"
    
    # Keep only last N actions
    tail -n "$LOOP_WINDOW" "$LAST_ACTIONS_FILE" > "${LAST_ACTIONS_FILE}.tmp"
    mv "${LAST_ACTIONS_FILE}.tmp" "$LAST_ACTIONS_FILE"
}

# Update activity timestamp
update_activity() {
    date +%s > "$LAST_ACTIVITY_FILE"
    update_health "last_activity" "$(date -Iseconds)"
}

# Recovery Strategy 1: Gentle Nudge
recovery_gentle_nudge() {
    echo -e "${CYAN}→ RECOVERY: Gentle nudge${NC}"
    
    local current_task="unknown"
    if [ -f "$TASK_STATE" ]; then
        current_task=$(jq -r '.current_task // "unknown"' "$TASK_STATE" 2>/dev/null || echo "unknown")
    fi
    
    log_watchdog "recovery_gentle_nudge" "Injecting continuation prompt for task $current_task"
    
    # Increment stuck counter
    local counter=$(cat "$STUCK_COUNTER_FILE" 2>/dev/null || echo "0")
    counter=$((counter + 1))
    echo "$counter" > "$STUCK_COUNTER_FILE"
    
    # Output continuation signal that T-800 loop can pick up
    cat << 'CONTINUATION'
================================================================================
⚡ WATCHDOG RECOVERY: GENTLE NUDGE
================================================================================

No progress detected in the last 2 minutes.

CURRENT STATE:
- Task: Check task-state.json for current_task
- Last Activity: Check progress.json for last iteration

REQUIRED ACTION:
1. If stuck on current task, either:
   a) Try a DIFFERENT approach
   b) Mark task as BLOCKED with reason
   c) Skip to next task

2. Update task-state.json with your decision

3. Signal continuation: T800_RECOVERED

================================================================================
CONTINUATION

    update_health "stuck_counter" "$counter"
    return 0
}

# Recovery Strategy 2: Context Refresh
recovery_context_refresh() {
    echo -e "${YELLOW}→ RECOVERY: Context refresh${NC}"
    
    log_watchdog "recovery_context_refresh" "Refreshing context and creating handoff"
    
    # Create handoff summary
    local handoff_file="$WATCHDOG_DIR/handoff-$(date +%Y%m%d_%H%M%S).md"
    
    cat > "$handoff_file" << EOF
# T-800 Watchdog Handoff

**Generated**: $(date -Iseconds)
**Reason**: Context refresh after stuck state

## Current State

### Task Status
$(if [ -f "$TASK_STATE" ]; then jq '.tasks[] | select(.passes == false) | {id, story, attempts}' "$TASK_STATE" 2>/dev/null; else echo "No task state available"; fi)

### Recent Progress
$(if [ -f "$PROGRESS_LOG" ]; then jq '.iterations[-3:][] | {iteration: .iteration_number, task: .task_id, status: .status}' "$PROGRESS_LOG" 2>/dev/null; else echo "No progress log available"; fi)

## Recovery Notes

The T-800 agent was stuck and has been restarted with a fresh context.

**IMPORTANT**: 
1. Read AGENTS.md for accumulated patterns
2. Check handoff notes above for where to continue
3. Update task-state.json with current status

## Signal Continuation

After recovery, output: T800_RECOVERED
EOF
    
    echo -e "${GREEN}✓ Handoff created: $handoff_file${NC}"
    
    # Reset counters
    echo "0" > "$STUCK_COUNTER_FILE"
    echo "0" > "$ERROR_COUNTER_FILE"
    
    update_health "recovery_attempts" "1"
    log_watchdog "recovery_context_refresh_complete" "Handoff saved to $handoff_file"
    
    return 0
}

# Recovery Strategy 3: Full Restart
recovery_full_restart() {
    echo -e "${RED}→ RECOVERY: Full restart${NC}"
    
    log_watchdog "recovery_full_restart" "Performing full session restart"
    
    # Mark current task as blocked if too many attempts
    local stuck_counter=$(cat "$STUCK_COUNTER_FILE" 2>/dev/null || echo "0")
    local error_counter=$(cat "$ERROR_COUNTER_FILE" 2>/dev/null || echo "0")
    local total_attempts=$((stuck_counter + error_counter))
    
    if [ "$total_attempts" -ge "$MAX_RECOVERY_ATTEMPTS" ]; then
        if [ -f "$TASK_STATE" ]; then
            local current_task=$(jq -r '.current_task // ""' "$TASK_STATE" 2>/dev/null)
            if [ -n "$current_task" ]; then
                local tmp=$(mktemp)
                jq --arg task "$current_task" \
                   '(.tasks[] | select(.id == $task)) |= .blocked = true | 
                    (.tasks[] | select(.id == $task)) |= .block_reason = "Multiple recovery attempts failed"' \
                   "$TASK_STATE" > "$tmp" 2>/dev/null && mv "$tmp" "$TASK_STATE"
                
                echo -e "${RED}✗ Task $current_task marked as BLOCKED${NC}"
                log_watchdog "task_blocked" "Task $current_task blocked after $total_attempts recovery attempts"
            fi
        fi
    fi
    
    # Reset all counters
    echo "0" > "$STUCK_COUNTER_FILE"
    echo "0" > "$ERROR_COUNTER_FILE"
    echo "" > "$LAST_ACTIONS_FILE"
    
    update_health "stuck_counter" "0"
    update_health "error_counter" "0"
    update_health "recovery_attempts" "0"
    update_health "status" "restarted"
    
    # Output full restart signal
    cat << 'RESTART'
================================================================================
🔴 WATCHDOG RECOVERY: FULL RESTART
================================================================================

Previous session ended due to persistent stuck state.

RECOVERY ACTIONS TAKEN:
1. Session state preserved in watchdog.json
2. Learnings saved to AGENTS.md
3. Task state updated in task-state.json
4. Counters reset

INSTRUCTIONS FOR FRESH SESSION:
1. READ AGENTS.md for accumulated patterns
2. READ task-state.json for current task status
3. CHECK for any BLOCKED tasks
4. CONTINUE from first non-complete, non-blocked task

SIGNAL: T800_RESTART_REQUIRED

================================================================================
RESTART

    return 0
}

# Main monitoring loop
monitor() {
    echo -e "${GREEN}╔══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${GREEN}║              T-800 WATCHDOG SUPERVISOR                        ║${NC}"
    echo -e "${GREEN}╚══════════════════════════════════════════════════════════════╝${NC}"
    echo ""
    echo -e "  ${CYAN}Check Interval:${NC}    ${CHECK_INTERVAL}s"
    echo -e "  ${CYAN}Stuck Threshold:${NC}  ${STUCK_THRESHOLD}s"
    echo -e "  ${CYAN}Error Threshold:${NC}  ${ERROR_THRESHOLD}"
    echo -e "  ${CYAN}Max Recovery:${NC}     ${MAX_RECOVERY_ATTEMPTS}"
    echo ""
    echo -e "  ${GREEN}Monitoring T-800...${NC}"
    echo ""
    
    while true; do
        # Check for stuck state
        if check_stuck; then
            local stuck_counter=$(cat "$STUCK_COUNTER_FILE" 2>/dev/null || echo "0")
            
            echo -e "${YELLOW}Stuck counter: $stuck_counter${NC}"
            
            # Recovery strategy based on stuck counter
            if [ "$stuck_counter" -lt 2 ]; then
                recovery_gentle_nudge
            elif [ "$stuck_counter" -lt 4 ]; then
                recovery_context_refresh
            else
                recovery_full_restart
                break  # Exit after full restart
            fi
        fi
        
        # Check for loop
        if check_loop; then
            log_watchdog "loop_detected" "Repeated actions detected"
            recovery_gentle_nudge
        fi
        
        # Sleep before next check
        sleep "$CHECK_INTERVAL" 2>/dev/null || break
    done
}

# Watch for file changes (called by hooks)
watch_file_change() {
    update_activity
    record_action "file_change:$1"
}

# Watch for tool calls (called by hooks)
watch_tool_call() {
    update_activity
    record_action "tool:$1"
    
    # Update last tool call in health
    update_health "last_tool_call" "$1"
    
    echo "$1" > "$LAST_TOOL_CALL_FILE"
}

# Watch for errors (called by hooks)
watch_error() {
    local error_type="$1"
    local error_details="$2"
    
    log_watchdog "error_detected" "{\"type\": \"$error_type\", \"details\": \"$error_details\"}"
    
    local counter=$(cat "$ERROR_COUNTER_FILE" 2>/dev/null || echo "0")
    counter=$((counter + 1))
    echo "$counter" > "$ERROR_COUNTER_FILE"
    
    update_health "error_counter" "$counter"
    
    echo -e "${RED}✗ Error detected: $error_type${NC}"
    echo -e "${YELLOW}  Error counter: $counter${NC}"
    
    if [ "$counter" -ge "$ERROR_THRESHOLD" ]; then
        echo -e "${RED}Error threshold reached, triggering recovery${NC}"
        recovery_gentle_nudge
    fi
}

# Show watchdog status
show_status() {
    echo -e "${GREEN}╔══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${GREEN}║              T-800 WATCHDOG STATUS                            ║${NC}"
    echo -e "${GREEN}╚══════════════════════════════════════════════════════════════╝${NC}"
    echo ""
    
    if [ -f "$WATCHDOG_LOG" ]; then
        echo -e "${CYAN}Session:${NC} $(jq -r '.session_id // "unknown"' "$WATCHDOG_LOG" 2>/dev/null)"
        echo -e "${CYAN}Status:${NC} $(jq -r '.status // "unknown"' "$WATCHDOG_LOG" 2>/dev/null)"
        echo -e "${CYAN}Started:${NC} $(jq -r '.started_at // "unknown"' "$WATCHDOG_LOG" 2>/dev/null)"
        echo ""
        echo -e "${CYAN}Health:${NC}"
        jq '.health' "$WATCHDOG_LOG" 2>/dev/null || echo "  No health data"
        echo ""
        echo -e "${CYAN}Recent Events:${NC}"
        jq '.events[-5:]' "$WATCHDOG_LOG" 2>/dev/null || echo "  No events"
    else
        echo -e "${YELLOW}No watchdog data found. Run 'watchdog --init' first.${NC}"
    fi
}

# Usage
usage() {
    echo "Usage: $0 [command]"
    echo ""
    echo "Commands:"
    echo "  --monitor       Start continuous monitoring"
    echo "  --init          Initialize watchdog files"
    echo "  --status        Show current status"
    echo "  --file-change   Record a file change (for hooks)"
    echo "  --tool-call     Record a tool call (for hooks)"
    echo "  --error         Record an error (for hooks)"
    echo "  --check         Single stuck check"
    echo "  --recover       Force recovery"
    echo "  -h, --help      Show this help"
}

# Main
case "${1:-}" in
    --monitor)
        init_watchdog
        monitor
        ;;
    --init)
        init_watchdog
        echo -e "${GREEN}✓ Watchdog initialized${NC}"
        ;;
    --status)
        show_status
        ;;
    --file-change)
        watch_file_change "${2:-unknown}"
        ;;
    --tool-call)
        watch_tool_call "${2:-unknown}"
        ;;
    --error)
        watch_error "${2:-unknown}" "${3:-no details}"
        ;;
    --check)
        if check_stuck; then
            echo "STUCK"
            exit 1
        else
            echo "OK"
            exit 0
        fi
        ;;
    --recover)
        recovery_gentle_nudge
        ;;
    -h|--help|*)
        usage
        ;;
esac