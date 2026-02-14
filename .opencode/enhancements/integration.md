# T-800 Enhancements Integration Guide

Detailed configuration and integration instructions for each enhancement module.

## Configuration Methods

### Method 1: Global Configuration

Create or edit `.opencode/config/enhancements.yaml`:

```yaml
enhancements:
  learning:
    enabled: true
  telemetry:
    enabled: true
  recovery:
    enabled: true
  patterns:
    enabled: true
```

### Method 2: Session-Level Configuration

Include in your initial request:

```markdown
User: "Build a REST API for user management

Configuration:
- learning: enabled
- telemetry: enabled (with budget $2.00)
- recovery: enabled
- patterns: plan-and-execute with HITL"
```

### Method 3: Agent Configuration

Add to `.opencode/agents/t800.md` frontmatter:

```yaml
---
enhancements:
  learning: true
  telemetry: true
  recovery: true
  patterns: true
---
```

---

## Self-Improvement Configuration

### Enable/Disable

```yaml
learning:
  enabled: true  # Set to false to disable
```

### Reflection Settings

```yaml
learning:
  reflection:
    # Automatic triggers
    automatic: true
    
    # Depth levels: surface, deep, meta
    default_depth: surface
    failure_depth: deep
    weekly_depth: meta
    
    # Time budgets (milliseconds)
    surface_budget_ms: 30000
    deep_budget_ms: 120000
    meta_budget_ms: 900000
```

### Pattern Extraction Settings

```yaml
learning:
  pattern_extraction:
    # Minimum occurrences to recognize pattern
    min_frequency: 3
    
    # Minimum confidence to store pattern
    min_confidence: 0.7
    
    # Maximum patterns to store
    max_patterns: 100
    
    # Pattern decay (older patterns less relevant)
    decay_days: 90
```

### Memory Integration

```yaml
learning:
  memory:
    # Target memory for different pattern types
    success_patterns: semantic
    failure_patterns: episodic
    workflow_patterns: long_term
    
    # Retention settings
    episodic_retention_days: 30
    semantic_retention: permanent
```

### Example Configuration

```yaml
# Full learning configuration
learning:
  enabled: true
  reflection:
    automatic: true
    default_depth: surface
    failure_depth: deep
  pattern_extraction:
    min_frequency: 3
    min_confidence: 0.7
  memory:
    success_patterns: semantic
    failure_patterns: episodic
```

---

## Telemetry Configuration

### Enable/Disable

```yaml
telemetry:
  enabled: true  # Set to false to disable
```

### Trace Collection

```yaml
telemetry:
  trace:
    # What to trace
    tools: true
    llm_calls: true
    decisions: true
    errors: true
    
    # Buffer settings
    buffer_size: 50
    flush_interval_ms: 5000
```

### Privacy Settings

```yaml
telemetry:
  privacy:
    # Data redaction
    redact_pii: true
    redact_secrets: true
    redact_passwords: true
    redact_api_keys: true
    
    # Path handling
    redact_sensitive_paths: true
    sensitive_dirs:
      - ~/.ssh
      - ~/.config
      - /etc
    
    # Network
    local_only: true
    no_network_transmission: true
```

### Budget Management

```yaml
telemetry:
  budget:
    # Limits
    daily_limit_usd: 5.00
    session_limit_usd: 1.00
    task_limit_usd: 0.50
    
    # Alert thresholds
    warning_threshold_percent: 80
    
    # Actions when exceeded
    on_warning: notify_user
    on_limit: pause_and_notify
```

### Cost Tracking

```yaml
telemetry:
  cost:
    # Model pricing (per 1K tokens)
    models:
      claude-sonnet-4:
        input: 0.003
        output: 0.015
      gpt-4o-mini:
        input: 0.00015
        output: 0.00060
    
    # Reporting
    session_report: true
    daily_report: true
```

### Example Configuration

```yaml
# Full telemetry configuration
telemetry:
  enabled: true
  trace:
    tools: true
    llm_calls: true
  privacy:
    redact_pii: true
    local_only: true
  budget:
    session_limit_usd: 1.00
    warning_threshold_percent: 80
```

---

## Recovery Configuration

### Enable/Disable

```yaml
recovery:
  enabled: true  # Set to false to disable
```

### Retry Settings

```yaml
recovery:
  retry:
    # Global limits
    max_retries: 3
    backoff_strategy: exponential
    
    # Timing
    initial_delay_ms: 1000
    max_delay_ms: 30000
    
    # Per-exception overrides
    per_exception:
      NETWORK_ERROR:
        max_retries: 5
      RATE_LIMITED:
        max_retries: 10
```

### Escalation Thresholds

```yaml
recovery:
  escalation:
    # When to escalate
    consecutive_failures: 3
    total_errors_session: 10
    cost_threshold_usd: 5.00
    
    # Timeout for user response
    response_timeout_ms: 300000
    
    # Default actions on timeout
    timeout_defaults:
      security_impact: abort
      data_loss_risk: wait
      high_cost: reduced_scope
```

### State Recovery

```yaml
recovery:
  state:
    # Checkpoint settings
    checkpoint_enabled: true
    max_checkpoints_per_session: 20
    checkpoint_interval_ms: 300000
    
    # Rollback settings
    rollback_enabled: true
    validate_before_restore: true
```

### Exception Handling

```yaml
recovery:
  exceptions:
    # Classification confidence threshold
    classification_threshold: 0.5
    
    # Unknown error handling
    unknown_error_strategy: escalate
    
    # Severity mapping
    severity_overrides:
      CONTEXT_OVERFLOW: critical
```

### Example Configuration

```yaml
# Full recovery configuration
recovery:
  enabled: true
  retry:
    max_retries: 3
    backoff_strategy: exponential
  escalation:
    consecutive_failures: 3
    response_timeout_ms: 300000
  state:
    checkpoint_enabled: true
```

---

## Patterns Configuration

### Enable/Disable

```yaml
patterns:
  enabled: true  # Set to false to disable
```

### Pattern Selection

```yaml
patterns:
  selection:
    # Auto-select based on task characteristics
    auto_selection: true
    
    # Override for specific task types
    task_overrides:
      debugging: react
      migration: plan_execute
      new_feature: plan_execute
      investigation: react
    
    # Allow user override
    allow_user_override: true
```

### ReAct Pattern Settings

```yaml
patterns:
  react:
    # Maximum loops
    max_iterations: 20
    
    # Observation timeout
    observation_timeout_ms: 30000
    
    # Reasoning depth
    reasoning_depth: 2
```

### Plan-and-Execute Settings

```yaml
patterns:
  plan_execute:
    # Require user approval
    require_approval: true
    
    # Maximum plan steps
    max_plan_steps: 50
    
    # Show estimated time
    show_estimates: true
    
    # Stop on error during execution
    stop_on_error: true
```

### Human-in-the-Loop Settings

```yaml
patterns:
  human_in_loop:
    # Trigger thresholds
    confidence_threshold: 0.70
    cost_threshold_usd: 1.00
    duration_threshold_ms: 1800000
    
    # Risk triggers (always on)
    data_loss_risk: true
    security_impact: true
    
    # Timeout response
    timeout_ms: 300000
    default_on_timeout:
      security_impact: abort
      data_loss_risk: wait
      high_cost: reduced_scope
```

### Example Configuration

```yaml
# Full patterns configuration
patterns:
  enabled: true
  selection:
    auto_selection: true
  human_in_loop:
    confidence_threshold: 0.70
    cost_threshold_usd: 1.00
    data_loss_risk: true
```

---

## Hook Points in T-800 Workflow

### THINK Phase Hooks

```yaml
hooks:
  THINK:
    pre:
      - learning: query_semantic_memory
      - recovery: check_previous_failures
    post:
      - telemetry: record_decision
```

### QUESTION Phase Hooks

```yaml
hooks:
  QUESTION:
    pre:
      - learning: check_already_known
    during:
      - telemetry: track_question_metrics
    post:
      - learning: store_episodic_memory
```

### PLAN Phase Hooks

```yaml
hooks:
  PLAN:
    pre:
      - learning: retrieve_similar_plans
      - patterns: select_pattern
    during:
      - telemetry: track_planning_tokens
    post:
      - recovery: create_checkpoint
      - human_in_loop: request_approval_if_needed
```

### EXECUTE Phase Hooks

```yaml
hooks:
  EXECUTE:
    pre_tool:
      - telemetry: start_trace_event
      - recovery: prepare_rollback_point
    post_tool:
      - telemetry: end_trace_event
      - learning: record_outcome
    on_error:
      - recovery: classify_and_recover
      - human_in_loop: escalate_if_critical
    post:
      - learning: reflect_on_session
      - telemetry: generate_summary
```

---

## Troubleshooting

### Learning Not Improving

**Symptom**: Patterns not being extracted, recommendations not helpful

**Check**:
```yaml
# Ensure these are set correctly
learning:
  pattern_extraction:
    min_frequency: 3  # Lower if not enough data
    min_confidence: 0.7  # Lower for more patterns
```

### Telemetry Causing Slowdown

**Symptom**: Operations taking >100ms longer

**Check**:
```yaml
# Reduce tracing
telemetry:
  trace:
    tools: true  # Keep
    llm_calls: false  # Disable if not needed
  buffer_size: 100  # Increase to reduce writes
```

### Recovery Retrying Infinitely

**Symptom**: Same error loop >5 times

**Check**:
```yaml
# Ensure max is set
recovery:
  retry:
    max_retries: 3  # Hard limit
  escalation:
    consecutive_failures: 3  # Escalate after 3
```

### HITL Not Triggering

**Symptom**: No escalation messages

**Check**:
```yaml
# Lower thresholds
patterns:
  human_in_loop:
    confidence_threshold: 0.70  # Try 0.80
    cost_threshold_usd: 1.00  # Lower to trigger earlier
```

---

## Verification Commands

```bash
# Check all enhancements are configured
ls -la .opencode/learning/
ls -la .opencode/telemetry/
ls -la .opencode/recovery/
ls -la .opencode/patterns/

# Validate schema files
jq '.' .opencode/learning/schemas/*.json
jq '.' .opencode/telemetry/schemas/*.json
jq '.' .opencode/recovery/schemas/*.json

# Run enhancement tests
./scripts/test-agents.sh enhancements
```