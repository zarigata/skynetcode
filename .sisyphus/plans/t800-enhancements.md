# T-800 Enhancement Ecosystem

## TL;DR

> **Quick Summary**: Build 4 enhancement modules for the T-800 agent ecosystem: Self-Improvement (RISE-style introspection), Telemetry & Observability (execution tracing, cost tracking), Failure Recovery (SHIELDA-style exception handling), and Advanced Design Patterns (ReAct, Plan-and-Execute, Human-in-the-loop). Each module integrates with existing T-800 agents as library-based components with opt-in activation.
>
> **Deliverables**:
> - `.opencode/learning/` - Self-Improvement module (6 files)
> - `.opencode/telemetry/` - Telemetry module (6 files)
> - `.opencode/recovery/` - Failure Recovery module (7 files)
> - `.opencode/patterns/` - Design Patterns module (5 files)
> - Tests for each module
> - Integration documentation
>
> **Estimated Effort**: Large
> **Parallel Execution**: YES - 4 waves (one per enhancement)
> **Critical Path**: Wave 1 → Wave 2 → Wave 3 → Wave 4 (sequential dependencies for data structures)

---

## Context

### Original Request
Enhance the existing T-800 agent ecosystem (30 files already built) with 4 major enhancement systems:
1. **Self-Improvement System**: RISE-style recursive introspection, learning from failed attempts
2. **Telemetry & Observability**: Execution tracing, cost tracking, quality metrics
3. **Failure Recovery System**: SHIELDA-style exception handling, escalation pathways
4. **Advanced Design Patterns**: ReAct, Plan-and-Execute, Human-in-the-loop

User confirmed: "One at a time, Yes, add ALL enhancements" - implement sequentially, test each before proceeding.

### Interview Summary
**Key Discussions**:
- **Priority Order**: Self-Improvement → Telemetry → Recovery → Patterns (dependency chain)
- **Integration Type**: Library-based modules (not subagents), opt-in activation per session
- **Data Storage**: JSON files following existing `.opencode/memory/system.md` patterns
- **Scope**: Each enhancement max 8 files, no external dependencies, filesystem-based

**Research Findings**:
- **RISE**: Recursive introspection via multi-turn MDP, iterative fine-tuning with environment feedback
- **Gödel Agent**: Self-referential framework for recursive self-improvement
- **AgentOps**: Open-source monitoring SDK (MIT, 5282 stars) - concepts for telemetry
- **SHIELDA**: 36 exception types taxonomy, exception classifier, handling pattern registry
- **Design Patterns**: ReAct (interleaved reason-act), Plan-and-Execute (sequential), Human-in-the-loop (escalation)

### Metis Review
**Identified Gaps** (addressed):
- **Integration Architecture**: Resolved as library-based modules with opt-in activation
- **Data Storage Format**: Resolved as JSON files (consistent with existing memory system)
- **File Count Guardrail**: Set max 8 files per enhancement
- **Exception Types**: Using top 10 most common (not full SHIELDA 36)
- **Scope Creep Prevention**: Analysis-only for self-improvement, logs-only for telemetry, manual-options for recovery

---

## Work Objectives

### Core Objective
Extend the T-800 agent ecosystem with 4 production-ready enhancement modules that integrate seamlessly with existing agents (t800, t800-questioner, t800-planner, t800-executor) and provide introspection, monitoring, recovery, and pattern-guided execution capabilities.

### Concrete Deliverables

**Wave 1: Self-Improvement System**
- `.opencode/learning/reflection-engine.md` - Core reflection logic
- `.opencode/learning/feedback-processor.md` - Process success/failure outcomes
- `.opencode/learning/pattern-extractor.md` - Extract reusable patterns
- `.opencode/learning/schemas/session.json` - Session data schema
- `.opencode/learning/schemas/recommendation.json` - Recommendation schema
- `tests/enhancements/learning.test.md` - Test specifications

**Wave 2: Telemetry & Observability**
- `.opencode/telemetry/trace-collector.md` - Collect execution traces
- `.opencode/telemetry/metrics-aggregator.md` - Aggregate performance data
- `.opencode/telemetry/cost-tracker.md` - Track LLM costs (token-based)
- `.opencode/telemetry/schemas/trace.json` - Trace data schema
- `.opencode/telemetry/schemas/metrics.json` - Metrics schema
- `tests/enhancements/telemetry.test.md` - Test specifications

**Wave 3: Failure Recovery System**
- `.opencode/recovery/exception-classifier.md` - Classify top 10 exception types
- `.opencode/recovery/handling-patterns.md` - Registry of recovery patterns
- `.opencode/recovery/escalation-manager.md` - Human escalation logic
- `.opencode/recovery/state-recovery.md` - Rollback/retry mechanisms
- `.opencode/recovery/schemas/exception.json` - Exception schema
- `.opencode/recovery/schemas/recovery.json` - Recovery action schema
- `tests/enhancements/recovery.test.md` - Test specifications

**Wave 4: Design Patterns**
- `.opencode/patterns/react.md` - ReAct reasoning pattern documentation
- `.opencode/patterns/plan-execute.md` - Plan-and-Execute workflow documentation
- `.opencode/patterns/human-loop.md` - Human-in-the-loop integration documentation
- `.opencode/patterns/pattern-selector.md` - Pattern selection guidance
- `tests/enhancements/patterns.test.md` - Test specifications

**Integration Files**
- `.opencode/enhancements/README.md` - Enhancement ecosystem overview
- `.opencode/enhancements/integration.md` - How to enable/configure each enhancement

### Definition of Done
- [ ] All 4 modules created with complete documentation
- [ ] Each module has JSON schemas for data structures
- [ ] Each module has markdown test specifications
- [ ] Integration README documents opt-in activation
- [ ] No circular dependencies between enhancements
- [ ] Load verification: each enhancement loads without errors in isolation

### Must Have
- JSON-file-based data storage (no SQLite, no external services)
- Opt-in activation (never auto-enabled without user action)
- Integration hooks for T-800 agents
- Executable acceptance criteria for each feature
- Documentation with real examples

### Must NOT Have (Guardrails)
- **NO** automatic code modification in self-improvement (analysis + recommendations only)
- **NO** web UI or visualization dashboard for telemetry (log files only)
- **NO** automatic error fixing in recovery (manual options, user choice)
- **NO** more than 3 design patterns (exactly: ReAct, Plan-and-Execute, Human-in-the-loop)
- **NO** network transmission of telemetry data (local filesystem only)
- **NO** PII collection in any enhancement
- **NO** recursive self-modification loops without termination conditions
- **NO** more than 8 files per enhancement

---

## Verification Strategy (MANDATORY)

### Test Decision
- **Infrastructure exists**: NO (tests are markdown specs)
- **Automated tests**: NO - markdown test specifications only
- **Framework**: None (consistent with existing T-800 test structure)
- **Agent-Executed QA**: YES - scenarios executed by agent via tools

### Agent-Executed QA Scenarios (MANDATORY — ALL tasks)

**Scenario: Self-Improvement Session Analysis**
```
Tool: Bash (shell commands)
Preconditions: T-800 session completed with task history
Steps:
  1. Check file exists: test -f .opencode/learning/sessions/$(date +%Y-%m-%d).json
  2. Validate JSON: jq '.' .opencode/learning/sessions/$(date +%Y-%m-%d).json > /dev/null
  3. Check required fields: jq 'keys | contains(["task_count", "success_rate", "duration_ms", "patterns"])' .opencode/learning/sessions/$(date +%Y-%m-%d).json
  4. Run 3 test sessions and verify each creates a valid session file
Expected Result: Each session creates valid JSON with all required fields
Evidence: Session files in .opencode/learning/sessions/
```

**Scenario: Telemetry Trace Collection**
```
Tool: Bash (shell commands)
Preconditions: T-800 workflow executed with multiple tool calls
Steps:
  1. Check trace file: ls -la .opencode/telemetry/traces/$(date +%Y-%m-%d)*.json
  2. Validate structure: jq '.events | length > 0' [trace-file]
  3. Check event fields: jq '.events[0] | keys | contains(["tool", "duration_ms", "timestamp", "success"])' [trace-file]
  4. Calculate session cost: jq '.cost.total' [trace-file]
Expected Result: Trace contains events with all required fields, cost calculated
Evidence: Trace files in .opencode/telemetry/traces/
```

**Scenario: Exception Classification**
```
Tool: Bash (shell commands)
Preconditions: Simulated error types in test data
Steps:
  1. Run classifier test: ./scripts/test-recovery.sh classify
  2. Check classification output: jq '.classified | length == 5' .opencode/recovery/test-output.json
  3. Verify match rate: jq '.match_rate >= 0.8' .opencode/recovery/test-output.json
  4. Check patterns exist for each classified type
Expected Result: >=80% classification match rate, all patterns exist
Evidence: Test output file .opencode/recovery/test-output.json
```

**Scenario: Design Pattern Documentation Load**
```
Tool: Bash (shell commands)
Preconditions: Pattern files created
Steps:
  1. Check ReAct pattern: test -f .opencode/patterns/react.md && grep -q "Reason" .opencode/patterns/react.md
  2. Check Plan-Execute: test -f .opencode/patterns/plan-execute.md && grep -q "Plan" .opencode/patterns/plan-execute.md
  3. Check Human-loop: test -f .opencode/patterns/human-loop.md && grep -q "escalation" .opencode/patterns/human-loop.md
  4. Validate all patterns loadable: grep -l "Pattern:" .opencode/patterns/*.md | wc -l (expect 3)
Expected Result: All 3 patterns documented and loadable
Evidence: Pattern files in .opencode/patterns/
```

---

## Execution Strategy

### Parallel Execution Waves

```
Wave 1 (Start Immediately):
└── Task 1: Self-Improvement System (no dependencies, foundational)

Wave 2 (After Wave 1):
└── Task 2: Telemetry System (uses Wave 1 data structures)

Wave 3 (After Wave 2):
└── Task 3: Failure Recovery System (uses Wave 2 telemetry for detection)

Wave 4 (After Wave 3):
└── Task 4: Design Patterns (uses Wave 3 recovery for pattern selection)

Final Integration:
└── Task 5: Integration documentation and README

Critical Path: Task 1 → Task 2 → Task 3 → Task 4 → Task 5
Sequential Required: Data structure dependencies between waves
```

### Dependency Matrix

| Task | Depends On | Blocks | Can Parallelize With |
|------|------------|--------|---------------------|
| 1 | None | 2 | None (foundational) |
| 2 | 1 | 3 | None |
| 3 | 2 | 4 | None |
| 4 | 3 | 5 | None |
| 5 | 1, 2, 3, 4 | None | None (final) |

### Agent Dispatch Summary

| Wave | Tasks | Recommended Agents |
|------|-------|-------------------|
| 1 | Self-Improvement | task(category="unspecified-high", load_skills=[]) - Complex system design |
| 2 | Telemetry | task(category="unspecified-high", load_skills=[]) - Data collection system |
| 3 | Recovery | task(category="unspecified-high", load_skills=[]) - Error handling system |
| 4 | Patterns | task(category="writing", load_skills=[]) - Documentation task |
| 5 | Integration | task(category="unspecified-low", load_skills=[]) - Documentation integration |

---

## TODOs

- [ ] 1. Self-Improvement System

  **What to do**:
  - Create `.opencode/learning/reflection-engine.md` with RISE-style introspection logic
  - Create `.opencode/learning/feedback-processor.md` for processing success/failure outcomes
  - Create `.opencode/learning/pattern-extractor.md` for extracting reusable patterns
  - Create `.opencode/learning/schemas/session.json` with schema: `{timestamp, task_count, success_rate, duration_ms, patterns: [], recommendations: []}`
  - Create `.opencode/learning/schemas/recommendation.json` with schema: `{id, type, priority, description, rationale, created_at}`
  - Create `tests/enhancements/learning.test.md` with test scenarios
  - Integrate with existing T-800 workflow phases (THINK → QUESTION → PLAN → EXECUTE)
  
  **Must NOT do**:
  - Auto-apply recommendations to code (analysis only)
  - Infinite introspection loops without termination
  - Send introspection data externally

  **Recommended Agent Profile**:
  - **Category**: `unspecified-high`
    - Reason: Complex system design requiring architectural thinking
  - **Skills**: None required
    - Documentation and schema design task

  **Parallelization**:
  - **Can Run In Parallel**: NO
  - **Parallel Group**: Wave 1 (sequential start)
  - **Blocks**: Task 2 (Telemetry depends on session data structure)
  - **Blocked By**: None (can start immediately)

  **References**:
  - `.opencode/memory/system.md:1-100` - Existing memory system structure to follow
  - `.opencode/agents/t800.md:1-50` - Main agent to integrate with
  - `.opencode/context/core/t800-workflows.md:1-50` - Workflow phases to hook into
  - `.opencode/skills/t800-execution.md:1-30` - Execution skill where self-improvement triggers

  **Acceptance Criteria**:
  - [ ] Directory `.opencode/learning/` exists with all 4 markdown files
  - [ ] Directory `.opencode/learning/schemas/` exists with 2 JSON schemas
  - [ ] Session schema validates: `jq '.' .opencode/learning/schemas/session.json > /dev/null` returns 0
  - [ ] Recommendation schema validates: `jq '.' .opencode/learning/schemas/recommendation.json > /dev/null` returns 0
  - [ ] Reflection engine references existing memory system
  - [ ] Test file exists with 3+ test scenarios

  **Agent-Executed QA Scenarios**:
  ```
  Scenario: Session analysis creates valid JSON
    Tool: Bash
    Preconditions: Reflection engine files created
    Steps:
      1. Create test session: mkdir -p .opencode/learning/sessions
      2. Write test data: echo '{"task_count":5,"success_rate":0.8,"duration_ms":12000,"patterns":[],"recommendations":[]}' > .opencode/learning/sessions/test.json
      3. Validate: jq 'keys | contains(["task_count", "success_rate", "duration_ms", "patterns", "recommendations"])' .opencode/learning/sessions/test.json
    Expected Result: JSON is valid and contains all required fields
    Evidence: .opencode/learning/sessions/test.json

  Scenario: Pattern extractor references memory system
    Tool: Bash
    Preconditions: Memory system exists at .opencode/memory/system.md
    Steps:
      1. Check reference: grep -l "memory" .opencode/learning/pattern-extractor.md
      2. Check long-term memory: grep -l "Long-Term Memory" .opencode/learning/pattern-extractor.md || echo "Reference needed"
    Expected Result: Pattern extractor integrates with existing memory types
    Evidence: Pattern extractor file content

  Scenario: Schemas define all required fields
    Tool: Bash
    Preconditions: Schema files created
    Steps:
      1. Session schema has fields: jq '.properties | keys' .opencode/learning/schemas/session.json
      2. Recommendation schema has fields: jq '.properties | keys' .opencode/learning/schemas/recommendation.json
    Expected Result: All required fields defined in schemas
    Evidence: Schema file content
  ```

  **Commit**: YES (Wave 1)
  - Message: `feat(learning): add self-improvement system with RISE-style introspection`
  - Files: `.opencode/learning/`, `tests/enhancements/learning.test.md`
  - Pre-commit: verify all files exist and schemas are valid JSON

---

- [ ] 2. Telemetry & Observability System

  **What to do**:
  - Create `.opencode/telemetry/trace-collector.md` for collecting step-by-step execution traces
  - Create `.opencode/telemetry/metrics-aggregator.md` for aggregating performance data
  - Create `.opencode/telemetry/cost-tracker.md` for LLM cost calculation (input_tokens × $0.003 + output_tokens × $0.015)
  - Create `.opencode/telemetry/schemas/trace.json` with schema: `{session_id, timestamp, events: [{tool, duration_ms, timestamp, success, tokens_in, tokens_out}]}`
  - Create `.opencode/telemetry/schemas/metrics.json` with schema: `{session_id, total_events, total_duration_ms, total_cost, success_rate}`
  - Create `tests/enhancements/telemetry.test.md` with test scenarios
  - Hook trace collection into T-800 execution skill

  **Must NOT do**:
  - Network transmission of telemetry data
  - Collect PII (passwords, API keys, personal data)
  - Build visualization dashboard
  - Add >100ms overhead per operation

  **Recommended Agent Profile**:
  - **Category**: `unspecified-high`
    - Reason: Data collection system with performance constraints
  - **Skills**: None required
    - Documentation and schema design task

  **Parallelization**:
  - **Can Run In Parallel**: NO
  - **Parallel Group**: Wave 2 (sequential)
  - **Blocks**: Task 3 (Recovery uses telemetry for failure detection)
  - **Blocked By**: Task 1 (uses session structure from Wave 1)

  **References**:
  - `.opencode/learning/schemas/session.json` - Session structure to extend
  - `.opencode/skills/t800-execution.md:1-50` - Execution skill to hook for tracing
  - `.opencode/context/core/t800-standards.md:1-30` - Coding standards for telemetry

  **Acceptance Criteria**:
  - [ ] Directory `.opencode/telemetry/` exists with all 3 markdown files
  - [ ] Directory `.opencode/telemetry/schemas/` exists with 2 JSON schemas
  - [ ] Trace schema includes: session_id, timestamp, events array
  - [ ] Events have required fields: tool, duration_ms, timestamp, success
  - [ ] Cost tracker formula documented: `(tokens_in × 0.003) + (tokens_out × 0.015)`
  - [ ] Test file exists with 3+ test scenarios

  **Agent-Executed QA Scenarios**:
  ```
  Scenario: Trace collection creates valid trace file
    Tool: Bash
    Preconditions: Telemetry files created
    Steps:
      1. Create test trace: mkdir -p .opencode/telemetry/traces
      2. Write test trace: echo '{"session_id":"test-123","timestamp":"2024-01-01T00:00:00Z","events":[{"tool":"read","duration_ms":50,"timestamp":"2024-01-01T00:00:01Z","success":true}]}' > .opencode/telemetry/traces/test.json
      3. Validate structure: jq '.events | length == 1' .opencode/telemetry/traces/test.json
    Expected Result: Trace file is valid JSON with events array
    Evidence: .opencode/telemetry/traces/test.json

  Scenario: Metrics aggregation calculates correctly
    Tool: Bash
    Preconditions: Metrics aggregator created
    Steps:
      1. Check aggregator has formulas: grep -E "(success_rate|total_cost|duration)" .opencode/telemetry/metrics-aggregator.md
      2. Verify cost calculation: grep "0.003\|0.015" .opencode/telemetry/cost-tracker.md
    Expected Result: All calculation formulas documented
    Evidence: Metrics aggregator file content

  Scenario: No PII collection documented
    Tool: Bash
    Preconditions: All telemetry files created
    Steps:
      1. Check PII exclusion: grep -i "no.*pii\|no.*password\|no.*api_key" .opencode/telemetry/trace-collector.md || echo "PII exclusion needed"
    Expected Result: PII exclusion explicitly documented
    Evidence: Trace collector file content
  ```

  **Commit**: YES (Wave 2)
  - Message: `feat(telemetry): add execution tracing and cost tracking`
  - Files: `.opencode/telemetry/`, `tests/enhancements/telemetry.test.md`
  - Pre-commit: verify schemas are valid JSON

---

- [ ] 3. Failure Recovery System

  **What to do**:
  - Create `.opencode/recovery/exception-classifier.md` with top 10 exception types:
    1. `TOOL_NOT_FOUND` - Tool doesn't exist
    2. `TOOL_TIMEOUT` - Tool execution exceeded time limit
    3. `INVALID_INPUT` - Input validation failed
    4. `PERMISSION_DENIED` - Insufficient permissions
    5. `RESOURCE_NOT_FOUND` - File/resource doesn't exist
    6. `RATE_LIMITED` - API rate limit hit
    7. `NETWORK_ERROR` - Network connectivity issue
    8. `STATE_ERROR` - Invalid state transition
    9. `CONTEXT_OVERFLOW` - Context window exceeded
    10. `UNEXPECTED_OUTPUT` - Tool returned unexpected format
  - Create `.opencode/recovery/handling-patterns.md` with recovery patterns for each type
  - Create `.opencode/recovery/escalation-manager.md` with human escalation logic
  - Create `.opencode/recovery/state-recovery.md` with rollback and retry mechanisms
  - Create `.opencode/recovery/schemas/exception.json` with schema: `{type, message, timestamp, context, stack_trace}`
  - Create `.opencode/recovery/schemas/recovery.json` with schema: `{action, parameters, timeout_ms, fallback_action}`
  - Create `tests/enhancements/recovery.test.md` with test scenarios

  **Must NOT do**:
  - Auto-fix errors without user confirmation
  - Infinite retry loops (max 3 retries)
  - Recover from disk-full or system-critical errors
  - Silent retries without logging

  **Recommended Agent Profile**:
  - **Category**: `unspecified-high`
    - Reason: Critical error handling system requiring careful design
  - **Skills**: None required
    - Documentation and schema design task

  **Parallelization**:
  - **Can Run In Parallel**: NO
  - **Parallel Group**: Wave 3 (sequential)
  - **Blocks**: Task 4 (Patterns use recovery for escalation guidance)
  - **Blocked By**: Task 2 (uses telemetry for failure detection)

  **References**:
  - `.opencode/telemetry/schemas/trace.json` - Trace structure for failure detection
  - `.opencode/agents/t800-executor.md:1-50` - Executor agent to integrate recovery
  - `.opencode/skills/t800-execution.md:1-50` - Execution skill where recovery triggers

  **Acceptance Criteria**:
  - [ ] Directory `.opencode/recovery/` exists with all 4 markdown files
  - [ ] Directory `.opencode/recovery/schemas/` exists with 2 JSON schemas
  - [ ] Exactly 10 exception types documented with classification rules
  - [ ] Exactly 3 recovery options documented per type: retry, fallback, escalate
  - [ ] Max retry count documented as 3
  - [ ] Timeout documented as 30 seconds max
  - [ ] Test file exists with 5+ test scenarios (one per exception category)

  **Agent-Executed QA Scenarios**:
  ```
  Scenario: Exception classifier handles all 10 types
    Tool: Bash
    Preconditions: Classifier file created
    Steps:
      1. Count exception types: grep -c "^## " .opencode/recovery/exception-classifier.md (expect >= 10)
      2. Verify each has pattern: grep -c "Pattern:" .opencode/recovery/exception-classifier.md (expect >= 10)
    Expected Result: All 10 exception types documented with patterns
    Evidence: Classifier file line count

  Scenario: Recovery options available for each type
    Tool: Bash
    Preconditions: Handling patterns created
    Steps:
      1. Check retry option: grep -c "retry" .opencode/recovery/handling-patterns.md (expect >= 10)
      2. Check fallback option: grep -c "fallback" .opencode/recovery/handling-patterns.md (expect >= 10)
      3. Check escalation: grep -c "escalat" .opencode/recovery/handling-patterns.md (expect >= 10)
    Expected Result: Each type has 3 recovery options
    Evidence: Pattern file grep counts

  Scenario: Retry limit enforced
    Tool: Bash
    Preconditions: State recovery created
    Steps:
      1. Find max retries: grep -E "max.*retry|retry.*3|retries.*3" .opencode/recovery/state-recovery.md
    Expected Result: Max 3 retries documented
    Evidence: State recovery file content

  Scenario: Schemas validate exception structure
    Tool: Bash
    Preconditions: Schema files created
    Steps:
      1. Exception schema: jq '.properties | keys | contains(["type", "message", "timestamp"])' .opencode/recovery/schemas/exception.json
      2. Recovery schema: jq '.properties | keys | contains(["action", "parameters"])' .opencode/recovery/schemas/recovery.json
    Expected Result: All required fields present in schemas
    Evidence: Schema validation output
  ```

  **Commit**: YES (Wave 3)
  - Message: `feat(recovery): add failure recovery with SHIELDA-style exception handling`
  - Files: `.opencode/recovery/`, `tests/enhancements/recovery.test.md`
  - Pre-commit: verify schemas valid, exception count = 10

---

- [ ] 4. Design Patterns Documentation

  **What to do**:
  - Create `.opencode/patterns/react.md` documenting ReAct (Reason + Act) pattern:
    - Description: Interleaved reasoning and action
    - When to use: Dynamic environments, need observation between steps
    - Workflow: Reason → Act → Observe → Repeat
    - Examples: 3 real-world examples from T-800 context
    - Integration: How T-800 uses this pattern
  - Create `.opencode/patterns/plan-execute.md` documenting Plan-and-Execute pattern:
    - Description: Create complete plan first, then execute
    - When to use: Predictable environments, complex multi-step tasks
    - Workflow: Plan all → Execute all → Verify
    - Examples: 3 real-world examples from T-800 context
    - Integration: How T-800 uses this pattern
  - Create `.opencode/patterns/human-loop.md` documenting Human-in-the-loop pattern:
    - Description: Escalate to human for critical decisions
    - Trigger conditions: 5 specific scenarios (low confidence, high cost, data loss risk, security impact, ambiguous intent)
    - Workflow: Execute → Detect trigger → Escalate → Wait for human → Continue
    - Examples: 3 real-world examples from T-800 context
    - Integration: How T-800 uses this pattern
  - Create `.opencode/patterns/pattern-selector.md` with guidance on choosing patterns
  - Create `tests/enhancements/patterns.test.md` with test scenarios

  **Must NOT do**:
  - Add more than 3 patterns (exactly ReAct, Plan-and-Execute, Human-in-the-loop)
  - Implement pattern selection logic (guidance only)
  - Force pattern usage (advisory documentation)

  **Recommended Agent Profile**:
  - **Category**: `writing`
    - Reason: Pure documentation task
  - **Skills**: None required
    - Technical writing task

  **Parallelization**:
  - **Can Run In Parallel**: NO
  - **Parallel Group**: Wave 4 (sequential)
  - **Blocks**: Task 5 (Integration docs reference patterns)
  - **Blocked By**: Task 3 (Uses recovery for escalation guidance)

  **References**:
  - `.opencode/recovery/escalation-manager.md` - Escalation logic for Human-in-the-loop
  - `.opencode/context/core/t800-workflows.md:1-50` - Workflow phases to align with patterns
  - `.opencode/skills/t800-planning.md:1-50` - Planning skill for Plan-and-Execute
  - `.opencode/skills/t800-execution.md:1-50` - Execution skill for ReAct

  **Acceptance Criteria**:
  - [ ] Directory `.opencode/patterns/` exists with 4 markdown files
  - [ ] Each pattern file has: Description, When to use, Workflow, 3 Examples, Integration
  - [ ] ReAct pattern has Reason → Act → Observe → Repeat workflow
  - [ ] Plan-and-Execute has Plan all → Execute all → Verify workflow
  - [ ] Human-in-the-loop has exactly 5 trigger conditions documented
  - [ ] Pattern selector provides decision guidance (not auto-selection)
  - [ ] Test file exists with verification scenarios

  **Agent-Executed QA Scenarios**:
  ```
  Scenario: ReAct pattern documented correctly
    Tool: Bash
    Preconditions: ReAct file created
    Steps:
      1. Check workflow: grep "Reason.*Act.*Observe" .opencode/patterns/react.md
      2. Count examples: grep -c "^### Example\|^## Example" .opencode/patterns/react.md (expect >= 3)
    Expected Result: Workflow documented with 3+ examples
    Evidence: ReAct file content

  Scenario: Plan-and-Execute pattern documented correctly
    Tool: Bash
    Preconditions: Plan-Execute file created
    Steps:
      1. Check workflow: grep "Plan.*Execute.*Verify" .opencode/patterns/plan-execute.md
      2. Count examples: grep -c "^### Example\|^## Example" .opencode/patterns/plan-execute.md (expect >= 3)
    Expected Result: Workflow documented with 3+ examples
    Evidence: Plan-Execute file content

  Scenario: Human-in-the-loop has 5 trigger conditions
    Tool: Bash
    Preconditions: Human-loop file created
    Steps:
      1. Count triggers: grep -c "^- \*\*Trigger\|Trigger condition" .opencode/patterns/human-loop.md (expect >= 5)
      2. Verify escalation: grep -i "escalat" .opencode/patterns/human-loop.md
    Expected Result: 5 trigger conditions documented with escalation logic
    Evidence: Human-loop file content

  Scenario: Pattern selector provides guidance
    Tool: Bash
    Preconditions: Selector file created
    Steps:
      1. Check decision criteria: grep -i "when to use\|choose\|select" .opencode/patterns/pattern-selector.md
    Expected Result: Selection guidance provided (not auto-selection)
    Evidence: Selector file content
  ```

  **Commit**: YES (Wave 4)
  - Message: `docs(patterns): add design pattern documentation (ReAct, Plan-Execute, Human-in-the-loop)`
  - Files: `.opencode/patterns/`, `tests/enhancements/patterns.test.md`
  - Pre-commit: verify exactly 3 pattern files, each has required sections

---

- [ ] 5. Integration Documentation

  **What to do**:
  - Create `.opencode/enhancements/README.md` with:
    - Overview of all 4 enhancement modules
    - Quick start for enabling each enhancement
    - Configuration options
    - Integration diagram
  - Create `.opencode/enhancements/integration.md` with:
    - How to enable Self-Improvement (config flag)
    - How to enable Telemetry (config flag)
    - How to enable Recovery (config flag)
    - How to enable Patterns (config flag)
    - Hook points in T-800 workflow phases
    - Example configuration snippets
    - Troubleshooting guide
  - Update `.opencode/agents/t800.md` to reference enhancement hooks
  - Update existing test runner to include enhancement tests

  **Must NOT do**:
  - Enable enhancements by default (opt-in only)
  - Create web UI or dashboard
  - Add npm dependencies
  - Modify T-800 core logic beyond adding hook points

  **Recommended Agent Profile**:
  - **Category**: `unspecified-low`
    - Reason: Documentation integration task
  - **Skills**: None required
    - Documentation task

  **Parallelization**:
  - **Can Run In Parallel**: NO
  - **Parallel Group**: Final (sequential)
  - **Blocks**: None
  - **Blocked By**: Tasks 1, 2, 3, 4 (all enhancements must exist)

  **References**:
  - `.opencode/agents/t800.md` - Main agent to update with hooks
  - `.opencode/context/core/t800-workflows.md` - Workflow phases to document hooks
  - `scripts/test-agents.sh` - Test runner to update
  - All enhancement files created in Waves 1-4

  **Acceptance Criteria**:
  - [ ] Directory `.opencode/enhancements/` exists with README.md and integration.md
  - [ ] README lists all 4 enhancements with quick start
  - [ ] Integration.md documents opt-in configuration for each enhancement
  - [ ] T-800 main agent references enhancement hooks
  - [ ] Test runner includes enhancement tests
  - [ ] No circular dependencies between enhancements

  **Agent-Executed QA Scenarios**:
  ```
  Scenario: README documents all enhancements
    Tool: Bash
    Preconditions: README created
    Steps:
      1. Check learning: grep -i "self-improvement\|learning" .opencode/enhancements/README.md
      2. Check telemetry: grep -i "telemetry\|observability" .opencode/enhancements/README.md
      3. Check recovery: grep -i "recovery\|failure" .opencode/enhancements/README.md
      4. Check patterns: grep -i "pattern\|react\|plan-execute\|human" .opencode/enhancements/README.md
    Expected Result: All 4 enhancements mentioned
    Evidence: README grep output

  Scenario: Integration documents opt-in configuration
    Tool: Bash
    Preconditions: Integration doc created
    Steps:
      1. Check opt-in for learning: grep -i "learning.*enable\|enable.*learning" .opencode/enhancements/integration.md
      2. Check opt-in for telemetry: grep -i "telemetry.*enable\|enable.*telemetry" .opencode/enhancements/integration.md
      3. Check opt-in for recovery: grep -i "recovery.*enable\|enable.*recovery" .opencode/enhancements/integration.md
      4. Check opt-in for patterns: grep -i "pattern.*enable\|enable.*pattern" .opencode/enhancements/integration.md
    Expected Result: Each enhancement has opt-in configuration
    Evidence: Integration doc grep output

  Scenario: No circular dependencies
    Tool: Bash
    Preconditions: All files created
    Steps:
      1. Check Learning imports: grep -r "import.*telemetry\|import.*recovery\|import.*pattern" .opencode/learning/ (expect empty or self-reference only)
      2. Check Telemetry imports: grep -r "import.*recovery\|import.*pattern" .opencode/telemetry/ (expect empty or self-reference only)
      3. Check Recovery imports: grep -r "import.*pattern" .opencode/recovery/ (expect empty or self-reference only)
      4. If any imports found across enhancements, count as circular dependency
    Expected Result: No circular imports between enhancement directories
    Evidence: Grep output (should be minimal)

  Scenario: T-800 references enhancement hooks
    Tool: Bash
    Preconditions: T-800 agent updated
    Steps:
      1. Check for enhancements reference: grep -i "enhancement\|learning\|telemetry\|recovery\|pattern" .opencode/agents/t800.md
    Expected Result: T-800 agent mentions enhancement integration points
    Evidence: T-800 agent file content
  ```

  **Commit**: YES (Final)
  - Message: `docs(enhancements): add integration documentation and update T-800 agents`
  - Files: `.opencode/enhancements/`, `.opencode/agents/t800.md`, `scripts/test-agents.sh`
  - Pre-commit: verify no circular dependencies, all enhancements documented

---

## Commit Strategy

| After Task | Message | Files | Verification |
|------------|---------|-------|--------------|
| 1 | `feat(learning): add self-improvement system with RISE-style introspection` | `.opencode/learning/`, `tests/enhancements/learning.test.md` | schemas valid JSON |
| 2 | `feat(telemetry): add execution tracing and cost tracking` | `.opencode/telemetry/`, `tests/enhancements/telemetry.test.md` | schemas valid JSON |
| 3 | `feat(recovery): add failure recovery with SHIELDA-style exception handling` | `.opencode/recovery/`, `tests/enhancements/recovery.test.md` | 10 exception types |
| 4 | `docs(patterns): add design pattern documentation` | `.opencode/patterns/`, `tests/enhancements/patterns.test.md` | 3 patterns each with 3 examples |
| 5 | `docs(enhancements): add integration documentation and update T-800 agents` | `.opencode/enhancements/`, `.opencode/agents/t800.md`, `scripts/test-agents.sh` | no circular deps |

---

## Success Criteria

### Verification Commands
```bash
# Verify all directories exist
ls -la .opencode/learning/ .opencode/telemetry/ .opencode/recovery/ .opencode/patterns/ .opencode/enhancements/

# Verify all schemas are valid JSON
jq '.' .opencode/learning/schemas/session.json > /dev/null && echo "Session schema OK"
jq '.' .opencode/learning/schemas/recommendation.json > /dev/null && echo "Recommendation schema OK"
jq '.' .opencode/telemetry/schemas/trace.json > /dev/null && echo "Trace schema OK"
jq '.' .opencode/telemetry/schemas/metrics.json > /dev/null && echo "Metrics schema OK"
jq '.' .opencode/recovery/schemas/exception.json > /dev/null && echo "Exception schema OK"
jq '.' .opencode/recovery/schemas/recovery.json > /dev/null && echo "Recovery schema OK"

# Verify exception types count
grep -c "^## " .opencode/recovery/exception-classifier.md  # Expect 10

# Verify pattern count
ls .opencode/patterns/*.md | grep -v selector | wc -l  # Expect 3

# Verify no circular dependencies
grep -r "import.*telemetry\|import.*recovery\|import.*pattern" .opencode/learning/ 2>/dev/null || echo "No circular deps in learning"
grep -r "import.*recovery\|import.*pattern" .opencode/telemetry/ 2>/dev/null || echo "No circular deps in telemetry"
grep -r "import.*pattern" .opencode/recovery/ 2>/dev/null || echo "No circular deps in recovery"

# Verify test files exist
ls tests/enhancements/*.test.md
```

### Final Checklist
- [ ] All 24 enhancement files created (6 + 6 + 7 + 5)
- [ ] All 6 JSON schemas are valid JSON
- [ ] Exactly 10 exception types documented
- [ ] Exactly 3 design patterns documented
- [ ] Each pattern has 3+ real examples
- [ ] Human-in-the-loop has 5 trigger conditions
- [ ] Integration README lists all enhancements
- [ ] Opt-in configuration documented for each enhancement
- [ ] No circular dependencies between enhancements
- [ ] T-800 agent references enhancement hooks
- [ ] Test runner updated to include enhancement tests