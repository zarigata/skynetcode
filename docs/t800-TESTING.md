# T-800 Testing Guide

## Overview

T-800 includes a comprehensive testing framework for validating agent behavior and integration.

## Test Structure

```
tests/
├── agents/
│   ├── t800-main.test.md        # Main agent tests
│   ├── t800-questioner.test.md  # Questioner tests
│   └── t800-planner.test.md     # Planner tests
└── integration/
    └── t800-workflow.test.md    # End-to-end workflow tests
```

## Running Tests

### All Tests
```bash
./scripts/test-agents.sh
```

### Specific Agent Tests
```bash
# Test main T-800 agent
./scripts/test-agents.sh t800-main

# Test questioner
./scripts/test-agents.sh t800-questioner

# Test planner
./scripts/test-agents.sh t800-planner
```

### Integration Tests
```bash
./scripts/test-agents.sh t800-workflow
```

## Test Categories

### Configuration Tests
Verify agent configuration is valid:
- YAML frontmatter structure
- Required fields exist
- Valid mode and temperature
- Correct tool settings

### Behavior Tests
Verify agent behavior:
- Correct workflow execution
- Proper phase transitions
- Appropriate responses
- Correct delegation

### Integration Tests
Verify end-to-end workflows:
- Agent coordination
- Context loading
- Skill invocation
- Error handling

## Writing New Tests

### Test File Format

```markdown
# [Agent Name] Tests

## Test Suite: [Category]

### Test 1: [Test Name]
**Description**: What this test verifies
**Steps**:
1. [Step 1]
2. [Step 2]
3. [Step 3]

**Expected**: [Expected outcome]

### Test 2: [Test Name]
...
```

### Best Practices

1. **Clear descriptions**: Explain what's being tested
2. **Detailed steps**: Each step should be unambiguous
3. **Specific expectations**: Define exact expected outcomes
4. **One concept per test**: Keep tests focused

## Validation Script

### Running Validation
```bash
./scripts/validate-config.sh
```

### What It Checks

1. **Agent Files**
   - Valid YAML frontmatter
   - Required fields (description, mode, model, tools)
   - Proper separators

2. **Context Files**
   - Files exist
   - Non-empty content

3. **Skill Files**
   - Files exist
   - Non-empty content

## Test-Driven Development

### Adding New Features

1. Write test first in appropriate test file
2. Run tests to see failure
3. Implement feature
4. Run tests to see success

### Example

```markdown
### Test: New Feature Behavior
**Description**: Verify new questioning pattern works
**Steps**:
1. Load context/project-intelligence/questioning-strategies.md
2. Search for "New Strategy" pattern
3. Verify pattern has 5 questions

**Expected**: New strategy is present with all questions
```

## Continuous Integration

Add to CI pipeline:

```yaml
# .github/workflows/test.yml
name: T-800 Tests
on: [push, pull_request]
jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: Validate Configuration
        run: ./scripts/validate-config.sh
      - name: Run Tests
        run: ./scripts/test-agents.sh
```

## Debugging Failed Tests

### Check Configuration
```bash
# Verify YAML syntax
grep "^---$" .opencode/agents/t800.md
grep "^description:" .opencode/agents/t800.md
grep "^mode:" .opencode/agents/t800.md
```

### Check Context Loading
```bash
# Verify context files exist
ls -la .opencode/context/core/
ls -la .opencode/context/project-intelligence/
```

### Check Skills
```bash
# Verify skills exist
ls -la .opencode/skills/
```
