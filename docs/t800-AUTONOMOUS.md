# T-800 Autonomous Mode

## The Vibe Coder's Best Friend

T-800 now runs **continuously for hours or days** - coding, testing, learning, and improving itself while you sleep.

---

## What's New

### 🔄 Ralph Loop Engine

Based on the "Ralph Wiggum" pattern by Geoffrey Huntley, enhanced with self-improvement from RISE research:

```
  PICK TASK → EXECUTE → VALIDATE → UPDATE MEMORY → RESET CONTEXT → REPEAT
       ↑                                                        │
       └────────────────────────────────────────────────────────┘
```

**Key Innovation**: Fresh context each iteration prevents drift, while memory files maintain continuity across sessions.

### 🧠 Persistent Memory

T-800 remembers everything across sessions:

| File | Purpose |
|------|---------|
| `AGENTS.md` | Patterns, gotchas, conventions discovered |
| `task-state.json` | Atomic task queue with pass/fail status |
| `progress.json` | Iteration history and learnings |
| `session-log.json` | Session continuity and handoff |

### 📈 Self-Improvement (RISE Protocol)

After EVERY task, T-800 performs reflection:

```bash
PATTERN EPSILON: "IS IT TRULY DONE?"
├── Run all tests
├── Check all acceptance criteria (boolean)
├── Verify type checking passes
└── Generate: TRUE COMPLETE or NOT DONE

PATTERN ZETA: "WHAT DID I LEARN?"
├── What approach worked? Why?
├── What failed? Root cause?
├── Pattern to remember for future?
└── Update AGENTS.md with learnings

PATTERN ETA: "HOW DO I IMPROVE?"
├── Compare current vs previous approaches
├── Identify inefficiencies
└── Suggest process improvements
```

---

## Quick Start

### Start Autonomous Loop

```bash
# Basic usage - 25 iterations max
./scripts/t800-loop.sh -p "Add unit tests to all files"

# Run for 2 hours max
./scripts/t800-loop.sh -p "Refactor authentication" --max-duration 2h

# Run until $5 budget exhausted
./scripts/t800-loop.sh -p "Fix all bugs" --max-cost 5.00

# Run until all tasks complete (no limit)
./scripts/t800-loop.sh -p "Build feature X" -m 0
```

### Check Status

```bash
./scripts/t800-loop.sh --status
```

Output:
```
╔══════════════════════════════════════════════════════════════╗
║              T-800 RALPH LOOP STATUS                          ║
╚══════════════════════════════════════════════════════════════╝

  Status:          running
  Current Task:    task-005
  Tasks Total:     10
  Tasks Done:      4
  Tasks Remaining: 6
  Iterations:      12 / 25
```

### Initialize Memory

```bash
./scripts/t800-loop.sh --init
```

---

## How It Works

### The Loop

1. **PICK** - Select next task from `task-state.json` where `passes: false`
2. **EXECUTE** - T-800 implements the task completely
3. **VALIDATE** - Run quality checks (typecheck, lint, test, build)
4. **UPDATE** - Update memory files with learnings
5. **RESET** - Clear context, inject memory, repeat

### Memory Injection

At the start of each iteration, T-800 reads:

```markdown
## MEMORY INJECTION

### AGENTS.md (Accumulated Knowledge):
[All patterns, gotchas, and conventions discovered]

### Task State (Current Progress):
[Which tasks are done, which remain, current status]
```

### Quality Gates

After each iteration:
- ✓ TypeScript typecheck
- ✓ ESLint/Prettier
- ✓ Tests pass
- ✓ Build succeeds (optional)

If gates fail, T-800 fixes immediately before moving on.

---

## Configuration

### Task State (`task-state.json`)

```json
{
  "meta": {
    "project_goal": "Add comprehensive test coverage",
    "max_iterations": 25,
    "status": "running"
  },
  "quality_gates": {
    "typecheck": { "command": "npm run typecheck", "required": true },
    "lint": { "command": "npm run lint", "required": true },
    "test": { "command": "npm test", "required": true }
  },
  "tasks": [
    {
      "id": "task-001",
      "story": "Test authentication module",
      "acceptance_criteria": [
        "All auth functions have unit tests",
        "Test coverage > 80%",
        "No failing tests"
      ],
      "passes": false,
      "attempts": 0
    }
  ]
}
```

### AGENTS.md Template

```markdown
# T-800 Memory Bank

## 🧠 Patterns & Conventions

### Code Style
- Use arrow functions for callbacks
- Prefer const over let

### Architecture Patterns
- Repository pattern for data access
- Factory pattern for object creation

## ⚠️ Gotchas

### Common Pitfalls
- Don't forget to mock database in tests
- Environment variables need .env file

## 📚 Recent Learnings

### Session: 2025-02-15
**Task**: Test authentication
**What Worked**: Mocking at service boundary
**Pattern to Remember**: Use jest.mock() for external dependencies
```

---

## Stop Hook (Auto-Continue)

The stop hook prevents T-800 from stopping until truly done:

```bash
# .claude/hooks/stop-hook.sh
# Checks:
# 1. Are all tasks complete?
# 2. Have max iterations been reached?
# 3. Are there remaining tasks?

# If tasks remain → OUTPUT: "CONTINUE" → Loop continues
# If all done → OUTPUT: exit 0 → Loop stops
```

---

## Philosophy

**"Each improvement makes future improvements easier."**

Traditional AI coding:
- Starts fresh each session
- Repeats mistakes
- Forgets patterns
- No compounding knowledge

T-800 Autonomous:
- Remembers across sessions
- Never repeats mistakes
- Accumulates patterns
- Gets smarter over time

---

## Best Practices

### 1. Write Atomic Tasks

✅ Good:
```json
{
  "id": "task-001",
  "story": "Test the login function",
  "acceptance_criteria": [
    "test_login_returns_token_on_success passes",
    "test_login_returns_401_on_invalid_password passes",
    "test_login_returns_400_on_missing_email passes"
  ]
}
```

❌ Bad:
```json
{
  "id": "task-001",
  "story": "Test everything"
}
```

### 2. Seed AGENTS.md

Before running, add your project's patterns:

```markdown
## 🧠 Patterns & Conventions

### Code Style
- Use 2-space indentation
- Prefer named exports over default exports

### Testing
- Use Jest with TypeScript
- Place tests next to source files (*.test.ts)
```

### 3. Set Realistic Limits

```bash
# Good - reasonable bounds
./scripts/t800-loop.sh -p "Feature X" -m 20 --max-duration 3h

# Risky - could run forever
./scripts/t800-loop.sh -p "Feature X" -m 0
```

### 4. Review AGENTS.md Periodically

T-800 will add learnings automatically. Review weekly:
- Remove outdated gotchas
- Consolidate similar patterns
- Update style preferences

---

## Signals

T-800 outputs these completion signals:

| Signal | Meaning |
|--------|---------|
| `T800_ITERATION_COMPLETE` | One iteration done, continue |
| `T800_ALL_TASKS_COMPLETE` | All tasks verified, stop |

---

## Troubleshooting

### "Loop just keeps running"

Check `task-state.json`:
- Are acceptance criteria testable?
- Are tasks too large? Break them down.
- Are quality gates passing? Run manually.

### "AGENTS.md not being updated"

Ensure T-800 has write permission:
```bash
chmod 644 .opencode/memory/AGENTS.md
```

### "Context keeps growing"

The loop should reset context each iteration. If not:
- Check that `t800-loop.sh` is spawning fresh processes
- Ensure memory files aren't being read inline

---

## References

- **Ralph Wiggum Pattern**: Geoffrey Huntley's continuous agent loop
- **Compound Product**: Ryan Carson's self-improving product system
- **RISE Protocol**: Recursive Introspection for Self-Improvement (University of Bristol)
- **Gödel Agent**: Self-referential agent framework for recursive improvement
- **SWE-Agent**: Agent-Computer Interfaces for Automated Software Engineering

---

## What's Different from Standard T-800

| Feature | Standard T-800 | T-800 Autonomous |
|---------|---------------|------------------|
| Session Length | Minutes | Hours/Days |
| Memory | None | Persistent files |
| Self-Improvement | None | RISE protocol |
| Continuous Loop | No | Yes (Ralph Loop) |
| Stop Hook | Manual | Auto-continue |
| Learning | Per-session | Compound across sessions |

---

*"I'll be back... with smarter code."*