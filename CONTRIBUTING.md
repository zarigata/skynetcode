# Contributing to T-800

```
 ████████╗ █████╗ ███████╗ ██████╗ ██╗    ██╗██╗███╗   ██╗
 ╚══██╔══╝██╔══██╗██╔════╝██╔═══██╗██║    ██║██║████╗  ██║
    ██║   ███████║███████╗██║   ██║██║ █╗ ██║██║██╔██╗ ██║
    ██║   ██╔══██║╚════██║██║   ██║██║███╗██║██║██║╚██╗██║
    ██║   ██║  ██║███████║╚██████╔╝╚███╔███╔╝██║██║ ╚████║
    ╚═╝   ╚═╝  ╚═╝╚══════╝ ╚═════╝  ╚══╝╚══╝ ╚═╝╚═╝  ╚═══╝
                    CONTRIBUTING GUIDE
```

## 🎯 Welcome

Thank you for your interest in contributing to T-800! This document provides guidelines and instructions for contributing.

## 📋 Table of Contents

- [Code of Conduct](#code-of-conduct)
- [Development Setup](#development-setup)
- [How to Contribute](#how-to-contribute)
- [Pull Request Process](#pull-request-process)
- [Style Guidelines](#style-guidelines)
- [Testing](#testing)

## 🤝 Code of Conduct

### Our Pledge

We are committed to providing a welcoming and inspiring community for all.

### Our Standards

- Using welcoming and inclusive language
- Being respectful of differing viewpoints
- Gracefully accepting constructive criticism
- Focusing on what is best for the community
- Showing empathy towards other community members

## 🛠️ Development Setup

```bash
# Clone the repository
git clone https://github.com/yourusername/t800-ecosystem.git
cd t800-ecosystem

# Verify structure
./scripts/validate-config.sh

# Run tests
./scripts/test-agents.sh

# Test individual agent
./scripts/test-agents.sh t800-main
```

## 🔧 How to Contribute

### Reporting Bugs

1. Check existing issues to avoid duplicates
2. Use the bug report template
3. Include detailed reproduction steps
4. Add logs and screenshots if applicable

### Suggesting Features

1. Check existing issues for similar suggestions
2. Use the feature request template
3. Explain the use case clearly
4. Indicate if you'd like to implement it

### Contributing Code

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Make your changes
4. Run tests (`./scripts/test-agents.sh`)
5. Commit your changes
6. Push to your fork
7. Open a Pull Request

## 📝 Pull Request Process

```
┌─────────────────────────────────────────────────────────────────┐
│                      PR WORKFLOW                                 │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│   Fork ──► Branch ──► Code ──► Test ──► Commit ──► PR          │
│                                                                 │
│   Check:                                                        │
│   ✓ All tests pass                                              │
│   ✓ Documentation updated                                       │
│   ✓ Style guidelines followed                                   │
│   ✓ PR description complete                                     │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

### PR Checklist

- [ ] Tests pass locally
- [ ] Documentation updated (if applicable)
- [ ] Agent configurations valid
- [ ] JSON schemas valid (if applicable)
- [ ] Commit messages are clear

### PR Title Format

```
<type>(<scope>): <description>

Types: feat, fix, docs, style, refactor, test, chore
Scope: learning, telemetry, recovery, patterns, agents, docs

Examples:
feat(learning): add new reflection depth level
fix(telemetry): correct cost calculation formula
docs(patterns): improve ReAct pattern documentation
```

## 🎨 Style Guidelines

### Markdown Files

- Use proper heading hierarchy (H1 → H2 → H3)
- Include table of contents for long documents
- Use code blocks with language specification
- Keep lines under 100 characters when possible

### YAML Frontmatter

```yaml
---
description: Clear description of the agent
mode: primary | subagent
model: model-name
temperature: 0.3
tools:
  tool_name: true | false
---
```

### JSON Schemas

```json
{
  "$schema": "http://json-schema.org/draft-07/schema#",
  "title": "Clear Title",
  "description": "Schema description",
  "type": "object",
  "required": ["field1", "field2"],
  "properties": {
    "field1": {
      "type": "string",
      "description": "Field description"
    }
  }
}
```

## 🧪 Testing

### Running Tests

```bash
# All tests
./scripts/test-agents.sh

# Specific agent
./scripts/test-agents.sh t800-main
./scripts/test-agents.sh t800-questioner
./scripts/test-agents.sh t800-planner

# Validation only
./scripts/validate-config.sh
```

### Test File Structure

```
tests/
├── agents/
│   ├── t800-main.test.md
│   ├── t800-questioner.test.md
│   └── t800-planner.test.md
└── integration/
    └── t800-workflow.test.md
```

### Writing Tests

Test files should include:

1. **Prerequisites** - What must exist before testing
2. **Steps** - Clear, executable steps
3. **Expected Results** - What should happen
4. **Evidence** - How to verify success

## 📂 Project Structure

```
.opencode/
├── agents/          # Agent configurations (YAML + Markdown)
├── skills/          # Skill definitions
├── context/         # Context and standards
├── learning/        # Self-improvement module
├── telemetry/       # Observability module
├── recovery/        # Error handling module
├── patterns/        # Design patterns
├── memory/          # Memory system
├── reasoning/       # Reasoning patterns
└── mcp/             # Integrations

tests/               # Test specifications
scripts/             # Utility scripts
docs/                # Documentation
```

## 🏆 Recognition

Contributors will be recognized in:

- Our README.md contributors section
- Release notes for significant contributions
- GitHub contributors page

## 📧 Contact

- Open an issue for bugs or features
- Discussion for questions
- Security issues: Please use GitHub Security Advisories

---

<div align="center">

```
 ████████╗ █████╗ ███████╗ ██████╗ ██╗    ██╗██╗███╗   ██╗
 ╚══██╔══╝██╔══██╗██╔════╝██╔═══██╗██║    ██║██║████╗  ██║
    ██║   ███████║███████╗██║   ██║██║ █╗ ██║██║██╔██╗ ██║
    ██║   ██╔══██║╚════██║██║   ██║██║███╗██║██║██║╚██╗██║
    ██║   ██║  ██║███████║╚██████╔╝╚███╔███╔╝██║██║ ╚████║
    ╚═╝   ╚═╝  ╚═╝╚══════╝ ╚═════╝  ╚══╝╚══╝ ╚═╝╚═╝  ╚═══╝
              THANK YOU FOR CONTRIBUTING!
```

</div>