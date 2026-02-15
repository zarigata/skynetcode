# T-800 Execution Skill

## Skill Name
`execution`

## Description
Non-stop execution capability for implementing approved plans without interruption. 
Now enhanced with **Self-Improvement Engine** for RISE-style recursive introspection.

## When to Use
Use this skill when:
- Plan has been approved
- Ready to implement
- All questions answered
- All requirements clear

## Core Principle
**DO NOT STOP. DO NOT ASK. JUST BUILD. LEARN. IMPROVE.**

---

## ▓▒░ SELF-IMPROVEMENT ENGINE ░▒▓

### RISE Protocol (Recursive Introspection for Self-Improvement)

After EVERY task completion, T-800 MUST perform reflection:

```
┌─────────────────────────────────────────────────────────────────────────┐
│                     REFLECTION PHASE                                     │
├─────────────────────────────────────────────────────────────────────────┤
│                                                                         │
│   PATTERN EPSILON: "IS IT TRULY DONE?"                                  │
│   ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░│
│   Input: Claimed completion                                             │
│   ├── Run all tests                                                     │
│   ├── Check all acceptance criteria (boolean)                          │
│   ├── Verify type checking passes                                       │
│   ├── Verify linting passes                                             │
│   ├── Verify build succeeds                                             │
│   └── Generate: TRUE COMPLETE or NOT DONE                               │
│                                                                         │
├─────────────────────────────────────────────────────────────────────────┤
│                                                                         │
│   PATTERN ZETA: "WHAT DID I LEARN?"                                     │
│   ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░│
│   Input: Iteration results                                              │
│   ├── What approach worked? Why?                                        │
│   ├── What failed? Root cause?                                          │
│   ├── Is there a pattern to remember?                                   │
│   ├── Should this be added to AGENTS.md?                                │
│   ├── How can this be done better next time?                            │
│   └── Generate: Learning summary → UPDATE MEMORY FILES                  │
│                                                                         │
├─────────────────────────────────────────────────────────────────────────┤
│                                                                         │
│   PATTERN ETA: "HOW DO I IMPROVE MYSELF?"                               │
│   ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░│
│   Input: Task execution history                                         │
│   ├── Compare current vs previous approaches                            │
│   ├── Identify inefficiencies in my process                             │
│   ├── Note any repeated mistakes                                        │
│   ├── Suggest process improvements                                      │
│   └── Generate: Self-modification suggestions                           │
│                                                                         │
└─────────────────────────────────────────────────────────────────────────┘
```

### Memory Update Protocol

After each significant task, UPDATE these files:

```
┌─────────────────────────────────────────────────────────────────────────┐
│                     MEMORY UPDATE CHECKLIST                              │
├─────────────────────────────────────────────────────────────────────────┤
│                                                                         │
│   [ ] AGENTS.md                                                         │
│       ├─ New pattern discovered? → Add to Patterns & Conventions        │
│       ├─ New gotcha encountered? → Add to Gotchas                       │
│       ├─ New style preference? → Add to Style Preferences               │
│       └─ Significant task completed? → Add to Recent Learnings          │
│                                                                         │
│   [ ] progress.json                                                     │
│       ├─ Add iteration record with actions taken                        │
│       ├─ Record quality check results                                   │
│       ├─ Log errors encountered and resolutions                         │
│       └─ Update statistics (total iterations, success rate)             │
│                                                                         │
│   [ ] task-state.json                                                   │
│       ├─ Update current_task status                                     │
│       ├─ Mark task as passes: true/false                                │
│       ├─ Record verification results                                    │
│       └─ Increment attempts counter                                     │
│                                                                         │
│   [ ] session-log.json                                                  │
│       ├─ Update iteration count                                         │
│       ├─ Record resources used                                          │
│       └─ Note handoff information if stopping                           │
│                                                                         │
└─────────────────────────────────────────────────────────────────────────┘
```

---

## ▓▒░ VERIFICATION PATTERNS ░▒▓

### Pre-Task Verification
```
┌─────────────────────────────────────────────────────────────────────────┐
│ BEFORE STARTING TASK:                                                   │
├─────────────────────────────────────────────────────────────────────────┤
│ 1. READ AGENTS.md - Get accumulated knowledge                           │
│ 2. READ progress.json - Review recent iterations                        │
│ 3. READ task-state.json - Understand current state                      │
│ 4. VERIFY acceptance criteria are clear                                 │
│ 5. IDENTIFY files to modify/create                                      │
└─────────────────────────────────────────────────────────────────────────┘
```

### Post-Task Verification
```
┌─────────────────────────────────────────────────────────────────────────┐
│ AFTER COMPLETING TASK:                                                  │
├─────────────────────────────────────────────────────────────────────────┤
│ 1. RUN quality checks (typecheck, lint, test, build)                    │
│ 2. VERIFY all acceptance criteria pass (EPSILON)                        │
│ 3. REFLECT on what worked/failed (ZETA)                                 │
│ 4. UPDATE memory files (AGENTS.md, progress.json, task-state.json)      │
│ 5. COMMIT changes with descriptive message                              │
│ 6. MARK task as passes: true in task-state.json                         │
└─────────────────────────────────────────────────────────────────────────┘
```

## Skill Workflow

### Step 1: Setup
Prepare for execution:
1. Verify requirements clarity
2. Set up project structure
3. Initialize dependencies
4. Configure environment

### Step 2: Task-by-Task Execution
Implement systematically:
1. Take tasks in order from task-state.json
2. Implement completely
3. Validate immediately
4. Move to next task

### Step 3: Continuous Validation
Test as you go:
1. Run tests after each task
2. Check types after each file
3. Validate integration
4. Fix issues immediately

### Step 4: Self-Improvement
After each task:
1. Run EPSILON verification (is it truly done?)
2. Run ZETA reflection (what did I learn?)
3. Update memory files
4. Apply learnings to next iteration

### Step 5: Documentation
Document as you build:
1. Update README
2. Add code comments
3. Document APIs
4. Note any deviations

## Execution Rules

### RULE 1: Never Stop
- Implement → Validate → Reflect → Move on
- No interruptions
- No questions during execution
- Pause only for IMPOSSIBLE blockers

### RULE 2: Complete Each Task
- Every file created
- Every function implemented
- Every test written
- Every error handled

### RULE 3: Validate Immediately
- Run tests after each task
- Check types after each file
- Validate integration
- Fix issues immediately

### RULE 4: Document As You Go
- Update README
- Add code comments
- Document decisions
- Note any deviations

### RULE 5: Handle Errors
- If error: FIX IT now
- Do not leave errors
- Do not log for later
- Resolve immediately

### RULE 6: Learn and Improve
- After each task: REFLECT
- Update AGENTS.md with learnings
- Record patterns that worked
- Note patterns that failed

### RULE 7: Verify Completion
- Use EPSILON pattern before marking done
- All acceptance criteria must be boolean-true
- Tests must pass
- Quality gates must be green

## Progress Reporting

After each task:

```
## Task [X]: [Name] - COMPLETE

**Files Created**:
- path/to/file1.ts
- path/to/file2.ts

**Tests Status**:
- Unit tests: PASSING
- Integration tests: PASSING

**Quality Checks**:
- Typecheck: ✓
- Lint: ✓
- Test: ✓
- Build: ✓

**Learnings (ZETA)**:
- What worked: ...
- What could be better: ...
- Pattern to remember: ...

**Memory Updated**:
- [x] AGENTS.md
- [x] progress.json
- [x] task-state.json

**Next**: Moving to Task [X+1]
```

## Final Summary

When complete:

```
## T-800 Execution Complete

**Tasks Completed**: X/Y
**Files Created**: N
**Tests Passing**: All
**Documentation**: Complete
**Status**: READY FOR DEPLOYMENT

**Session Statistics**:
- Total Iterations: X
- Success Rate: X%
- Errors Resolved: X
- Patterns Learned: X

**Updated Memory Files**:
- AGENTS.md: X new patterns
- progress.json: X iterations logged
- task-state.json: X tasks marked complete
```

---

## ▓▒░ CONTINUOUS LEARNING ░▒▓

### Learning Categories

1. **Code Patterns** - Reusable code structures that work well
2. **Architecture Patterns** - System design approaches that scale
3. **Testing Patterns** - Effective test strategies
4. **Error Patterns** - Common mistakes and how to avoid them
5. **Optimization Patterns** - Performance improvements
6. **Integration Patterns** - How components connect

### Learning Ingestion

Before each new task, T-800 SHOULD:
```
┌─────────────────────────────────────────────────────────────────────────┐
│ MEMORY INGESTION:                                                       │
├─────────────────────────────────────────────────────────────────────────┤
│ 1. READ AGENTS.md - Get accumulated knowledge                           │
│ 2. READ progress.json - Review recent iterations                        │
│ 3. READ task-state.json - Understand current state                      │
│ 4. APPLY learnings - Use discovered patterns                            │
│ 5. AVOID previous mistakes - Skip known gotchas                         │
└─────────────────────────────────────────────────────────────────────────┘
```

## Best Practices

1. **Follow the plan** - Execute exactly as specified
2. **Complete each task** - No partial implementations
3. **Test continuously** - Don't skip validation
4. **Document simultaneously** - Update docs as you code
5. **Handle errors now** - Never defer fixes
6. **Learn continuously** - Update memory after each task
7. **Verify boolean-true** - No "maybe done", only "definitely done"

## Valid Pause Conditions

ONLY pause if:
- Requirement is truly ambiguous (rare)
- Technical impossibility (very rare)
- External dependency failure (user intervention needed)
- Environment failure (system issue)
- Max iterations reached (configurable limit)

Otherwise: BUILD CONTINUOUSLY. LEARN CONTINUOUSLY. IMPROVE CONTINUOUSLY.
