# Command: /t800-with-watchdog

## Summary
Start T-800 with the Watchdog supervisor for autonomous self-healing operation.

## Usage
```
/t800-with-watchdog [goal] [options]
```

## Parameters
- `goal`: The project goal or task description
- `--watchdog-interval N`: Watchdog check interval in seconds (default: 30)
- `--stuck-threshold N`: Seconds before considering stuck (default: 120)
- `--max-recovery N`: Max recovery attempts before blocking task (default: 3)

## How It Works

### Dual-Agent Architecture

```
┌─────────────────────────────────────────────────────────────────────────┐
│                     T-800 + WATCHDOG ARCHITECTURE                        │
├─────────────────────────────────────────────────────────────────────────┤
│                                                                         │
│   ┌─────────────────────┐         ┌─────────────────────┐              │
│   │                     │         │                     │              │
│   │    T-800 MAIN       │◄───────►│    WATCHDOG         │              │
│   │    (Execution)      │  WATCH  │    (Supervisor)     │              │
│   │                     │         │                     │              │
│   └─────────┬───────────┘         └──────────┬──────────┘              │
│             │                                │                         │
│             │                                │                         │
│             ▼                                ▼                         │
│   ┌─────────────────────────────────────────────────────┐              │
│   │                 SHARED MEMORY                        │              │
│   │                                                      │              │
│   │   • task-state.json    (task progress)              │              │
│   │   • progress.json      (iteration history)          │              │
│   │   • watchdog.json      (health & events)            │              │
│   │   • AGENTS.md          (accumulated knowledge)      │              │
│   │                                                      │              │
│   └─────────────────────────────────────────────────────┘              │
│                                                                         │
└─────────────────────────────────────────────────────────────────────────┘
```

### What Watchdog Detects

| Detection | Trigger | Response |
|-----------|---------|----------|
| **Stuck State** | No activity for 120s | Gentle nudge → Context refresh → Full restart |
| **Error** | Tool failures, API errors | Counter increment → Recovery after threshold |
| **Loop** | Repeated identical actions | Inject alternative approach |
| **Context Overflow** | Token count > 180k | Context refresh with handoff |

### Recovery Strategies

1. **Gentle Nudge** (after 2 min stuck)
   - Inject continuation prompt
   - Suggest alternatives
   - Update progress tracking

2. **Context Refresh** (after 5 min stuck)
   - Save current state
   - Create handoff summary
   - Spawn fresh session with memory injection

3. **Full Restart** (after 10 min or 3+ errors)
   - Mark task as blocked if needed
   - Complete session reset
   - Continue from saved state

## Examples

### Start with default settings
```
/t800-with-watchdog "Add unit tests to auth module"
```

### Customize thresholds
```
/t800-with-watchdog "Refactor database layer" --stuck-threshold 60 --max-recovery 5
```

### Check watchdog status
```
/t800-watchdog --status
```

## Watchdog Commands

```bash
# Check if T-800 is stuck
./scripts/t800-watchdog.sh --check

# Show watchdog status
./scripts/t800-watchdog.sh --status

# Force recovery
./scripts/t800-watchdog.sh --recover
```

## Integration with Hooks

Add to `.claude/hooks.json`:

```json
{
  "PostToolUse": [
    {
      "matcher": ".*",
      "hooks": [
        {
          "type": "command",
          "command": "./scripts/t800-watchdog.sh --tool-call $TOOL_NAME"
        }
      ]
    }
  ]
}
```

This notifies the watchdog on every tool call, keeping the activity timer updated.

## Signals

The watchdog outputs these signals for the T-800 loop to detect:

| Signal | Meaning |
|--------|---------|
| `T800_RECOVERED` | Gentle nudge applied, agent should continue |
| `T800_RESTART_REQUIRED` | Full restart needed, loop should respawn |
| `T800_CONTEXT_REFRESH` | Context was refreshed, new session should read handoff |

## Best Practices

1. **Let the watchdog run** - It monitors in the background
2. **Don't ignore signals** - When T-800_RECOVERED appears, follow its guidance
3. **Check status regularly** - Use `--status` to see health
4. **Review logs** - Check `watchdog.json` events for patterns
5. **Tune thresholds** - Adjust based on your project complexity

## See Also
- `/ralph-loop` - Start T-800 in continuous loop mode
- `/start-t800` - Start a standard T-800 session
- `docs/t800-AUTONOMOUS.md` - Full autonomous mode documentation