# Pattern Selector

Guidance for choosing the appropriate design pattern.

## Purpose

Provide decision criteria for selecting between the three T-800 design patterns: ReAct, Plan-and-Execute, and Human-in-the-Loop.

## Pattern Overview

| Pattern | Core Idea | Best For |
|---------|-----------|----------|
| **ReAct** | Think → Act → Observe → Repeat | Dynamic environments, exploration |
| **Plan-and-Execute** | Plan all → Execute all → Verify | Predictable workflows, clear requirements |
| **Human-in-the-Loop** | Automate → Escalate at triggers | High-stakes operations, critical decisions |

## Decision Flowchart

```
                   ┌──────────────────────┐
                   │ Is environment        │
                   │ predictable?          │
                   └──────────────────────┘
                        ↓ Yes        ↓ No
              ┌─────────────┐   ┌─────────────┐
              │ Are all     │   │ Use REACT   │
              │ requirements│   │ Pattern     │
              │ known?      │   └─────────────┘
              └─────────────┘
                   ↓ Yes        ↓ No
         ┌──────────────┐  ┌──────────────┐
         │ Is this a    │  │ Use REACT    │
         │ high-stakes  │  │ to discover  │
         │ operation?   │  │ requirements │
         └──────────────┘  └──────────────┘
              ↓ Yes            ↓ No
    ┌──────────────────┐    ┌──────────────────┐
    │ Use PLAN-EXECUTE │    │ Use PLAN-EXECUTE │
    │ with HITL hooks  │    │ Pattern          │
    └──────────────────┘    └──────────────────┘
```

## Selection Criteria

### Choose ReAct When

- ✅ Environment may change during execution
- ✅ Need to observe results before deciding next step
- ✅ Requirements are partially unknown
- ✅ Exploring unfamiliar codebases or systems
- ✅ Debugging issues without clear root cause
- ✅ Integrating with external systems that may behave unexpectedly

### Choose Plan-and-Execute When

- ✅ Environment is stable and predictable
- ✅ All requirements are known upfront
- ✅ Clear sequence of dependencies between steps
- ✅ User wants to review plan before execution
- ✅ Complex multi-step task with clear end goal
- ✅ Can estimate time/cost accurately in advance

### Choose Human-in-the-Loop When

- ✅ High-stakes operations (data loss, security, cost)
- ✅ Multiple valid approaches with different trade-offs
- ✅ User approval required for compliance or governance
- ✅ Confidence in decision is below threshold
- ✅ Operation exceeds cost or time thresholds
- ✅ Requirements could have multiple interpretations

## Pattern Combinations

Patterns can be combined for complex workflows:

### ReAct + HITL

```yaml
scenario: Security investigation
pattern: ReAct for exploration, HITL for security-sensitive actions

flow:
  1. [ReAct] Investigate without escalation
  2. [ReAct] Narrow down root cause
  3. [HITL] Before making security changes, escalate
  4. [HITL] Get approval for fix
  5. [ReAct] Execute and verify
```

### Plan-Execute + HITL

```yaml
scenario: Database migration
pattern: Plan-Execute for structure, HITL for approval checkpoints

flow:
  1. [Plan] Create complete migration plan
  2. [HITL] Request plan approval
  3. [Execute] Run migration steps
  4. [HITL] Checkpoint before destructive changes
  5. [Execute] Complete remaining steps
  6. [Verify] Validate migration success
```

### All Three Combined

```yaml
scenario: Large feature with security implications
pattern: Plan for structure, ReAct for unknowns, HITL for critical points

flow:
  1. [Plan] Overall feature architecture
  2. [HITL] Approve architecture for security
  3. [ReAct] Implement with observation loops
  4. [HITL] Escalate on security-related code
  5. [ReAct] Continue development
  6. [HITL] Final security review
  7. [Execute] Deploy sequentially
```

## Anti-Patterns

### Using ReAct for Simple Tasks

❌ **Inefficient**:
```yaml
task: Create a README file
pattern: ReAct
# Reasoning: Think, act, observe... for a single file?
```

✅ **Efficient**:
```yaml
task: Create a README file
pattern: Plan-and-Execute (simple plan)
# Steps: 1. Create README with basic sections
```

### Using Plan-Execute for Exploration

❌ **Fails**:
```yaml
task: Debug random test failures
pattern: Plan-Execute
# Fails because you can't plan what you don't know
```

✅ **Works**:
```yaml
task: Debug random test failures
pattern: ReAct
# Observe failures, reason about cause, try fixes, observe results
```

### Skipping HITL for High-Stakes

❌ **Dangerous**:
```yaml
task: Delete all temp files older than 30 days
pattern: ReAct (no escalation)
# Risk: Could delete wrong files without confirmation
```

✅ **Safe**:
```yaml
task: Delete all temp files older than 30 days
pattern: HITL + ReAct
# Escalate before deletion, get user confirmation
```

## Quick Reference Table

| Question | ReAct | Plan-Execute | HITL |
|----------|-------|--------------|------|
| Environment predictable? | No need | ✅ Ideal | Consider |
| Requirements complete? | Partial ok | ✅ Must be | Consider |
| High stakes? | Add HITL | Add HITL | ✅ Required |
| Exploration needed? | ✅ Ideal | Avoid | Consider |
| User approval needed? | Add HITL | Add HITL | ✅ Required |
| Time for planning? | Minimal | ✅ Required | Minimal |
| Sequential dependencies? | Handle dynamically | ✅ Handles well | Doesn't affect |

## Configuration

```yaml
pattern_selector:
  default_pattern: react
  
  auto_selection:
    enabled: true
    criteria:
      data_operations: plan_execute+hitl
      debugging: react
      new_feature: plan_execute
      investigation: react
      migration: plan_execute+hitl
      security_ops: hitl
      
  user_override:
    allow: true
    ask_before_overriding_auto: true
```