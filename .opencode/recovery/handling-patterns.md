# T-800 Handling Patterns

Registry of recovery patterns for each exception type.

## Recovery Pattern Structure

Each exception type has 3 recovery options:

```yaml
recovery_options:
  retry:
    description: Attempt the same operation again
    conditions: When failure might be transient
    
  fallback:
    description: Use alternative approach
    conditions: When original approach blocked
    
  escalate:
    description: Hand off to human
    conditions: When recovery not possible automatically
```

---

## Exception Handling Patterns

### 1. TOOL_NOT_FOUND

```yaml
type: TOOL_NOT_FOUND
recovery_options:
  retry:
    action: "Re-check tool name and availability"
    parameters:
      - Verify tool spelling
      - Check tool registration
    timeout_ms: 5000
    max_attempts: 1
    
  fallback:
    action: "Use equivalent available tool"
    parameters:
      - Search for similar tools
      - Use native alternative
    examples:
      - "deploy not found → use bash with deployment script"
      - "migrate not found → use edit tool to create migration"
      
  escalate:
    action: "Notify user of missing tool requirement"
    message: "Tool '{tool}' is not available. Please install or configure it."
    requires_user_action: true
```

### 2. TOOL_TIMEOUT

```yaml
type: TOOL_TIMEOUT
recovery_options:
  retry:
    action: "Retry with increased timeout"
    parameters:
      - Double timeout limit
      - Add progress indicators
    timeout_ms: 60000
    max_attempts: 3
    backoff: exponential
    
  fallback:
    action: "Break into smaller operations"
    parameters:
      - Split operation into chunks
      - Use streaming if available
    examples:
      - "Large npm install → install in batches"
      - "Long test run → run tests individually"
      
  escalate:
    action: "Report persistent timeout"
    message: "Operation consistently timing out. May need optimization."
    requires_user_action: true
```

### 3. INVALID_INPUT

```yaml
type: INVALID_INPUT
recovery_options:
  retry:
    action: "Correct input and retry"
    parameters:
      - Fix validation errors
      - Add missing required fields
    timeout_ms: 5000
    max_attempts: 2
    
  fallback:
    action: "Use default values"
    parameters:
      - Apply sensible defaults
      - Prompt for clarification
    examples:
      - "Missing file_path → use current directory"
      - "Invalid size → use default size"
      
  escalate:
    action: "Ask user for clarification"
    message: "Input validation failed: {errors}. Please provide valid input."
    requires_user_action: true
```

### 4. PERMISSION_DENIED

```yaml
type: PERMISSION_DENIED
recovery_options:
  retry:
    action: "Retry with elevated context"
    parameters: null
    timeout_ms: 5000
    max_attempts: 1
    
  fallback:
    action: "Use alternative path or method"
    parameters:
      - Try different location
      - Use read-only alternative
    examples:
      - "Write to /etc → write to local config"
      - "Direct file edit → edit via temp file and move"
      
  escalate:
    action: "Request permission elevation"
    message: "Permission denied for {operation}. May require elevated privileges."
    requires_user_action: true
```

### 5. RESOURCE_NOT_FOUND

```yaml
type: RESOURCE_NOT_FOUND
recovery_options:
  retry:
    action: "Verify path and retry"
    parameters:
      - Check for typos
      - Use relative paths
    timeout_ms: 5000
    max_attempts: 2
    
  fallback:
    action: "Create resource or use alternative"
    parameters:
      - Create missing file/directory
      - Search for similar resources
    examples:
      - "File not found → check for rename"
      - "Directory missing → create it"
      
  escalate:
    action: "Report missing critical resource"
    message: "Required resource not found: {resource}. Cannot proceed without it."
    requires_user_action: true
```

### 6. RATE_LIMITED

```yaml
type: RATE_LIMITED
recovery_options:
  retry:
    action: "Wait and retry with backoff"
    parameters:
      - Wait for limit reset
      - Reduce request rate
    timeout_ms: 60000
    max_attempts: 5
    backoff: exponential
    initial_wait_ms: 1000
    
  fallback:
    action: "Use cached or local alternative"
    parameters:
      - Use cached responses
      - Switch to local processing
    examples:
      - "API rate limit → use local model"
      - "Too many requests → batch operations"
      
  escalate:
    action: "Notify of persistent rate limiting"
    message: "Rate limit persisting. Consider adjusting usage or upgrading plan."
    requires_user_action: true
```

### 7. NETWORK_ERROR

```yaml
type: NETWORK_ERROR
recovery_options:
  retry:
    action: "Retry with backoff"
    parameters:
      - Implement retry logic
      - Check connectivity first
    timeout_ms: 30000
    max_attempts: 3
    backoff: exponential
    
  fallback:
    action: "Use offline mode or cache"
    parameters:
      - Work offline
      - Use cached data
    examples:
      - "API unreachable → work offline"
      - "Connection refused → use local files"
      
  escalate:
    action: "Report network issues"
    message: "Network connectivity issues detected. Check internet connection."
    requires_user_action: false
    log_for_review: true
```

### 8. STATE_ERROR

```yaml
type: STATE_ERROR
recovery_options:
  retry:
    action: "Reset state and retry"
    parameters:
      - Clear state
      - Restart from checkpoint
    timeout_ms: 10000
    max_attempts: 2
    
  fallback:
    action: "Use alternative workflow"
    parameters:
      - Bypass broken state
      - Use independent path
    examples:
      - "Session corrupted → start fresh session"
      - "Lock held → wait or force unlock"
      
  escalate:
    action: "Report state corruption"
    message: "State error detected: {details}. May require manual intervention."
    requires_user_action: true
```

### 9. CONTEXT_OVERFLOW

```yaml
type: CONTEXT_OVERFLOW
recovery_options:
  retry:
    action: "Summarize and retry"
    parameters:
      - Summarize context
      - Remove redundant information
    timeout_ms: 30000
    max_attempts: 2
    
  fallback:
    action: "Split into multiple calls"
    parameters:
      - Process in chunks
      - Use checkpoint system
    examples:
      - "Large file → process line ranges"
      - "Long history → summarize old entries"
      
  escalate:
    action: "Request smaller scope"
    message: "Context too large for single operation. Consider narrowing scope."
    requires_user_action: true
```

### 10. UNEXPECTED_OUTPUT

```yaml
type: UNEXPECTED_OUTPUT
recovery_options:
  retry:
    action: "Parse flexibly and retry"
    parameters:
      - Use lenient parsing
      - Handle multiple formats
    timeout_ms: 10000
    max_attempts: 2
    
  fallback:
    action: "Use raw output"
    parameters:
      - Process raw output
      - Apply transformations
    examples:
      - "JSON parse failed → use regex extraction"
      - "Missing field → use default value"
      
  escalate:
    action: "Report format change"
    message: "Output format unexpected. Tool may need update."
    requires_user_action: false
    log_for_review: true
```

---

## Recovery Execution Rules

### Selection Priority

```yaml
priority:
  1: retry (always try first if applicable)
  2: fallback (use when retry unlikely to succeed)
  3: escalate (last resort)
```

### Retry Rules

```yaml
retry_rules:
  max_retries: 3
  backoff_strategy: exponential
  initial_delay_ms: 1000
  max_delay_ms: 30000
  
  conditions:
    retry_on_transient: true
    retry_on_permanent: false
    
  counted_errors:
    - NETWORK_ERROR
    - RATE_LIMITED
    - TOOL_TIMEOUT
```

### Fallback Rules

```yaml
fallback_rules:
  require_log: true
  notify_user: true
  preserve_context: true
  
  conditions:
    - Retry exhausted
    - Retry not applicable
    - Better alternative exists
```

### Escalation Rules

```yaml
escalation_rules:
  conditions:
    - Critical severity
    - Requires user action
    - All recovery failed
    
  response:
    - Pause execution
    - Generate clear error message
    - Provide context for decision
    - Offer options if available
    - Await user response
```

---

## Timeout Configuration

```yaml
default_timeouts:
  retry_default_ms: 30000
  retry_max_ms: 60000
  fallback_execution_ms: 45000
  escalation_response_ms: 300000  # 5 min for user response

per_exception_timeouts:
  TOOL_TIMEOUT: 60000
  NETWORK_ERROR: 30000
  RATE_LIMITED: 60000
  CONTEXT_OVERFLOW: 30000
```