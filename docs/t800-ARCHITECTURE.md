# T-800 Architecture

## Overview

T-800 is a multi-agent ecosystem designed for precision software development. It follows a four-phase workflow: THINK → QUESTION → PLAN → EXECUTE.

## System Components

### 1. Main Orchestrator (t800.md)

**Role**: Coordinates all phases and manages flow

**Configuration**:
- Mode: primary
- Temperature: 0.3
- Tools: Full access

**Responsibilities**:
- Receives user requests
- Analyzes request type
- Delegates to appropriate subagent
- Coordinates phases
- Presents final output

### 2. Questioner Subagent (t800-questioner.md)

**Role**: Eliminates ambiguity through systematic questioning

**Configuration**:
- Mode: subagent
- Temperature: 0.2 (focused)
- Tools: read, glob, grep, question

**Questioning Framework**:
1. Scope Discovery
2. Technical Architecture
3. Features & Functionality
4. Security & Validation
5. User Experience
6. Testing & Quality
7. Deployment & Maintenance

### 3. Planner Subagent (t800-planner.md)

**Role**: Creates exhaustive implementation plans

**Configuration**:
- Mode: subagent
- Temperature: 0.3
- Tools: read, glob, grep (no write)

**Planning Framework**:
1. Requirement Synthesis
2. Architecture Design
3. Implementation Planning
4. Quality Planning

### 4. Executor Subagent (t800-executor.md)

**Role**: Implements plans without stopping

**Configuration**:
- Mode: subagent
- Temperature: 0.1 (deterministic)
- Tools: Full access

**Execution Rules**:
1. Never stop
2. Complete each task
3. Validate immediately
4. Document as you go
5. Handle errors now

## Context System

### Core Context (`.opencode/context/core/`)

**t800-standards.md**:
- Naming conventions
- TypeScript standards
- Error handling patterns
- Testing standards
- Project structure

**t800-workflows.md**:
- New feature development
- Bug fix workflow
- Refactoring workflow
- Code review workflow
- Error handling workflow

### Project Intelligence (`.opencode/context/project-intelligence/`)

**questioning-strategies.md**:
- Funnel technique
- Five Ws
- Edge case exploration
- Scenario walkthrough
- Constraint discovery
- Security interrogation

**planning-templates.md**:
- Web application template
- REST API template
- CLI tool template
- Library/package template

## Skills

**t800-questioning.md**:
- When to use
- Skill workflow
- Question patterns
- Best practices

**t800-planning.md**:
- When to use
- Skill workflow
- Plan template
- Best practices

**t800-execution.md**:
- When to use
- Skill workflow
- Execution rules
- Progress reporting

## Data Flow

```
┌─────────────────────────────────────────────────────────────┐
│                      USER REQUEST                           │
└─────────────────────────────────────────────────────────────┘
                            │
                            ▼
┌─────────────────────────────────────────────────────────────┐
│                     T-800 MAIN AGENT                        │
│                                                             │
│  1. THINK Phase                                             │
│     - Analyze request type                                  │
│     - Determine complexity                                  │
│     - Decide strategy                                       │
│                                                             │
│  2. DELEGATE to Questioner                                  │
│     - Load questioning strategies                           │
│     - Execute systematic questioning                        │
│     - Return clarified requirements                         │
│                                                             │
│  3. DELEGATE to Planner                                     │
│     - Load planning templates                               │
│     - Generate comprehensive plan                           │
│     - Return plan for approval                              │
│                                                             │
│  4. APPROVAL GATE                                           │
│     - Present plan to user                                  │
│     - Wait for approval                                     │
│     - Proceed only if approved                              │
│                                                             │
│  5. DELEGATE to Executor                                    │
│     - Load coding standards                                 │
│     - Implement plan non-stop                               │
│     - Return completion status                              │
└─────────────────────────────────────────────────────────────┘
                            │
                            ▼
┌─────────────────────────────────────────────────────────────┐
│                    COMPLETE PROJECT                         │
└─────────────────────────────────────────────────────────────┘
```

## File Structure

```
.opencode/
├── agents/
│   ├── t800.md              # Main orchestrator
│   ├── t800-questioner.md   # Questioning subagent
│   ├── t800-planner.md      # Planning subagent
│   └── t800-executor.md     # Execution subagent
├── context/
│   ├── core/
│   │   ├── t800-standards.md     # Coding standards
│   │   └── t800-workflows.md     # Workflow definitions
│   └── project-intelligence/
│       ├── questioning-strategies.md
│       └── planning-templates.md
├── skills/
│   ├── t800-questioning.md
│   ├── t800-planning.md
│   └── t800-execution.md
├── workflows/
│   └── t800-full-workflow.md
└── commands/
    └── start-t800.md

tests/
├── agents/
│   ├── t800-main.test.md
│   ├── t800-questioner.test.md
│   └── t800-planner.test.md
└── integration/
    └── t800-workflow.test.md

scripts/
├── test-agents.sh
├── validate-config.sh
├── run-t800.sh
└── install-t800.sh

docs/
├── t800-README.md
├── t800-ARCHITECTURE.md
├── t800-USAGE.md
├── t800-TESTING.md
└── t800-EXAMPLES.md
```

## Extension Points

T-800 can be extended by:

1. **Adding new context files** in `.opencode/context/`
2. **Adding new skills** in `.opencode/skills/`
3. **Modifying workflows** in `.opencode/workflows/`
4. **Adding new commands** in `.opencode/commands/`
5. **Adding new modules** in `.opencode/orchestration/`
6. **Updating memory schemas** in `.opencode/memory/`

---

## NEW: Dynamic Orchestration Layer

The orchestration layer manages intelligent dispatching and coordination:

```
┌─────────────────────────────────────────────────────────────────────────┐
│                    DYNAMIC ORCHESTRATION ENGINE                         │
├─────────────────────────────────────────────────────────────────────────┤
│                                                                         │
│   ┌─────────────────────────────────────────────────────────────┐      │
│   │                    DISPATCH MATRIX                            │      │
│   │                                                             │      │
│   │  Task Type → Subagent Mapping                               │      │
│   │  ├─ clarification_needed → t800-questioner                  │      │
│   │  ├─ planning_needed → t800-planner                          │      │
│   │  └─ execution_ready → t800-executor                         │      │
│   └─────────────────────────────────────────────────────────────┘      │
│                                                                         │
│   ┌─────────────────────────────────────────────────────────────┐      │
│   │                 PARALLEL EXECUTION                           │      │
│   │                                                             │      │
│   │  When tasks are independent:                                │      │
│   │  ├─ Analyze task structure                                  │      │
│   │  ├─ Identify parallelizable groups                          │      │
│   │  ├─ Dispatch in parallel                                    │      │
│   │  └─ Merge results                                            │      │
│   └─────────────────────────────────────────────────────────────┘      │
│                                                                         │
│   ┌─────────────────────────────────────────────────────────────┐      │
│   │                 ADAPTIVE STRATEGY                            │      │
│   │                                                             │      │
│   │  Dynamic adjustments:                                        │      │
│   │  ├─ Model switching (upgrade/downgrade)                     │      │
│   │  ├─ Strategy adaptation                                      │      │
│   │  └─ Resource optimization                                    │      │
│   └─────────────────────────────────────────────────────────────┘      │
│                                                                         │
└─────────────────────────────────────────────────────────────────────────┘
```

---

## NEW: Adaptive Learning System

T-800 learns from every execution through the memory system:

```
┌─────────────────────────────────────────────────────────────────────────┐
│                      ADAPTIVE LEARNING ENGINE                           │
├─────────────────────────────────────────────────────────────────────────┤
│                                                                         │
│   PATTERN THETA: "What patterns emerged?"                              │
│   ├── Identify reusable code structures                                │
│   ├── Document successful approaches                                   │
│   └── Update AGENTS.md                                                 │
│                                                                         │
│   PATTERN IOTA: "How can I optimize?"                                  │
│   ├── Analyze token usage patterns                                     │
│   ├── Find parallelizable tasks                                        │
│   └── Generate optimization recommendations                            │
│                                                                         │
│   PATTERN KAPPA: "What should I remember?"                             │
│   ├── Extract new patterns discovered                                  │
│   ├── Record gotchas encountered                                       │
│   └── Update memory files                                              │
│                                                                         │
└─────────────────────────────────────────────────────────────────────────┘
```

---

## NEW: Enhanced Error Recovery

T-800 implements SHIELDA-style error handling:

```yaml
error_classification:
  SYNTAX_ERROR:
    recovery: "Auto-fix with AST analysis"
    escalation: "After 2 failed fixes"
    
  TYPE_ERROR:
    recovery: "Infer type, add annotation"
    escalation: "After 3 failed inferences"
    
  RUNTIME_ERROR:
    recovery: "Add error boundary, log context"
    escalation: "After 2 failed boundaries"
    
  DEPENDENCY_ERROR:
    recovery: "Install missing, update imports"
    escalation: "After 1 failed install"
    
  LOGIC_ERROR:
    recovery: "Trace execution, add assertions"
    escalation: "After 3 failed traces"
    
  INTEGRATION_ERROR:
    recovery: "Verify interfaces, check contracts"
    escalation: "After 2 failed verifications"
    
  CONFIGURATION_ERROR:
    recovery: "Validate config, apply defaults"
    escalation: "After 1 failed validation"
    
  PERMISSION_ERROR:
    recovery: "Check permissions, suggest fix"
    escalation: "Immediately (user action needed)"
    
  RESOURCE_ERROR:
    recovery: "Free resources, retry with limits"
    escalation: "After 2 failed retries"
    
  TIMEOUT_ERROR:
    recovery: "Increase timeout, optimize operation"
    escalation: "After 3 failed retries"
```

---

## NEW: Session Continuity

T-800 maintains state across sessions:

```yaml
session_management:
  handoff_package:
    required:
      - current_task: "Description and status"
      - completed_tasks: "List with results"
      - pending_tasks: "List with priorities"
      - blockers: "Current issues"
      - context_summary: "Key decisions made"
      
  file: ".opencode/memory/session-handoff.md"
  update_frequency: "After each major task"
```

---

## NEW: Real-Time Progress Tracking

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

## Updated File Structure

```
.opencode/
├── agents/                    # Agent configurations
│   ├── t800.md               # Main orchestrator (UPDATED)
│   ├── t800-pre-agent.md     # Pre-Agent (UPDATED with parallel analysis)
│   ├── t800-questioner.md    # Questioning subagent
│   ├── t800-planner.md       # Planning subagent
│   └── t800-executor.md      # Execution subagent (UPDATED with parallel support)
│
├── orchestration/             # NEW: Orchestration modules
│   └── dynamic-orchestrator.md  # Intelligent dispatch & coordination
│
├── skills/                    # Agent skills
│   ├── t800-pre-agent.md     # Pre-Agent skill
│   ├── t800-questioning.md   # Deep questioning
│   ├── t800-planning.md      # Comprehensive planning
│   └── t800-execution.md     # Non-stop execution
│
├── pre-agent/                 # Pre-Agent modules
│   ├── orchestrator.md       # Main orchestration
│   ├── task-classifier.md    # Task classification
│   ├── knowledge-retriever.md # Knowledge retrieval
│   ├── context-optimizer.md  # Context optimization
│   └── model-router.md       # Model selection
│
├── memory/                    # Memory system (UPDATED)
│   ├── AGENTS.md             # Accumulated knowledge
│   ├── system.md             # Memory system architecture
│   ├── task-state.json       # Task queue
│   ├── progress.json         # Iteration history
│   └── session-log.json      # Session continuity
│
├── context/                   # Context & standards
│   ├── core/
│   │   ├── t800-standards.md
│   │   └── t800-workflows.md
│   └── project-intelligence/
│       ├── questioning-strategies.md
│       └── planning-templates.md
│
├── learning/                  # Self-improvement
├── telemetry/                 # Observability
├── recovery/                  # Error handling
├── patterns/                  # Design patterns
└── mcp/                       # Integrations
```
