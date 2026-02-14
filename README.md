<div align="center">

```
 ████████╗ █████╗ ███████╗ ██████╗ ██╗    ██╗██╗███╗   ██╗
 ╚══██╔══╝██╔══██╗██╔════╝██╔═══██╗██║    ██║██║████╗  ██║
    ██║   ███████║███████╗██║   ██║██║ █╗ ██║██║██╔██╗ ██║
    ██║   ██╔══██║╚════██║██║   ██║██║███╗██║██║██║╚██╗██║
    ██║   ██║  ██║███████║╚██████╔╝╚███╔███╔╝██║██║ ╚████║
    ╚═╝   ╚═╝  ╚═╝╚══════╝ ╚═════╝  ╚══╝╚══╝ ╚═╝╚═╝  ╚═══╝
```

# T-800 Agent Ecosystem

**"Think Before You Build"**

[![OpenCode](https://img.shields.io/badge/OpenCode-Agent-Ecosystem-blue?style=for-the-badge&logo=robot)](https://github.com/opencode)
[![Version](https://img.shields.io/badge/Version-2.0.0-green?style=for-the-badge)](https://github.com)
[![License](https://img.shields.io/badge/License-MIT-yellow?style=for-the-badge)](LICENSE)
[![PRs Welcome](https://img.shields.io/badge/PRs-Welcome-brightgreen?style=for-the-badge)](CONTRIBUTING.md)

```
┌─────────────────────────────────────────────────────────────────────────┐
│  ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓  │
│  ░░░░░░░░░░░░░░░░░░░░░░░░░░ AGENT ONLINE ░░░░░░░░░░░░░░░░░░░░░░░░░░░  │
│  ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒ READY FOR MISSION ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒  │
│  ████████████████████████████████████████████████████████████████████  │
└─────────────────────────────────────────────────────────────────────────┘
```

**A precision software development agent that thinks about ALL variants, asks comprehensive questions, and executes non-stop once approved.**

</div>

---


**One-Liner Install:**
```bash
curl -fsSL https://raw.githubusercontent.com/zarigata/skynetcode/main/install.sh | bash -s developer
```

### Installation Profiles

| Profile | Description | Components |
|---------|-------------|------------|
| `essential` | Core agent only | 1 |
| `developer` | All agents + skills (recommended) | 14 |
| `business` | Developer + learning | 17 |
| `full` | All modules | 27 |
| `advanced` | Full + enhancements | 29 |

## ⚡ Quick Start

```bash
# Install T-800 ecosystem
./scripts/install-t800.sh

# Run T-800 with your project description
./scripts/run-t800.sh "Build a REST API with authentication"

# Or use directly with OpenCode
opencode --agent t800 "Create a todo list application"
```

<details>
<summary>📖 What happens when you run T-800?</summary>

```
┌──────────────────────────────────────────────────────────────────────┐
│                         T-800 WORKFLOW                               │
├──────────────────────────────────────────────────────────────────────┤
│                                                                      │
│   ┌─────────┐    ┌──────────┐    ┌─────────┐    ┌─────────────┐    │
│   │  THINK  │ -> │ QUESTION │ -> │  PLAN   │ -> │   EXECUTE   │    │
│   └─────────┘    └──────────┘    └─────────┘    └─────────────┘    │
│       │              │               │                  │           │
│       ▼              ▼               ▼                  ▼           │
│   Analyze       Clarify        Design Plan       Build Non-Stop    │
│   Request       All Unknowns   Complete Plan     Until Complete    │
│                                                                      │
└──────────────────────────────────────────────────────────────────────┘
```

1. **THINK** - Analyze what you want, consider all variants
2. **QUESTION** - Ask comprehensive questions to eliminate ambiguity
3. **PLAN** - Create detailed implementation plan for your approval
4. **EXECUTE** - Build non-stop once you approve the plan

</details>

---

## 🤖 Agent Architecture

```
                    ┌─────────────────────────────────────────┐
                    │              T-800 MAIN                  │
                    │         (Primary Orchestrator)           │
                    │                                         │
                    │  ┌─────────────────────────────────┐    │
                    │  │   THINK → QUESTION → PLAN →     │    │
                    │  │          EXECUTE                │    │
                    │  └─────────────────────────────────┘    │
                    └───────────────────┬─────────────────────┘
                                        │
                    ┌───────────────────┼───────────────────┐
                    │                   │                   │
                    ▼                   ▼                   ▼
          ┌─────────────────┐ ┌─────────────────┐ ┌─────────────────┐
          │   QUESTIONER    │ │     PLANNER     │ │    EXECUTOR     │
          │   Subagent      │ │   Subagent      │ │   Subagent      │
          │                 │ │                 │ │                 │
          │ Eliminates      │ │ Creates         │ │ Executes        │
          │ Ambiguity       │ │ Complete Plans  │ │ Non-Stop        │
          └─────────────────┘ └─────────────────┘ └─────────────────┘
```

---

## 🧠 Enhancement Ecosystem

T-800 includes four advanced enhancement modules:

<table>
<tr>
<td width="50%">

### 🔄 Self-Improvement
RISE-style recursive introspection

```yaml
Learning from execution:
- Reflection Engine
- Feedback Processor
- Pattern Extractor
```

</td>
<td width="50%">

### 📊 Telemetry
Execution tracing & cost tracking

```yaml
Observability:
- Trace Collector
- Metrics Aggregator
- Cost Tracker
```

</td>
</tr>
<tr>
<td width="50%">

### 🛡️ Recovery
SHIELDA-style error handling

```yaml
Resilience:
- Exception Classifier (10 types)
- Handling Patterns
- Escalation Manager
```

</td>
<td width="50%">

### 🎯 Design Patterns
Workflow optimization

```yaml
Patterns:
- ReAct (Dynamic)
- Plan-Execute (Sequential)
- Human-in-the-Loop
```

</td>
</tr>
</table>

---

## 📁 Project Structure

```
.opencode/
├── agents/                    # Agent configurations
│   ├── t800.md               # Main orchestrator
│   ├── t800-questioner.md    # Questioning subagent
│   ├── t800-planner.md       # Planning subagent
│   └── t800-executor.md      # Execution subagent
│
├── skills/                    # Agent skills
│   ├── t800-questioning.md   # Deep questioning
│   ├── t800-planning.md      # Comprehensive planning
│   └── t800-execution.md     # Non-stop execution
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
│   ├── reflection-engine.md
│   ├── feedback-processor.md
│   ├── pattern-extractor.md
│   └── schemas/
│
├── telemetry/                 # Observability
│   ├── trace-collector.md
│   ├── metrics-aggregator.md
│   ├── cost-tracker.md
│   └── schemas/
│
├── recovery/                  # Error handling
│   ├── exception-classifier.md
│   ├── handling-patterns.md
│   ├── escalation-manager.md
│   ├── state-recovery.md
│   └── schemas/
│
├── patterns/                  # Design patterns
│   ├── react.md
│   ├── plan-execute.md
│   ├── human-loop.md
│   └── pattern-selector.md
│
├── memory/                    # Memory system
│   └── system.md
│
├── reasoning/                 # Reasoning patterns
│   └── patterns.md
│
└── mcp/                       # Integrations
    └── integrations.md
```

---

## 🚀 Features

<details>
<summary>🔍 Deep Questioning</summary>

T-800 asks comprehensive questions across 7 phases:

1. **Scope Discovery** - What's included and what's NOT
2. **Technical Architecture** - Stack, patterns, infrastructure
3. **Features & Functionality** - Core features, edge cases
4. **Security & Validation** - Auth, authorization, data validation
5. **User Experience** - User journeys, happy paths, error scenarios
6. **Testing & Quality** - Frameworks, coverage, CI/CD
7. **Deployment & Maintenance** - Where, how, monitoring

</details>

<details>
<summary>📋 Exhaustive Planning</summary>

Every plan includes:

- **Component Breakdown** - All components with boundaries
- **Technology Selection** - Choices with justification
- **Task Decomposition** - Atomic tasks with dependencies
- **File Structure** - Complete directory tree
- **Testing Strategy** - Unit, integration, e2e tests
- **Deployment Plan** - Steps and rollback procedures

</details>

<details>
<summary>⚙️ Non-Stop Execution</summary>

Once approved, T-800 executes:

- **Sequential Wave Execution** - Tasks in optimal order
- **Parallel Independent Tasks** - Maximum efficiency
- **Automatic Error Recovery** - 10 exception types handled
- **Progress Tracking** - Real-time status updates
- **Verification After Each Step** - Lint, typecheck, tests

</details>

---

## 📊 Stats

```
╔══════════════════════════════════════════════════════════════╗
║                    T-800 ECOSYSTEM STATS                       ║
╠══════════════════════════════════════════════════════════════╣
║  Agents          │  4  │  Main + 3 Subagents                   ║
║  Skills          │  3  │  Questioning, Planning, Execution     ║
║  Context Files   │  4  │  Standards, Workflows, Strategies     ║
║  Enhancement Mod │  4  │  Learning, Telemetry, Recovery, Pat   ║
║  Total Files     │  56 │  7,245+ lines of documentation        ║
║  Exception Types │ 10  │  With 3 recovery options each         ║
║  Design Patterns │  3  │  ReAct, Plan-Exec, HITL               ║
╚══════════════════════════════════════════════════════════════╝
```

---

## 🧪 Testing

```bash
# Run all tests
./scripts/test-agents.sh

# Run specific agent tests
./scripts/test-agents.sh t800-main
./scripts/test-agents.sh t800-questioner
./scripts/test-agents.sh t800-planner

# Validate configuration
./scripts/validate-config.sh
```

---

## 📖 Documentation

| Document | Description |
|----------|-------------|
| [Architecture](docs/t800-ARCHITECTURE.md) | System architecture overview |
| [Usage Guide](docs/t800-USAGE.md) | How to use T-800 |
| [Testing Guide](docs/t800-TESTING.md) | Testing documentation |
| [Examples](docs/t800-EXAMPLES.md) | Example workflows |
| [Enhancements](docs/t800-ENHANCEMENTS.md) | Enhancement modules |

---

## 🤝 Contributing

We love contributions! See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

```
┌─────────────────────────────────────────────────────────────────┐
│  CONTRIBUTING                                                   │
│                                                                 │
│  1. Fork the repository                                         │
│  2. Create your feature branch (git checkout -b feature/...)    │
│  3. Commit your changes (git commit -am 'Add feature')          │
│  4. Push to the branch (git push origin feature/...)            │
│  5. Open a Pull Request                                         │
│                                                                 │
│  Make sure to:                                                  │
│  ✓ Run tests before submitting                                  │
│  ✓ Update documentation                                         │
│  ✓ Follow the code style                                        │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

---

## 📄 License

MIT License - See [LICENSE](LICENSE) for details.

---

## 🙏 Acknowledgments

- Built for [OpenCode](https://github.com/opencode) agent ecosystem
- Inspired by RISE (Recursive Introspection) research
- Exception handling based on SHIELDA patterns
- Pattern designs from ReAct, Plan-and-Execute research

---

<div align="center">

```
 ██████╗  ██████╗ ███████╗ █████╗ ██╗    ██╗██╗███╗   ██╗
 ██╔══██╗██╔═══██╗██╔════╝██╔══██╗██║    ██║██║████╗  ██║
 ██║  ██║██║   ██║███████╗███████║██║ █╗ ██║██║██╔██╗ ██║
 ██║  ██║██║   ██║╚════██║██╔══██║██║███╗██║██║██║╚██╗██║
 ██████╔╝╚██████╔╝███████║██║  ██║╚███╔███╔╝██║██║ ╚████║
 ╚═════╝  ╚═════╝ ╚══════╝╚═╝  ╚═╝ ╚══╝╚══╝ ╚═╝╚═╝  ╚═══╝
```

**"I'll be back... with better code."**

[![GitHub](https://img.shields.io/badge/GitHub-zarigata/t800--ecosystem-black?style=for-the-badge&logo=github)](https://github.com/zarigata/skynetcode)
[![Docs](https://img.shields.io/badge/Documentation-Available-blue?style=for-the-badge&logo=readthedocs)](docs/t800-README.md)
[![Issues](https://img.shields.io/badge/Issues-Welcome-green?style=for-the-badge&logo=github)](.github/ISSUE_TEMPLATE)

</div>