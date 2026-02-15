# Command: /ralph-loop

## Summary
Start T-800 in continuous autonomous loop mode - run for hours or days on large projects.

## Usage
```
/ralph-loop [goal] [--max-runs N] [--max-cost USD] [--max-duration TIME]
```

## Parameters
- `goal`: The project goal or task description (required)
- `--max-runs N`: Maximum iterations (default: 25, 0 = infinite)
- `--max-cost USD`: Maximum cost budget (optional)
- `--max-duration TIME`: Maximum duration like "2h", "30m", "1h30m" (optional)

## What It Does

### The Ralph Loop Pattern

```
┌─────────────────────────────────────────────────────────────────────────┐
│                CONTINUOUS AUTONOMOUS ITERATION                           │
├─────────────────────────────────────────────────────────────────────────┤
│                                                                         │
│   ITERATION CYCLE:                                                      │
│   ┌───────────┐    ┌───────────┐    ┌───────────┐    ┌───────────┐     │
│   │  PICK     │ -> │ EXECUTE   │ -> │ VALIDATE  │ -> │  UPDATE   │     │
│   │  TASK     │    │  TASK     │    │  RESULT   │    │  MEMORY   │     │
│   └───────────┘    └───────────┘    └───────────┘    └───────────┘     │
│                                                                         │
│   STATELESS BUT ITERATIVE:                                              │
│   ├─ Fresh context each iteration (prevents drift)                     │
│   ├─ Memory re-injected from files (maintains continuity)              │
│   ├─ Git history as audit trail                                         │
│   └─ Session continuity via IDs                                        │
│                                                                         │
│   STOPS WHEN:                                                           │
│   ├─ All tasks pass verification                                        │
│   ├─ Max iterations reached                                             │
│   ├─ Max cost reached                                                   │
│   └─ Max duration reached                                               │
│                                                                         │
└─────────────────────────────────────────────────────────────────────────┘
```

### Memory Files

The loop maintains persistent memory in `.opencode/memory/`:

| File | Purpose |
|------|---------|
| `AGENTS.md` | Accumulated knowledge (patterns, gotchas, conventions) |
| `task-state.json` | Atomic task queue with pass/fail status |
| `progress.json` | Iteration history and learnings |
| `session-log.json` | Session continuity and handoff |

### Quality Gates

After each iteration, T-800 runs:

1. **TypeCheck** - `npm run typecheck` (if available)
2. **Lint** - `npm run lint` (if available)
3. **Tests** - `npm test` (if available)
4. **Build** - `npm run build` (if available)

### Self-Improvement

After each task, T-800 performs RISE reflection:

- **EPSILON**: Is it truly done? (Boolean verification)
- **ZETA**: What did I learn? (Pattern extraction)
- **ETA**: How do I improve? (Process optimization)

## Examples

### Basic Usage
```
/ralph-loop "Add unit tests to all files" -m 10
```

### With Cost Limit
```
/ralph-loop "Refactor authentication module" --max-cost 5.00
```

### With Duration Limit
```
/ralph-loop "Fix all bugs" --max-duration 2h
```

### Infinite Loop (Until All Tasks Complete)
```
/ralph-loop "Build complete feature X" -m 0
```

## Checking Status

```
/ralph-loop --status
```

Shows:
- Current task
- Tasks completed vs remaining
- Iterations used
- Success rate

## Initialization

```
/ralph-loop --init
```

Initializes memory files if they don't exist.

## Configuration

Quality gates can be configured in `task-state.json`:

```json
{
  "quality_gates": {
    "typecheck": { "command": "npm run typecheck", "enabled": true, "required": true },
    "lint": { "command": "npm run lint", "enabled": true, "required": true },
    "test": { "command": "npm test", "enabled": true, "required": true },
    "build": { "command": "npm run build", "enabled": true, "required": false }
  }
}
```

## Signals

T-800 recognizes these completion signals:

- `T800_ITERATION_COMPLETE` - One iteration done, continue loop
- `T800_ALL_TASKS_COMPLETE` - All tasks verified, stop loop

## Philosophy

**"Each improvement makes future improvements easier."**

The Ralph Loop compounds knowledge:
1. Patterns discovered are saved to AGENTS.md
2. Mistakes are not repeated
3. Success patterns are recognized and reused
4. Each session starts smarter than the last

## See Also
- `/start-t800` - Start a standard T-800 session
- `/t800-plan` - Jump directly to planning
- `/t800-execute` - Jump directly to execution