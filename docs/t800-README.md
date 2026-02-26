# T-800 Agent Ecosystem

> "Better to ask 100 questions than to build the wrong thing once."

A comprehensive, production-ready agent system for OpenCode that thoroughly questions, plans, and builds without stopping.

## What is T-800?

T-800 is a specialized agent ecosystem designed for **precision software development**:

1. **THINK** - Analyzes ALL possible interpretations
2. **QUESTION** - Systematically eliminates ambiguity
3. **PLAN** - Creates exhaustive specifications
4. **EXECUTE** - Implements continuously without stopping

## Quick Start

```bash
# Start T-800 with a project description
./scripts/run-t800.sh "Build a user authentication system"

# Or use OpenCode directly
opencode --agent t800 "Build a REST API for task management"
```

## Installation

```bash
# Run the installation script
./scripts/install-t800.sh

# Verify installation
./scripts/validate-config.sh
```

## Components

### Agent Files (4 files)
- `t800.md` - Main orchestrator agent
- `t800-questioner.md` - Specialized questioning subagent
- `t800-planner.md` - Specialized planning subagent
- `t800-executor.md` - Specialized execution subagent

### Context System (4 files)
- `t800-standards.md` - Coding standards
- `t800-workflows.md` - Workflow definitions
- `questioning-strategies.md` - Question bank strategies
- `planning-templates.md` - Plan templates

### Skills (3 files)
- `t800-questioning.md` - Deep questioning skill
- `t800-planning.md` - Comprehensive planning skill
- `t800-execution.md` - Non-stop execution skill

### Testing (5 files)
- Agent tests
- Integration tests
- Test runner script
- Configuration validator

### Orchestration (4 files)
- Workflow definitions
- Start command
- Run script
- Install script

## Architecture

```
User Request
     │
     ▼
┌─────────────┐
│  T-800 MAIN │
│  (Orchestrator)
└──────┬──────┘
       │
       ▼
┌──────────────┐     ┌──────────────┐     ┌──────────────┐
│  QUESTIONER  │────▶│   PLANNER    │────▶│   EXECUTOR   │
│  (Clarify)   │     │   (Specify)  │     │  (Implement) │
└──────────────┘     └──────────────┘     └──────────────┘
       │                    │                    │
       └────────────────────┴────────────────────┘
                          │
                          ▼
                    ┌──────────┐
                    │  CONTEXT │
                    │  SYSTEM  │
                    └──────────┘
```

## Key Principles

1. **Think Before Build** - Analyze all possibilities
2. **Question Everything** - Eliminate ALL ambiguity
3. **Plan Exhaustively** - Leave zero room for misinterpretation
4. **Execute Continuously** - Build without stopping

## Testing

```bash
# Run all tests
./scripts/test-agents.sh

# Run specific agent tests
./scripts/test-agents.sh t800-questioner
```

## Documentation

- [Architecture](./t800-ARCHITECTURE.md) - System architecture
- [Usage Guide](./t800-USAGE.md) - Detailed usage
- [Testing Guide](./t800-TESTING.md) - Testing documentation
- [Examples](./t800-EXAMPLES.md) - Example workflows

## License

MIT

---

## 🆕 NEW IN V3.1: DYNAMIC ORCHESTRATION

### Intelligent Dispatch

T-800 now includes a dynamic orchestration layer that:

- **Analyzes task structure** for parallel execution opportunities
- **Dispatches subagents** based on task requirements
- **Coordinates parallel execution** when tasks are independent
- **Monitors progress** with real-time dashboards
- **Adapts strategy** based on execution metrics

### Parallel Execution

```
┌─────────────────────────────────────────────────────────────────────────┐
│                    PARALLEL EXECUTION FLOW                                │
├─────────────────────────────────────────────────────────────────────────┤
│                                                                         │
│   TASK ANALYSIS                                                          │
│       │                                                                  │
│       ▼                                                                  │
│   ┌─────────────────────────────────────────────────────────────────┐   │
│   │  Can tasks run in parallel?                                      │   │
│   └─────────────────────────────────────────────────────────────────┘   │
│       │                                                                  │
│       ├─ YES → Dispatch multiple executors concurrently                │
│       │        │                                                          │
│       │        ├─ background_output(task_A)                               │
│       │        ├─ background_output(task_B)                               │
│       │        └─ background_output(task_C)                               │
│       │                                                                  │
│       └─ NO → Sequential execution (standard flow)                      │
│                                                                         │
└─────────────────────────────────────────────────────────────────────────┘
```

### Adaptive Model Switching

T-800 dynamically adjusts model selection:

| Trigger | Action |
|---------|--------|
| Stuck on same error 3+ times | Upgrade to stronger model |
| Task simpler than expected | Downgrade for efficiency |
| Budget approaching limit | Switch to economy tier |
| Complex reasoning needed | Upgrade to premium model |

### Enhanced Error Recovery

10 error types with specific recovery patterns:

```yaml
SYNTAX_ERROR → Auto-fix with AST analysis
TYPE_ERROR → Infer type, add annotation
RUNTIME_ERROR → Add error boundary, log context
DEPENDENCY_ERROR → Install missing, update imports
LOGIC_ERROR → Trace execution, add assertions
INTEGRATION_ERROR → Verify interfaces, check contracts
CONFIGURATION_ERROR → Validate config, apply defaults
PERMISSION_ERROR → Check permissions, suggest fix
RESOURCE_ERROR → Free resources, retry with limits
TIMEOUT_ERROR → Increase timeout, optimize operation
```

### Session Continuity

T-800 maintains state across sessions:

```yaml
handoff_package:
  required:
    - current_task: "Description and status"
    - completed_tasks: "List with results"
    - pending_tasks: "List with priorities"
    - blockers: "Current issues"
    - context_summary: "Key decisions made"
    
  file: ".opencode/memory/session-handoff.md"
```

---

## 🆕 NEW IN V3.1: ADAPTIVE LEARNING

### Memory System

T-800 learns from every execution:

```yaml
memory_files:
  AGENTS.md:
    - Patterns discovered
    - Gotchas encountered
    - Style preferences
    
  progress.json:
    - Iteration history
    - Success metrics
    - Error patterns
    
  task-state.json:
    - Task completion status
    - Verification results
    
  session-log.json:
    - Session continuity
    - Handoff data
```

### Learning Patterns

```
PATTERN THETA: "What patterns emerged?"
├── Identify reusable code structures
├── Document successful approaches
└── Note failure patterns to avoid

PATTERN IOTA: "How can I optimize?"
├── Analyze token usage patterns
├── Identify redundant operations
└── Find parallelizable tasks

PATTERN KAPPA: "What should I remember?"
├── New patterns discovered
├── Gotchas encountered
└── User preferences observed
```

---

## Real-Time Progress Dashboard

```
╔══════════════════════════════════════════════════════════════════════════════╗
║                         T-800 EXECUTION DASHBOARD                             ║
╠══════════════════════════════════════════════════════════════════════════════╣
║                                                                               ║
║  PHASE: [THINK|QUESTION|PLAN|EXECUTE|ADAPT]                                   ║
║  STATUS: [RUNNING|WAITING|COMPLETE|ERROR]                                     ║
║                                                                               ║
╠───────────────────────────────────────────────────────────────────────────────╣
║                                                                               ║
║  TASKS:                                                                       ║
║  ├─ [✓] Task 1: Setup project structure                                       ║
║  ├─ [✓] Task 2: Implement authentication                                      ║
║  ├─ [▶] Task 3: Build API endpoints (IN PROGRESS)                             ║
║  ├─ [○] Task 4: Write tests                                                   ║
║  └─ [○] Task 5: Documentation                                                 ║
║                                                                               ║
╠───────────────────────────────────────────────────────────────────────────────╣
║                                                                               ║
║  METRICS:                                                                     ║
║  ├─ Progress: ████████░░░░░░░░ 40%                                            ║
║  ├─ Files: 12 created, 3 modified                                             ║
║  ├─ Tests: 15 passing, 0 failing                                              ║
║  ├─ Tokens: 45,000 / 200,000                                                  ║
║  └─ Time: 15m elapsed, ~25m remaining                                         ║
║                                                                               ║
╚══════════════════════════════════════════════════════════════════════════════╝
```

---

## Updated Architecture

```
┌─────────────────────────────────────────────────────────────────────────────────┐
│                         T-800 V3.1 ARCHITECTURE                                  │
├─────────────────────────────────────────────────────────────────────────────────┤
│                                                                                 │
│   USER REQUEST                                                                  │
│       │                                                                          │
│       ▼                                                                          │
│   ┌─────────────────────────────────────────────────────────────────────────┐   │
│   │                         PRE-AGENT (NEW!)                                 │   │
│   │  ┌─────────┐  ┌─────────┐  ┌─────────┐  ┌─────────┐  ┌─────────┐       │   │
│   │  │CLASSIFY │─►│RETRIEVE │─►│OPTIMIZE │─►│  ROUTE  │─►│PARALLEL │       │   │
│   │  └─────────┘  └─────────┘  └─────────┘  └─────────┘  └─────────┘       │   │
│   └─────────────────────────────────────────────────────────────────────────┘   │
│                                                                                 │
│   ┌─────────────────────────────────────────────────────────────────────────┐   │
│   │                      DYNAMIC ORCHESTRATOR (NEW!)                          │   │
│   │  ┌─────────────────┐  ┌─────────────────┐  ┌─────────────────┐           │   │
│   │  │ DISPATCH MATRIX │  │PARALLEL COORD   │  │ADAPTIVE STRATEGY│           │   │
│   │  └─────────────────┘  └─────────────────┘  └─────────────────┘           │   │
│   └─────────────────────────────────────────────────────────────────────────┘   │
│                                                                                 │
│   ┌─────────────────────────────────────────────────────────────────────────┐   │
│   │                           T-800 MAIN                                       │   │
│   │  ┌─────────┐  ┌─────────┐  ┌─────────┐  ┌─────────┐  ┌─────────┐       │   │
│   │  │  THINK  │─►│QUESTION │─►│  PLAN   │─►│ EXECUTE │─►│  ADAPT  │       │   │
│   │  └─────────┘  └─────────┘  └─────────┘  └─────────┘  └─────────┘       │   │
│   └─────────────────────────────────────────────────────────────────────────┘   │
│                                                                                 │
│   ┌──────────────────────────────────────────────────────────────────────────┐  │
│   │                    SUBAGENTS (mode: subagent)                             │  │
│   │  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐                    │  │
│   │  │ t800-pre-agent│  │t800-questioner│  │ t800-planner │                    │  │
│   │  │ (Task Optimizer)│(Ambiguity Elim)│(Strategic Arch)│                    │  │
│   │  └──────────────┘  └──────────────┘  └──────────────┘                    │  │
│   │                              ┌──────────────┐                              │  │
│   │                              │t800-executor │                              │  │
│   │                              │(Continuous    │                              │  │
│   │                              │ Builder)     │                              │  │
│   │                              └──────────────┘                              │  │
│   └──────────────────────────────────────────────────────────────────────────┘  │
│                                                                                 │
│   ┌──────────────────────────────────────────────────────────────────────────┐  │
│   │                    MEMORY SYSTEM (NEW!)                                   │  │
│   │  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐      │  │
│   │  │  AGENTS.md  │  │task-state   │  │  progress   │  │session-log  │      │  │
│   │  │ (Knowledge) │  │ (Tasks)     │  │ (Metrics)   │  │ (Continuity)│      │  │
│   │  └─────────────┘  └─────────────┘  └─────────────┘  └─────────────┘      │  │
│   └──────────────────────────────────────────────────────────────────────────┘  │
│                                                                                 │
└─────────────────────────────────────────────────────────────────────────────────┘
```

---

## Stats

```
╔══════════════════════════════════════════════════════════════╗
║                    T-800 V3.1 ECOSYSTEM STATS                   ║
╠══════════════════════════════════════════════════════════════╣
║  Agents          │  5  │  Main + Pre-Agent + 3 Subagents      ║
║  Skills          │  4  │  Pre-Agent, Questioning, Planning... ║
║  Pre-Agent Mods  │  5  │  Classifier, Retriever, Optimizer... ║
║  Orchestration   │  1  │  Dynamic Orchestrator (NEW!)         ║
║  Memory Files    │  5+ │  AGENTS.md, task-state, progress...   ║
║  Context Files   │  4  │  Standards, Workflows, Strategies    ║
║  Enhancement Mod │  4  │  Learning, Telemetry, Recovery, Pat  ║
║  Model Integr.   │  9  │  Claude, GPT, GLM, Haiku...          ║
║  Total Files     │  75+│  15,000+ lines of documentation      ║
║  Exception Types │ 10  │  With 3 recovery options each        ║
║  Design Patterns │  3  │  ReAct, Plan-Exec, HITL              ║
║  Parallel Groups │  ✓  │  Multi-executor coordination         ║
║  Dynamic Routing │  ✓  │  Adaptive model switching            ║
║  Session Handoff │  ✓  │  Cross-session continuity            ║
╚══════════════════════════════════════════════════════════════╝
```
