# T-800 Pattern Extractor

Extract reusable patterns from execution history for continuous improvement.

## Purpose

Identify, validate, and store patterns from successful and failed executions to improve future performance.

## Pattern Recognition Methodology

### 1. Observation Phase

```yaml
sources:
  - Session execution logs
  - Reflection reports
  - Feedback records
  - Memory entries

extraction_triggers:
  - Frequency threshold exceeded (>3 occurrences)
  - Success correlation identified (>80% success rate)
  - Failure correlation identified (>50% failure rate)
  - User feedback mentions pattern
```

### 2. Identification Phase

```markdown
Pattern Attributes:
- Name: Descriptive identifier
- Trigger: When/where it applies
- Behavior: What the pattern does
- Outcome: Expected result
- Confidence: How often it succeeds
```

### 3. Validation Phase

```yaml
validation_criteria:
  - Occurs in >= 3 different contexts
  - Success rate >= 70% for success patterns
  - Failure rate >= 50% for failure patterns
  - User confirms relevance
  - Not contradicted by other patterns
```

### 4. Storage Phase

```markdown
Storage Targets:
- Semantic Memory: Technical patterns (algorithms, data structures)
- Episodic Memory: Context-specific patterns (project, user)
- Long-Term Memory: Cross-session patterns (preferences, expertise)
```

## Types of Patterns

### Success Patterns

Patterns associated with successful outcomes:

```yaml
implementation_success:
  - Name: "Test-First Development"
    Trigger: "Feature implementation task"
    Behavior: "Write tests before implementation"
    Outcome: "Higher code quality, fewer bugs"
    Confidence: 0.85
    
  - Name: "Incremental Refactoring"
    Trigger: "Large codebase changes"
    Behavior: "Break into small, testable changes"
    Outcome: "Reduced regression risk"
    Confidence: 0.90
    
  - Name: "Error-First Design"
    Trigger: "API or service design"
    Behavior: "Define error cases before happy path"
    Outcome: "Robust error handling"
    Confidence: 0.80
```

### Failure Patterns

Patterns associated with failed outcomes:

```yaml
failure_patterns:
  - Name: "Assumption Without Validation"
    Trigger: "Requirements gathering"
    Behavior: "Assume user requirements without asking"
    Outcome: "Misaligned deliverables"
    Confidence: 0.75
    
  - Name: "Premature Optimization"
    Trigger: "Performance-critical code"
    Behavior: "Optimize before measuring"
    Outcome: "Wasted effort, potential bugs"
    Confidence: 0.70
    
  - Name: "Scope Creep Acceptance"
    Trigger: "Mid-project changes"
    Behavior: "Accept all change requests"
    Outcome: "Timeline/budget overrun"
    Confidence: 0.85
```

### Workflow Patterns

Operational patterns that improve efficiency:

```yaml
workflow_patterns:
  - Name: "THINK-QUESTION-PLAN-EXECUTE"
    Trigger: "New project request"
    Behavior: "Follow 4-phase workflow"
    Outcome: "Comprehensive planning, fewer revisions"
    Confidence: 0.95
    
  - Name: "Checkpoint Verification"
    Trigger: "Complex multi-step task"
    Behavior: "Verify at defined checkpoints"
    Outcome: "Early error detection"
    Confidence: 0.88
    
  - Name: "Parallel Wave Execution"
    Trigger: "Independent tasks available"
    Behavior: "Execute independent tasks in parallel"
    Outcome: "Reduced total time"
    Confidence: 0.82
```

## Extraction Algorithms

### Frequency-Based Extraction

```python
# Pseudocode for frequency-based pattern extraction
def extract_frequent_patterns(execution_log, min_frequency=3):
    pattern_counts = {}
    for execution in execution_log:
        for behavior in execution.behaviors:
            key = (behavior.trigger, behavior.action)
            pattern_counts[key] = pattern_counts.get(key, 0) + 1
    
    return [
        Pattern(trigger=t, action=a, frequency=f)
        for (t, a), f in pattern_counts.items()
        if f >= min_frequency
    ]
```

### Correlation-Based Extraction

```python
# Pseudocode for outcome-correlated pattern extraction
def extract_correlated_patterns(execution_log):
    success_patterns = []
    failure_patterns = []
    
    for behavior in all_behaviors:
        success_rate = calc_success_rate(behavior, execution_log)
        
        if success_rate >= 0.8:
            success_patterns.append(behavior)
        elif success_rate <= 0.5:
            failure_patterns.append(behavior)
    
    return success_patterns, failure_patterns
```

### Context-Based Extraction

```python
# Pseudocode for context-aware pattern extraction
def extract_context_patterns(execution_log, context_threshold=3):
    context_patterns = {}
    
    for execution in execution_log:
        context_key = execution.context_type
        for behavior in execution.behaviors:
            key = (context_key, behavior)
            context_patterns[key] = context_patterns.get(key, 0) + 1
    
    return [
        ContextPattern(context=c, behavior=b, frequency=f)
        for (c, b), f in context_patterns.items()
        if f >= context_threshold
    ]
```

## Pattern Validation Criteria

### Validation Checklist

```markdown
## New Pattern Validation

### Frequency Check
- [ ] Occurred at least 3 times
- [ ] Occurred in at least 2 different contexts
- [ ] Not a one-off occurrence

### Outcome Check
- [ ] Clear correlation with outcome (success/failure)
- [ ] Statistical significance (p < 0.05)
- [ ] Not confounded by other factors

### Actionability Check
- [ ] Pattern can be described clearly
- [ ] Pattern can be applied consciously
- [ ] Pattern has predictable outcome

### Non-Redundancy Check
- [ ] Not covered by existing pattern
- [ ] Adds new information
- [ ] Different from similar patterns
```

### Validation Scoring

```yaml
validation_score:
  frequency_score: count / min_threshold (max 1.0)
  outcome_score: correlation_strength (0-1)
  actionability_score: average of expert_ratings (0-1)
  uniqueness_score: 1 - similarity_to_existing (0-1)
  
  total_score: average of all scores
  
  passing_threshold: 0.7
```

## Storage and Retrieval

### Storage Structure

```
.opencode/memory/
├── semantic/
│   └── patterns/
│       ├── success_patterns.json
│       ├── failure_patterns.json
│       └── workflow_patterns.json
├── episodic/
│   └── sessions/
│       └── {session_id}/
│           └── patterns_discovered.json
└── long_term/
    └── expertise/
        └── pattern_proficiency.json
```

### Retrieval Query Format

```json
{
  "query": {
    "context": "authentication",
    "outcome": "success",
    "min_confidence": 0.7
  },
  "response": [
    {
      "pattern_id": "PAT-001",
      "name": "JWT Statelessness",
      "confidence": 0.85,
      "last_applied": "2024-01-15",
      "success_count": 12
    }
  ]
}
```

## Integration with Memory System

### Memory Type Assignment

| Pattern Type | Memory Target | Retention |
|-------------|---------------|-----------|
| Technical patterns | Semantic | Permanent |
| Project-specific patterns | Episodic | Project duration |
| User preferences | Long-Term | Permanent |
| Session observations | Working | Session only |

### Memory Sync Protocol

```markdown
1. Pattern extracted from execution
2. Validated against criteria
3. Classified by type
4. Assigned to memory target
5. Stored with metadata:
   - Source sessions
   - Confidence score
   - Last validation date
   - Application count
```

## Pattern Application Guidelines

### When to Apply Patterns

```yaml
apply_success_pattern:
  conditions:
    - Context matches pattern trigger
    - Pattern confidence >= 0.7
    - No contradicting patterns
    - User has not overridden
  
  priority_order:
    - Higher confidence first
    - More recent validation first
    - More application count first
```

### When to Avoid Patterns

```yaml
avoid_failure_pattern:
  conditions:
    - Context matches pattern trigger
    - Pattern indicates high failure risk
    - Alternative approach available
    - User has not explicitly accepted risk
```

### Pattern Override Rules

```markdown
User Override Priority:
1. User explicitly requests ignoring pattern
2. User provides different preference
3. User confirms acceptance of failure risk

System Override Conditions:
1. Contradicted by newer, higher-confidence pattern
2. Proven invalid by recent executions
3. Context changed significantly
```

## Examples of Extracted Patterns

### Example 1: JWT Authentication Success Pattern

```json
{
  "pattern_id": "PAT-001",
  "name": "JWT Stateless Auth",
  "type": "success",
  "trigger": {
    "context": "authentication",
    "requirement": "stateless"
  },
  "behavior": "Implement JWT with short expiry and refresh tokens",
  "outcome": {
    "expected": "Scalable, stateless authentication",
    "success_rate": 0.92
  },
  "confidence": 0.85,
  "source_sessions": ["ses_001", "ses_002", "ses_003"],
  "extracted_at": "2024-01-15T10:00:00Z",
  "last_validated": "2024-01-20T15:00:00Z",
  "application_count": 8
}
```

### Example 2: Assumption Without Validation Failure Pattern

```json
{
  "pattern_id": "PAT-F01",
  "name": "Assumption Without Validation",
  "type": "failure",
  "trigger": {
    "context": "requirements_gathering",
    "indicator": "user_did_not_specify"
  },
  "behavior": "Assume default or preference without asking",
  "outcome": {
    "expected": "Misaligned deliverables, rework required",
    "failure_rate": 0.75
  },
  "confidence": 0.70,
  "source_sessions": ["ses_004", "ses_005", "ses_006"],
  "recommendation": "Always ask clarifying questions instead of assuming",
  "extracted_at": "2024-01-16T11:00:00Z"
}
```

### Example 3: Test-First Development Workflow Pattern

```json
{
  "pattern_id": "PAT-W01",
  "name": "Test-First Development",
  "type": "workflow",
  "trigger": {
    "context": "feature_implementation",
    "complexity": "medium_to_high"
  },
  "behavior": "Write tests before implementation code",
  "outcome": {
    "expected": "Higher quality, fewer bugs, faster debugging",
    "success_rate": 0.88
  },
  "confidence": 0.85,
  "source_sessions": ["ses_007", "ses_008", "ses_009"],
  "extracted_at": "2024-01-17T12:00:00Z",
  "related_patterns": ["PAT-002", "PAT-003"]
}
```