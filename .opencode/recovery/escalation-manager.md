# T-800 Escalation Manager

Human escalation logic for critical decisions and unresolved failures.

## Purpose

Determine when and how to escalate to human users for intervention when automatic recovery is not possible or appropriate.

## Escalation Triggers

### Automatic Escalation Conditions

```yaml
automatic_escalation:
  critical_severity:
    condition: exception.severity == "critical"
    action: escalate_immediately
    pause_execution: true
    
  retry_exhausted:
    condition: retry_count >= max_retries
    action: escalate_with_context
    pause_execution: true
    
  requires_user_action:
    condition: recovery.requires_user_action == true
    action: escalate_with_options
    pause_execution: true
    
  permission_issues:
    condition: exception.type in [PERMISSION_DENIED, RATE_LIMITED]
    action: escalate_for_authorization
    pause_execution: true
    
  data_safety:
    condition: operation.type in [DELETE, OVERWRITE, MIGRATE]
    action: escalate_for_confirmation
    pause_execution: true
```

### Configurable Escalation Thresholds

```yaml
thresholds:
  consecutive_failures: 3
  total_errors_session: 10
  cost_threshold_usd: 5.00
  duration_threshold_ms: 300000
  uncertainty_score: 0.5
```

## Escalation Levels

### Level 1: Informational

```yaml
level: informational
description: Notify but continue
action:
  - Log event
  - Show notification
  - Continue execution
pause: false
examples:
  - "Rate limit approaching (80%)"
  - "Unusual pattern detected"
```

### Level 2: Warning

```yaml
level: warning
description: Alert and suggest action
action:
  - Highlight issue
  - Suggest solutions
  - Request optional input
pause: false
examples:
  - "Operation taking longer than expected"
  - "Quality score below threshold"
```

### Level 3: Decision Required

```yaml
level: decision_required
description: User decision needed to proceed
action:
  - Pause execution
  - Present options
  - Wait for user choice
pause: true
examples:
  - "Multiple valid approaches available"
  - "Security-sensitive operation"
```

### Level 4: Intervention Required

```yaml
level: intervention_required
description: User must perform action
action:
  - Pause execution
  - Describe problem
  - Instruct user action
  - Wait for confirmation
pause: true
examples:
  - "Permission elevation needed"
  - "External service unreachable"
```

### Level 5: Critical Failure

```yaml
level: critical_failure
description: Unrecoverable without major intervention
action:
  - Stop execution
  - Generate incident report
  - Provide recovery steps
pause: true
requires_restart: true
examples:
  - "State corruption detected"
  - "Data integrity at risk"
```

## Escalation Response Format

### Standard Format

```markdown
## ⚠️ Escalation Required

**Level**: {level}
**Type**: {exception_type}
**Session**: {session_id}

### What Happened
{description_of_problem}

### Why It Matters
{impact_explanation}

### Your Options
1. **{Option 1}**: {description} [Recommended]
2. **{Option 2}**: {description}
3. **{Option 3}**: {description}

### Recommended Action
{recommended_action_with_rationale}

### Context
- Failed attempts: {count}
- Error: {error_message}
- Timestamp: {timestamp}

### How to Respond
Reply with your choice (1, 2, or 3) or describe your preferred action.
```

### Example Escalation

```markdown
## ⚠️ Escalation Required

**Level**: Decision Required
**Type**: PERMISSION_DENIED
**Session**: ses_abc123

### What Happened
Attempted to write configuration file to `/etc/app/config.yaml` but insufficient permissions.

### Why It Matters
Without proper configuration, the deployment will use default settings which may not match your environment.

### Your Options
1. **Write to user directory instead**: Use `~/.config/app/config.yaml` [Recommended]
2. **Request permission elevation**: Run with sudo (requires manual action)
3. **Skip configuration**: Proceed with defaults

### Recommended Action
Option 1 (write to user directory) is recommended as it doesn't require permission changes and the application will automatically find the config.

### Context
- Failed attempts: 1
- Error: Permission denied: /etc/app/config.yaml
- Timestamp: 2024-01-15T10:30:00Z

### How to Respond
Reply with your choice (1, 2, or 3) or describe your preferred action.
```

## Escalation Flow

```
Exception Occurs
       ↓
[Classify Exception]
       ↓
[Attempt Recovery]
       ↓
┌─────────────────┐
│ Recovery Success│──→ Continue Execution
└─────────────────┘
         ↓ No
[Check Escalation Conditions]
       ↓
[Determine Escalation Level]
       ↓
[Generate Escalation Message]
       ↓
[Pause and Wait for Response]
       ↓
┌─────────────────┐
│ User Responds   │──→ Apply User Decision
└─────────────────┘
         ↓ Timeout
[Apply Default Action]
```

## Timeout Handling

### Response Timeout

```yaml
timeout:
  wait_for_user_ms: 300000  # 5 minutes
  reminder_interval_ms: 60000  # 1 minute
  
on_timeout:
  level_1_2: continue_with_default
  level_3: apply_recommended_option
  level_4: skip_operation
  level_5: abort_session
```

### Timeout Reminders

```markdown
⏰ Reminder: Awaiting your response

You have {remaining_time} remaining to respond to the escalation below.

If no response is received, the default action will be applied:
**Default**: {default_action}
```

## De-escalation

### Conditions for De-escalation

```yaml
de_escalation:
  conditions:
    - User provides solution
    - Alternative path succeeds
    - Issue resolved by retry
    - User requests continuation
    
  actions:
    - Resume execution
    - Log resolution path
    - Update memory with successful recovery
```

### De-escalation Message

```markdown
✅ Issue Resolved

**Resolution**: {how_it_was_resolved}
**Action Taken**: {what_happened}

Resuming execution from: {checkpoint}
```

## Human-in-the-Loop Integration

### User Preferences

```yaml
user_preferences:
  escalation_level_default: decision_required
  
  notification_preferences:
    informational: silent_log
    warning: show_summary
    decision_required: highlight
    intervention_required: pause_and_highlight
    critical_failure: stop_and_alert
    
  auto_proceed:
    safe_operations: true
    risky_operations: false
    
  timeout_default_actions:
    PERMISSION_DENIED: skip_operation
    NETWORK_ERROR: retry_with_backoff
    RATE_LIMITED: wait_and_retry
```

## Incident Reporting

### Critical Failures

```yaml
incident_report:
  triggered_on: critical_failure
  
  contents:
    - Session ID and timestamp
    - Full error stack trace
    - Operation context
    - Recovery attempts made
    - Recommended remediation
    
  storage:
    path: .opencode/recovery/incidents/
    format: markdown
    retention_days: 30
```

### Incident Report Template

```markdown
# Incident Report: {incident_id}

## Summary
{brief_description}

## Timeline
- {timestamp_1}: {event_1}
- {timestamp_2}: {event_2}
- {timestamp_3}: {event_3}

## Error Details
```
{full_error_stack_trace}
```

## Context
- Session: {session_id}
- Agent: {agent_name}
- Operation: {operation}
- Files involved: {files}

## Recovery Attempts
1. {attempt_1}: {result}
2. {attempt_2}: {result}

## Impact Assessment
- Data affected: {data}
- User impact: {impact}
- System impact: {system_impact}

## Remediation Steps
1. {step_1}
2. {step_2}
3. {step_3}

## Prevention Recommendations
- {recommendation_1}
- {recommendation_2}

## Metadata
- Incident ID: {incident_id}
- Created: {timestamp}
- Status: {status}
```