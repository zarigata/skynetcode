# T-800 Feedback Processor

Process success and failure outcomes to drive continuous improvement.

## Purpose

Transform raw execution outcomes into structured feedback that feeds the reflection engine and pattern extractor.

## Success Criteria Definition

### What Constitutes Success

```yaml
success_criteria:
  functional:
    - All acceptance criteria met
    - No regressions introduced
    - Tests pass
    
  quality:
    - Code follows standards
    - No lint errors
    - Proper error handling
    
  efficiency:
    - Completed within time budget
    - No unnecessary rework
    - Clean execution path
```

### Success Metrics

| Metric | Threshold | Ideal |
|--------|-----------|-------|
| Task completion rate | ≥ 90% | 100% |
| First-attempt success | ≥ 70% | 85% |
| Rework required | ≤ 20% | < 10% |
| User satisfaction | ≥ 4/5 | 5/5 |

## Failure Analysis Framework

### Failure Types

#### Type 1: Planning Failures
```markdown
Causes:
- Incomplete requirements gathering
- Missing edge case consideration
- Wrong assumptions
- Scope creep

Patterns:
- Multiple plan revisions
- Late requirement discovery
- Stakeholder disagreement
```

#### Type 2: Execution Failures
```markdown
Causes:
- Tool misuse
- Logic errors
- Missing error handling
- Performance issues

Patterns:
- Test failures
- Runtime errors
- Timeout exceeded
```

#### Type 3: Integration Failures
```markdown
Causes:
- API contract violations
- Data format mismatches
- Dependency conflicts
- Environment differences

Patterns:
- Integration test failures
- End-to-end failures
- Cross-component issues
```

#### Type 4: Resource Failures
```markdown
Causes:
- Insufficient time
- Missing knowledge
- Tool limitations
- Infrastructure issues

Patterns:
- Timeout errors
- Tool not available
- Permission denied
```

### Failure Classification Tree

```
Failure
├── Recoverable
│   ├── Retry-able (network timeout, rate limit)
│   ├── Fixable (logic error, missing validation)
│   └── Workaround-able (missing tool, limited resource)
└── Non-Recoverable
    ├── Critical (security violation, data corruption)
    ├── External (service down, dependency removed)
    └── Architectural (wrong design, incompatible approach)
```

## Feedback Loop Mechanism

### Immediate Feedback (Real-time)

```yaml
trigger: On task completion/failure
processing:
  1. Capture outcome status
  2. Extract key metrics
  3. Identify immediate issues
  4. Store in working memory
output: Outcome record
```

### Short-term Feedback (Session-level)

```yaml
trigger: On session end
processing:
  1. Aggregate session outcomes
  2. Calculate success rates
  3. Identify patterns
  4. Store in episodic memory
output: Session summary
```

### Long-term Feedback (Cross-session)

```yaml
trigger: On pattern threshold reached
processing:
  1. Analyze cross-session trends
  2. Identify recurring issues
  3. Extract learned lessons
  4. Store in long-term memory
output: Learning record
```

## Integration with Reflection Engine

### Data Flow

```
Execution Outcome
       ↓
[Feedback Processor]
       ↓
┌──────────────────┐
│ Structured Data  │
│ - Status         │
│ - Metrics        │
│ - Classification │
│ - Context        │
└──────────────────┘
       ↓
[Reflection Engine]
       ↓
┌──────────────────┐
│ Analysis Output  │
│ - Root causes    │
│ - Patterns       │
│ - Recommendations│
└──────────────────┘
       ↓
[Memory System]
```

### Protocol

```markdown
1. Feedback Processor captures raw outcome
2. Adds classification and metrics
3. Passes to Reflection Engine
4. Receives analysis back
5. Stores combined record in appropriate memory
```

## Output Formats

### Success Record

```json
{
  "type": "success",
  "timestamp": "2024-01-15T10:30:00Z",
  "task_id": "TASK-001",
  "duration_ms": 45000,
  "metrics": {
    "tests_passed": 12,
    "coverage_percent": 85,
    "files_modified": 3
  },
  "patterns_used": ["jwt-auth", "error-handling"],
  "efficiency_score": 0.92
}
```

### Failure Record

```json
{
  "type": "failure",
  "timestamp": "2024-01-15T11:00:00Z",
  "task_id": "TASK-002",
  "failure_type": "execution",
  "failure_category": "recoverable",
  "error": {
    "message": "Network timeout",
    "code": "ETIMEDOUT",
    "stack_trace": "..."
  },
  "context": {
    "tool": "fetch",
    "attempt": 2,
    "max_retries": 3
  },
  "recovery_attempted": true,
  "recovery_success": false
}
```

### Partial Success Record

```json
{
  "type": "partial",
  "timestamp": "2024-01-15T12:00:00Z",
  "task_id": "TASK-003",
  "completion_percent": 75,
  "completed_criteria": [
    "Core functionality",
    "Unit tests"
  ],
  "incomplete_criteria": [
    "Integration tests",
    "Documentation"
  ],
  "blockers": [
    {
      "reason": "Missing API key",
      "impact": "Cannot test external integration"
    }
  ]
}
```

## Examples

### Example 1: Processing Successful Execution

```markdown
Input: Task completed successfully
- All tests passed
- 3 files modified
- Duration: 45 seconds

Processing:
1. Classify as SUCCESS
2. Calculate metrics:
   - Efficiency: 0.92 (target was 50s)
   - Quality: 1.0 (all tests passed)
3. Extract patterns:
   - Used JWT auth pattern
   - Applied error handling standard
4. Link to memory:
   - Store in episodic memory
   - Update semantic memory (JWT pattern reinforced)

Output:
{
  "type": "success",
  "metrics": {...},
  "patterns_used": [...],
  "efficiency_score": 0.92
}
```

### Example 2: Processing Recoverable Failure

```markdown
Input: Task failed, retry succeeded
- First attempt: timeout
- Second attempt: success
- Total duration: 90 seconds

Processing:
1. Classify as PARTIAL (recovered)
2. Analyze failure:
   - Type: EXECUTION
   - Category: RECOVERABLE
   - Cause: Network timeout
3. Calculate metrics:
   - Efficiency: 0.65 (target was 50s, took 90s)
   - Recovery rate: 1/1
4. Extract learnings:
   - Add retry strategy for network calls
   - Consider timeout increase

Output:
{
  "type": "partial",
  "failure_type": "execution",
  "recovery_success": true,
  "learnings": [...]
}
```

### Example 3: Processing Critical Failure

```markdown
Input: Task failed critically
- Security vulnerability detected
- Code rejected
- Requires redesign

Processing:
1. Classify as FAILURE (non-recoverable)
2. Analyze failure:
   - Type: PLANNING
   - Category: NON-RECOVERABLE
   - Cause: Authentication bypass flaw
3. Escalate immediately:
   - Log to issues.md
   - Flag for human review
   - Block related tasks
4. Generate recommendations:
   - Security audit required
   - Redesign auth flow

Output:
{
  "type": "failure",
  "failure_category": "non-recoverable",
  "escalation": {
    "level": "critical",
    "requires_human": true,
    "blocked_tasks": ["TASK-004", "TASK-005"]
  }
}
```

## Configuration

```yaml
feedback_processor:
  success_threshold: 0.9
  failure_escalation_threshold: 3
  retry_limit: 3
  timeout_default_ms: 30000
  
  memory_targets:
    immediate: working
    session: episodic
    pattern: long_term
```