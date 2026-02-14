# T-800 Exception Classifier

Classify exceptions using SHIELDA-style methodology for structured recovery.

## Purpose

Identify and categorize exception types to enable appropriate recovery strategies.

## Top 10 Exception Types

### 1. TOOL_NOT_FOUND

```yaml
type: TOOL_NOT_FOUND
description: Requested tool does not exist or is not available
classification: Configuration Error
severity: High
detectable_from:
  - "tool.*not found"
  - "unknown tool"
  - "tool not available"
  
examples:
  - Error: "Tool 'deploy' not found"
  - Error: "Unknown operation 'migrate'"
  
root_cause: Tool not registered or incorrectly named
```

### 2. TOOL_TIMEOUT

```yaml
type: TOOL_TIMEOUT
description: Tool execution exceeded the time limit
classification: Resource Error
severity: Medium
detectable_from:
  - "timeout"
  - "exceeded.*limit"
  - "timed out"
  
examples:
  - Error: "Command 'npm install' timed out after 30000ms"
  - Error: "Operation exceeded 60000ms timeout"
  
root_cause: Operation too slow or network issues
```

### 3. INVALID_INPUT

```yaml
type: INVALID_INPUT
description: Input validation failed for tool or operation
classification: User Error
severity: Low
detectable_from:
  - "invalid.*input"
  - "validation failed"
  - "invalid argument"
  - "required.*missing"
  
examples:
  - Error: "Invalid input: file_path is required"
  - Error: "Validation failed: size must be positive integer"
  
root_cause: Missing required fields or wrong format
```

### 4. PERMISSION_DENIED

```yaml
type: PERMISSION_DENIED
description: Insufficient permissions to perform operation
classification: Authorization Error
severity: High
detectable_from:
  - "permission denied"
  - "access denied"
  - "unauthorized"
  - "forbidden"
  
examples:
  - Error: "Permission denied: cannot write to /etc/config"
  - Error: "Access denied: insufficient privileges"
  
root_cause: User lacks required permissions
```

### 5. RESOURCE_NOT_FOUND

```yaml
type: RESOURCE_NOT_FOUND
description: Requested file or resource does not exist
classification: Resource Error
severity: Medium
detectable_from:
  - "not found"
  - "does not exist"
  - "no such file"
  - "404"
  
examples:
  - Error: "File not found: src/missing.ts"
  - Error: "No such file or directory"
  
root_cause: Resource deleted or path incorrect
```

### 6. RATE_LIMITED

```yaml
type: RATE_LIMITED
description: API rate limit exceeded
classification: External Error
severity: Medium
detectable_from:
  - "rate limit"
  - "too many requests"
  - "429"
  - "quota exceeded"
  
examples:
  - Error: "Rate limit exceeded: 100 requests per minute"
  - Error: "API quota exceeded"
  
root_cause: Too many requests in time window
```

### 7. NETWORK_ERROR

```yaml
type: NETWORK_ERROR
description: Network connectivity issue
classification: Infrastructure Error
severity: Medium
detectable_from:
  - "network"
  - "connection refused"
  - "ETIMEDOUT"
  - "ECONNREFUSED"
  - "ENOTFOUND"
  
examples:
  - Error: "Connection refused to api.example.com"
  - Error: "Network timeout"
  
root_cause: Network instability or server down
```

### 8. STATE_ERROR

```yaml
type: STATE_ERROR
description: Invalid state transition or corrupted state
classification: Logic Error
severity: High
detectable_from:
  - "invalid state"
  - "corrupted"
  - "inconsistent"
  - "unexpected state"
  
examples:
  - Error: "Invalid state: cannot edit while in READ_ONLY mode"
  - Error: "State corruption detected"
  
root_cause: Incorrect workflow or concurrent modification
```

### 9. CONTEXT_OVERFLOW

```yaml
type: CONTEXT_OVERFLOW
description: Context window limit exceeded
classification: Resource Error
severity: High
detectable_from:
  - "context.*limit"
  - "maximum.*tokens"
  - "context.*overflow"
  - "too long"
  
examples:
  - Error: "Context limit exceeded: 200000 tokens"
  - Error: "Prompt too long for model"
  
root_cause: Too much context or insufficient summarization
```

### 10. UNEXPECTED_OUTPUT

```yaml
type: UNEXPECTED_OUTPUT
description: Tool returned output in unexpected format
classification: Integration Error
severity: Medium
detectable_from:
  - "unexpected.*format"
  - "parse error"
  - "invalid.*response"
  - "malformed"
  
examples:
  - Error: "Unexpected JSON format: missing 'result' field"
  - Error: "Parse error: invalid response from API"
  
root_cause: API change or version mismatch
```

## Classification Algorithm

### Pattern Matching Rules

```yaml
classification_rules:
  priority_order:
    - exact_match
    - regex_match
    - fuzzy_match
    
  scoring:
    exact_match: 100
    regex_match: 80
    fuzzy_match: 60
    
  threshold: 50  # Minimum score to classify
```

### Classification Flow

```
Error Message Received
         ↓
[Normalize Message]
         ↓
[Pattern Matching]
         ↓
[Score Calculation]
         ↓
┌─────────────────┐
│ Score >= 50?    │
└─────────────────┘
    ↓ Yes        ↓ No
[Classify]    [UNKNOWN_ERROR]
    ↓
[Return Classification]
```

### Example Classification

```yaml
input: "Error: npm install timed out after 60000ms"

processing:
  1. Normalize: "npm install timed out after 60000ms"
  2. Pattern Match:
     - "timeout" → TOOL_TIMEOUT (score: 80)
     - "timed out" → TOOL_TIMEOUT (score: 100)
  3. Calculate: max score = 100
  4. Threshold: 100 >= 50

output:
  type: TOOL_TIMEOUT
  confidence: 1.0
  matched_pattern: "timed out"
```

## Error Context Extraction

### Context Fields to Extract

```yaml
context_extraction:
  - tool_name: Extract from error if tool involved
  - file_path: Extract paths mentioned
  - operation: What was being attempted
  - duration: If timeout, extract time
  - size: If limit related, extract size
  - error_code: If available (e.g., ETIMEDOUT)
```

### Extraction Patterns

```yaml
patterns:
  tool_name: "Tool '(\w+)'"
  file_path: "(?:file|path)[:\s]+['\"]?([^'\"\s]+)['\"]?"
  duration: "(\d+)\s*ms"
  error_code: "([A-Z]+):"
```

## Severity Levels

```yaml
severity_levels:
  critical:
    description: System unusable or data at risk
    escalate_immediately: true
    retry_allowed: false
    
  high:
    description: Feature broken, work blocked
    escalate_after: 2 failed attempts
    retry_allowed: true
    max_retries: 3
    
  medium:
    description: Degraded experience, workaround possible
    escalate_after: 5 failed attempts
    retry_allowed: true
    max_retries: 5
    
  low:
    description: Minor issue, does not block work
    escalate_after: never
    retry_allowed: true
    max_retries: 10
```

## Integration with Recovery System

### Output Format

```json
{
  "classification_id": "cls_abc123",
  "timestamp": "2024-01-15T10:30:00Z",
  "exception_type": "TOOL_TIMEOUT",
  "severity": "medium",
  "confidence": 0.95,
  "matched_patterns": ["timeout", "timed out"],
  "context": {
    "tool": "npm",
    "operation": "install",
    "duration_ms": 60000
  },
  "root_cause": "Operation too slow or network issues",
  "recommended_recovery": ["retry_with_longer_timeout", "use_cached_packages"]
}
```

### Recovery Trigger

```yaml
after_classification:
  1. Store classification in memory
  2. Look up handling patterns for exception type
  3. Apply appropriate recovery strategy
  4. Escalate if severity requires
```

## Performance Considerations

```yaml
performance:
  max_classification_time_ms: 50
  pattern_cache_enabled: true
  fuzzy_match_threshold: 0.6
  
optimization:
  - Pre-compile regex patterns
  - Cache common error matches
  - Use lazy evaluation for rare types
```