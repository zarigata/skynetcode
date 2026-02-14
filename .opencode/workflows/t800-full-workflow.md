# T-800 Full Workflow

## Overview
Complete workflow for T-800 agent system from initial request to final implementation.

## Agent Orchestration Flow

```
┌─────────────┐
│   USER      │
│  (Request)  │
└──────┬──────┘
       │
       ▼
┌─────────────────────────────────────────────────────────────┐
│                      T-800 MAIN AGENT                        │
│                                                              │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐       │
│  │    THINK     │─▶│   QUESTION   │─▶│     PLAN     │       │
│  │   (Analyze)  │  │  (Clarify)   │  │   (Specify)  │       │
│  └──────────────┘  └──────────────┘  └──────────────┘       │
│                            │                   │             │
│                            ▼                   ▼             │
│  ┌──────────────────────────────────────────────────────┐   │
│  │                APPROVAL GATE                          │   │
│  │     User must approve plan before execution          │   │
│  └──────────────────────────────────────────────────────┘   │
│                                              │               │
│                                              ▼               │
│                            ┌──────────────────────┐          │
│                            │      EXECUTE         │          │
│                            │  (Implement Plan)    │          │
│                            └──────────────────────┘          │
└─────────────────────────────────────────────────────────────┘
```

## Subagent Coordination

### Phase 1: Thinking (Main Agent)
The main T-800 agent analyzes the request:
- Identify request type (new feature, bug fix, refactor, etc.)
- Determine complexity level
- Decide questioning strategy

### Phase 2: Questioning (t800-questioner)
Delegates to questioning subagent:
- Load questioning strategies context
- Execute systematic questioning
- Document all clarifications
- Return clarified requirements

### Phase 3: Planning (t800-planner)
Delegates to planning subagent:
- Load planning templates context
- Generate comprehensive plan
- Define all tasks
- Return plan for approval

### Phase 4: Approval Gate
Manual user approval required:
- Present plan to user
- Wait for approval/revision request
- Only proceed if approved

### Phase 5: Execution (t800-executor)
Delegates to execution subagent:
- Load coding standards context
- Execute plan non-stop
- Validate after each task
- Document everything
- Return completion status

## Context Loading Sequence

1. **Main Agent** loads:
   - `.opencode/context/core/t800-standards.md`
   - `.opencode/context/core/t800-workflows.md`

2. **Questioner** loads:
   - `.opencode/context/project-intelligence/questioning-strategies.md`

3. **Planner** loads:
   - `.opencode/context/project-intelligence/planning-templates.md`

4. **Executor** loads:
   - `.opencode/context/core/t800-standards.md`

## Skill Invocation

### When to Use Questioning Skill
Invoke `t800-questioning` skill when:
- New project request received
- Requirements are vague
- Need clarification on scope

### When to Use Planning Skill
Invoke `t800-planning` skill when:
- Requirements are clarified
- Ready to create implementation plan
- Breaking down complex projects

### When to Use Execution Skill
Invoke `t800-execution` skill when:
- Plan has been approved
- Ready to implement
- All requirements clear

## Error Handling

If any phase fails:
1. Document the error
2. Determine root cause
3. Either fix or escalate to user
4. Continue when resolved
