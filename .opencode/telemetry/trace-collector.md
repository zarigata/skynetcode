# T-800 Trace Collector

Collect step-by-step execution traces for observability and debugging.

## Purpose

Record detailed execution traces of every tool call and operation for analysis, debugging, and performance optimization.

## Core Principles

1. **Minimal Overhead**: Add <100ms per operation
2. **No PII**: Never collect passwords, API keys, or personal data
3. **Local Only**: No network transmission of telemetry data
4. **Opt-In**: User must explicitly enable telemetry

## Trace Structure

### Trace File Format

```json
{
  "session_id": "ses_abc123",
  "timestamp": "2024-01-15T10:30:00Z",
  "metadata": {
    "agent": "t800",
    "user_id_hash": "sha256_hash",
    "project_hash": "sha256_hash"
  },
  "events": [
    {
      "event_id": "evt_001",
      "timestamp": "2024-01-15T10:30:01Z",
      "type": "tool_call",
      "tool": "read",
      "parameters_redacted": {
        "file_path": "/project/src/auth.ts"
      },
      "duration_ms": 45,
      "success": true,
      "tokens_in": 0,
      "tokens_out": 0
    }
  ],
  "summary": {
    "total_events": 15,
    "total_duration_ms": 45000,
    "success_rate": 0.93,
    "total_cost_estimate": 0.0025
  }
}
```

### Event Types

| Type | Description | Fields |
|------|-------------|--------|
| `tool_call` | Tool invocation | tool, parameters, duration, success |
| `llm_call` | LLM API call | model, tokens_in, tokens_out, cost |
| `decision` | Agent decision point | decision_type, outcome |
| `error` | Error occurred | error_type, message, recovery |
| `checkpoint` | Phase checkpoint | phase_name, status |

## Collection Mechanism

### Hook Points

```yaml
execution_flow:
  pre_tool:
    - Record timestamp
    - Record tool name
    - Redact sensitive parameters
    
  post_tool:
    - Calculate duration
    - Record success/failure
    - Capture token usage
    
  pre_llm:
    - Record prompt token count
    - Record model selection
    
  post_llm:
    - Record completion tokens
    - Calculate cost
```

### Data Flow

```
Tool/LLM Call
     ↓
[Parameter Redaction]
     ↓
[Timestamp Capture]
     ↓
[Execution]
     ↓
[Duration Calculation]
     ↓
[Token/Cost Recording]
     ↓
[Event Assembly]
     ↓
[Write to Trace File]
```

## Parameter Redaction

### Sensitive Fields (Always Redacted)

```yaml
always_redact:
  - password
  - api_key
  - apikey
  - token
  - secret
  - credential
  - auth
  - private_key
  - access_token
  - refresh_token
  
redaction_value: "[REDACTED]"
```

### File Path Handling

```yaml
file_paths:
  mode: relative
  base: project_root
  sensitive_dirs:
    - ~/.ssh
    - ~/.config
    - /etc
  redact_content: true
```

### Example Redaction

```json
// Original parameters
{
  "file_path": "/home/user/.config/opencode/config.json",
  "api_key": "sk-1234567890abcdef"
}

// Redacted for trace
{
  "file_path": "[REDACTED_PATH]",
  "api_key": "[REDACTED]"
}
```

## Performance Considerations

### Overhead Budget

| Operation | Target Overhead | Actual |
|-----------|-----------------|--------|
| Tool call recording | <10ms | ~5ms |
| LLM call recording | <20ms | ~12ms |
| File write | <50ms | ~30ms |
| Total per event | <100ms | ~47ms |

### Optimization Strategies

1. **Buffered Writes**: Batch events before writing to disk
2. **Async Logging**: Don't block execution for trace writes
3. **Selective Tracing**: Only trace enabled event types
4. **Compression**: Use gzip for long traces

### Buffering Configuration

```yaml
trace_buffer:
  max_events: 50
  max_size_kb: 100
  flush_interval_ms: 5000
  flush_on_error: true
  flush_on_checkpoint: true
```

## Integration Points

### T-800 Workflow Hooks

```yaml
workflow_hooks:
  THINK_phase:
    - Record decision_start event
    - Capture reasoning tokens
    
  QUESTION_phase:
    - Record question_count
    - Track clarification_loops
    
  PLAN_phase:
    - Record plan_complexity
    - Track revision_count
    
  EXECUTE_phase:
    - Full trace recording
    - Tool call tracking
    - Error capture
```

### Memory System Integration

```yaml
memory_hooks:
  episodic:
    - Link trace events to session
    - Store trace summaries
    
  working:
    - Current trace context
    - Active event tracking
```

## Output Files

### File Structure

```
.opencode/telemetry/
├── traces/
│   ├── 2024-01-15_10-30-00_ses_abc123.json
│   └── 2024-01-15_11-00-00_ses_def456.json
├── aggregated/
│   └── 2024-01-15_summary.json
└── config/
    └── telemetry_config.yaml
```

### File Naming Convention

```
{date}_{time}_{session_id}.json

Examples:
2024-01-15_10-30-00_ses_abc123.json
2024-01-15_14-22-15_ses_xyz789.json
```

## Usage Examples

### Example 1: Basic Tool Trace

```json
{
  "session_id": "ses_001",
  "timestamp": "2024-01-15T10:00:00Z",
  "events": [
    {
      "event_id": "evt_001",
      "timestamp": "2024-01-15T10:00:01Z",
      "type": "tool_call",
      "tool": "read",
      "parameters_redacted": {
        "file_path": "src/auth.ts"
      },
      "duration_ms": 12,
      "success": true
    },
    {
      "event_id": "evt_002",
      "timestamp": "2024-01-15T10:00:02Z",
      "type": "tool_call",
      "tool": "edit",
      "parameters_redacted": {
        "file_path": "src/auth.ts",
        "old_string": "[content hash: a1b2c3]",
        "new_string": "[content hash: d4e5f6]"
      },
      "duration_ms": 35,
      "success": true
    }
  ],
  "summary": {
    "total_events": 2,
    "total_duration_ms": 47,
    "success_rate": 1.0
  }
}
```

### Example 2: LLM Call Trace

```json
{
  "event_id": "evt_010",
  "timestamp": "2024-01-15T10:05:00Z",
  "type": "llm_call",
  "model": "claude-sonnet-4",
  "prompt_tokens": 1500,
  "completion_tokens": 800,
  "total_tokens": 2300,
  "duration_ms": 3500,
  "cost_usd": 0.023,
  "success": true
}
```

### Example 3: Error Trace

```json
{
  "event_id": "evt_015",
  "timestamp": "2024-01-15T10:10:00Z",
  "type": "error",
  "error_type": "TOOL_TIMEOUT",
  "tool": "bash",
  "message": "Command exceeded 30000ms timeout",
  "duration_ms": 30000,
  "recovery": {
    "attempted": true,
    "strategy": "retry_with_shorter_command",
    "success": true
  }
}
```

## Configuration

```yaml
# .opencode/telemetry/config/telemetry_config.yaml
telemetry:
  enabled: false  # Opt-in only
  trace_tools: true
  trace_llm: true
  trace_decisions: true
  trace_errors: true
  
  performance:
    max_overhead_ms: 100
    buffer_size: 50
    flush_interval_ms: 5000
    
  privacy:
    redact_pii: true
    redact_secrets: true
    redact_sensitive_paths: true
    local_only: true
    no_network_transmission: true
    
  retention:
    max_trace_files: 100
    max_trace_age_days: 30
    auto_cleanup: true
```