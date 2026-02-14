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
