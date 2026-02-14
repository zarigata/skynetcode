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
