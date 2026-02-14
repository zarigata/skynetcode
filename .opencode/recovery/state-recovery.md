# T-800 State Recovery

Rollback and retry mechanisms for recovery from error states.

## Purpose

Enable restoration of system state after failures to allow safe retry or continuation.

## Core Concepts

### State Checkpoint

A snapshot of system state that can be restored:

```yaml
checkpoint:
  id: "ckpt_{timestamp}_{sequence}"
  type: [phase, task, operation]
  
  contents:
    working_memory: Current session state
    file_states: Map of files and their checksums
    operation_context: What was being done
    progress_markers: How far along
    
  size_limit_kb: 100
  retention_count: 10
```

### State Delta

The difference between states:

```yaml
delta:
  from_checkpoint: "ckpt_001"
  to_checkpoint: "ckpt_002"
  
  changes:
    files_modified: ["file1.ts", "file2.ts"]
    files_created: ["file3.ts"]
    files_deleted: []
    memory_updates: {}
```

## Rollback Mechanisms

### File Rollback

```yaml
file_rollback:
  strategy: git_revert
  
  options:
    - Use git stash if uncommitted
    - Use git checkout if committed
    - Use backup files if no git
    
  implementation:
    step_1: Identify affected files
    step_2: Determine last good state
    step_3: Restore files from checkpoint
    step_4: Verify restoration
```

### Memory Rollback

```yaml
memory_rollback:
  strategy: checkpoint_restore
  
  types:
    working_memory:
      action: Replace with checkpoint
      preservation: None
      
    episodic_memory:
      action: Append rollback event
      preservation: Keep history
      
    long_term_memory:
      action: Never rollback
      preservation: Permanent
```

### Transaction Rollback

```yaml
transaction_rollback:
  multi_file_operations:
    - Record intent before execution
    - Execute changes atomically
    - Rollback all on any failure
    
  example:
    intent: "Rename User → Account across codebase"
    affected: ["types.ts", "api.ts", "models.ts", "tests.ts"]
    execution: Sequential with checkpoint
    rollback: Revert all if any fails
```

## Retry Mechanisms

### Retry Strategy

```yaml
retry_strategy:
  types:
    immediate:
      description: Retry right away
      use_for: [INVALID_INPUT, RESOURCE_NOT_FOUND]
      
    delayed:
      description: Wait before retry
      use_for: [RATE_LIMITED, NETWORK_ERROR]
      initial_delay_ms: 1000
      
    exponential_backoff:
      description: Increasing delays
      use_for: [TOOL_TIMEOUT, NETWORK_ERROR]
      formula: delay = base * (2 ^ attempt)
      max_delay_ms: 30000
      
    conditional:
      description: Retry only if condition met
      use_for: [PERMISSION_DENIED]
      condition: "permissions_changed"
```

### Retry Limits

```yaml
retry_limits:
  global_max_retries: 3
  per_exception_max:
    NETWORK_ERROR: 5
    RATE_LIMITED: 10
    TOOL_TIMEOUT: 3
    INVALID_INPUT: 2
    PERMISSION_DENIED: 1
    
  session_max_total_retries: 20
  task_max_total_retries: 5
```

### Retry Logic Flow

```
Operation Fails
       ↓
[Record State]
       ↓
[Classify Exception]
       ↓
[Check Retry Allowed]
       ↓ Yes        ↓ No
[Check Retry Count < Max]   [Attempt Fallback]
       ↓ Yes        ↓ No
[Wait (if delayed)]
       ↓
[Restore State from Checkpoint]
       ↓
[Retry Operation]
       ↓
┌─────────────────┐
│ Success?        │──→ Continue
└─────────────────┘
         ↓ No
[Increment Retry Count]
       ↓
[Loop or Exhaust]
```

## State Preservation

### Checkpoint Creation

```yaml
checkpoint_triggers:
  automatic:
    - Before file modifications
    - Before external calls
    - Before risky operations
    - On phase transitions
    
  manual:
    - User request
    - Session save
    
  interval:
    - Every 5 minutes during execution
    - Every 10 operations minimum
```

### Checkpoint Storage

```
.opencode/recovery/checkpoints/
├── session_{session_id}/
│   ├── ckpt_2024-01-15_10-30-00.json
│   ├── ckpt_2024-01-15_10-35-00.json
│   └── ckpt_2024-01-15_10-40-00.json
└── active_checkpoint.json
```

### Checkpoint Format

```json
{
  "checkpoint_id": "ckpt_20240115_103000",
  "session_id": "ses_abc123",
  "timestamp": "2024-01-15T10:30:00Z",
  "phase": "EXECUTE",
  "task_id": "task_005",
  "state": {
    "working_memory": {
      "current_task": "Implementing authentication",
      "files_modified": ["src/auth.ts", "src/middleware.ts"],
      "decisions_made": ["Using JWT", "24h expiry"]
    },
    "file_states": {
      "src/auth.ts": {
        "checksum": "abc123",
        "last_modified": "2024-01-15T10:29:00Z",
        "size_bytes": 4500
      }
    }
  },
  "previous_checkpoint": "ckpt_20240115_102500"
}
```

## Recovery Patterns

### Pattern 1: Full Rollback + Retry

```yaml
pattern: full_rollback_retry
trigger: Critical error mid-operation
steps:
  1. Identify last good checkpoint
  2. Restore all file states
  3. Clear working memory
  4. Retry from checkpoint
```

### Pattern 2: Partial Rollback + Continue

```yaml
pattern: partial_rollback_continue
trigger: Non-critical error in subset
steps:
  1. Identify affected subset
  2. Restore only those files
  3. Adjust operation plan
  4. Continue from adjusted point
```

### Pattern 3: Skip and Continue

```yaml
pattern: skip_continue
trigger: Non-essential operation failed
steps:
  1. Log failure
  2. Mark operation as skipped
  3. Continue with remaining tasks
  4. Report at end
```

### Pattern 4: Checkpoint + Alternative

```yaml
pattern: checkpoint_alternative
trigger: Primary approach blocked
steps:
  1. Save current state
  2. Switch to alternative approach
  3. Execute alternative
  4. Restore if alternative fails
```

## Cleanup and Maintenance

### Checkpoint Cleanup

```yaml
cleanup:
  on_success:
    - Keep last 3 checkpoints
    - Archive important milestones
    - Delete intermediate
    
  on_failure:
    - Keep all checkpoints for debugging
    - Create incident report
    
  scheduled:
    - Delete checkpoints older than 30 days
    - Compress old checkpoints
```

### State Validation

```yaml
validation:
  on_restore:
    - Verify file checksums match
    - Verify working memory structure
    - Test state consistency
    
  on_resume:
    - Check all dependencies available
    - Verify environment unchanged
    - Validate assumptions still hold
```

## Error Prevention

```yaml
prevention:
  pre_operation_checks:
    - Verify file writable before edit
    - Check network before external call
    - Validate permissions before privileged operation
    
  safe_modes:
    read_only: Never modify files
    dry_run: Report changes without making them
    conservative: Require confirmation for risky operations
```

## Configuration

```yaml
state_recovery:
  checkpoints:
    enabled: true
    max_per_session: 20
    max_age_hours: 48
    
  rollback:
    enabled: true
    default_strategy: checkpoint_restore
    
  retry:
    enabled: true
    default_strategy: exponential_backoff
    max_attempts: 3
    initial_delay_ms: 1000
    max_delay_ms: 30000
    
  cleanup:
    on_success: keep_last_3
    on_failure: keep_all
    scheduled_cleanup: true
    max_age_days: 30
```