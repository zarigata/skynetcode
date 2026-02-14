# T-800 Metrics Aggregator

Aggregate performance data across sessions for analysis and optimization.

## Purpose

Collect, aggregate, and analyze performance metrics to identify trends, bottlenecks, and improvement opportunities.

## Metrics Categories

### 1. Execution Metrics

```yaml
execution_metrics:
  task_completion_rate:
    description: Percentage of tasks successfully completed
    calculation: completed_tasks / total_tasks
    unit: percentage (0-100)
    target: >= 90%
    
  average_task_duration:
    description: Mean time to complete a task
    calculation: sum(task_duration) / task_count
    unit: milliseconds
    target: varies by task type
    
  first_attempt_success_rate:
    description: Percentage of tasks completed without rework
    calculation: first_attempt_success / total_tasks
    unit: percentage (0-100)
    target: >= 70%
```

### 2. Quality Metrics

```yaml
quality_metrics:
  test_pass_rate:
    description: Percentage of tests passing
    calculation: passing_tests / total_tests
    unit: percentage (0-100)
    target: >= 95%
    
  code_quality_score:
    description: Aggregate quality score from lint/typecheck
    calculation: weighted average of quality checks
    unit: score (0-100)
    target: >= 90
    
  regression_rate:
    description: Percentage of changes that broke existing functionality
    calculation: regressions / total_changes
    unit: percentage (0-100)
    target: <= 5%
```

### 3. Cost Metrics

```yaml
cost_metrics:
  total_token_usage:
    description: Sum of all LLM tokens used
    calculation: sum(input_tokens + output_tokens)
    unit: tokens
    
  cost_per_task:
    description: Average cost per task
    calculation: total_cost / task_count
    unit: USD
    target: optimize downward
    
  cost_per_session:
    description: Total cost per session
    calculation: sum(session_costs)
    unit: USD
```

### 4. Efficiency Metrics

```yaml
efficiency_metrics:
  tool_overhead:
    description: Time spent on tool operations vs execution
    calculation: tool_time / total_time
    unit: percentage
    target: <= 20%
    
  retry_rate:
    description: Percentage of operations requiring retry
    calculation: retries / total_operations
    unit: percentage
    target: <= 5%
    
  context_utilization:
    description: How effectively context window is used
    calculation: useful_tokens / total_tokens
    unit: percentage
    target: >= 70%
```

## Aggregation Levels

### Session Level

```json
{
  "session_id": "ses_abc123",
  "timestamp": "2024-01-15T10:30:00Z",
  "metrics": {
    "task_completion_rate": 0.85,
    "average_task_duration_ms": 45000,
    "total_tokens": 15000,
    "total_cost_usd": 0.045,
    "tool_call_count": 25,
    "error_count": 2,
    "retry_count": 1
  }
}
```

### Daily Level

```json
{
  "date": "2024-01-15",
  "aggregate_metrics": {
    "total_sessions": 5,
    "total_tasks": 25,
    "task_completion_rate": 0.88,
    "total_tokens": 75000,
    "total_cost_usd": 0.225,
    "average_session_duration_ms": 1800000,
    "peak_concurrent_sessions": 2
  }
}
```

### Weekly Level

```json
{
  "week": "2024-W03",
  "aggregate_metrics": {
    "total_sessions": 35,
    "total_tasks": 175,
    "task_completion_rate": 0.91,
    "total_tokens": 525000,
    "total_cost_usd": 1.575,
    "trend_task_completion": "+3%",
    "trend_cost": "-5%"
  }
}
```

## Calculation Formulas

### Success Rate

```
success_rate = successful_outcomes / total_attempts

Example:
successful_tasks: 18
total_tasks: 20
success_rate = 18 / 20 = 0.90 (90%)
```

### Cost Calculation

```
cost = (input_tokens × input_price) + (output_tokens × output_price)

Standard Pricing:
- Input: $0.003 per 1K tokens
- Output: $0.015 per 1K tokens

Example:
input_tokens: 10000
output_tokens: 5000
cost = (10000 × 0.003 / 1000) + (5000 × 0.015 / 1000)
cost = 0.03 + 0.075 = $0.105
```

### Weighted Quality Score

```
quality_score = (lint_score × 0.3) + (typecheck_score × 0.3) + (test_score × 0.4)

Example:
lint_score: 95
typecheck_score: 100
test_score: 90
quality_score = (95 × 0.3) + (100 × 0.3) + (90 × 0.4)
quality_score = 28.5 + 30 + 36 = 94.5
```

## Trend Analysis

### Trend Detection Rules

```yaml
thresholds:
  improvement:
    condition: current > previous AND (current - previous) / previous >= 0.05
    emoji: "📈"
    
  decline:
    condition: current < previous AND (previous - current) / previous >= 0.05
    emoji: "📉"
    
  stable:
    condition: |difference| / previous < 0.05
    emoji: "➡️"
```

### Trend Report Format

```markdown
# Weekly Trend Report

## Execution Trends
- Task Completion: 📈 91% (+3% from last week)
- Avg Duration: ➡️ 45s (stable)
- First Attempt Success: 📉 72% (-5% from last week)

## Cost Trends
- Total Cost: 📉 $1.58 (-5% from last week)
- Cost per Task: 📉 $0.009 (-3% from last week)

## Recommendations
1. Address first-attempt success decline
2. Continue cost optimization strategies
```

## Integration with Trace Collector

### Data Flow

```
[Trace Files]
     ↓
[Parse Events]
     ↓
[Extract Metrics]
     ↓
[Aggregate by Time Period]
     ↓
[Store in metrics.json]
     ↓
[Generate Trend Reports]
```

### Event to Metric Mapping

| Event Type | Metrics Extracted |
|------------|-------------------|
| `tool_call` | duration, success, tool_usage_count |
| `llm_call` | tokens, cost, model_usage |
| `error` | error_count, error_rate, recovery_rate |
| `checkpoint` | phase_duration, phase_success |

## Output Files

### File Structure

```
.opencode/telemetry/
├── metrics/
│   ├── session/
│   │   └── ses_abc123_metrics.json
│   ├── daily/
│   │   └── 2024-01-15_metrics.json
│   └── weekly/
│       └── 2024-W03_metrics.json
└── reports/
    └── trend_report_2024-W03.md
```

## Usage Examples

### Example 1: Session Metrics

```json
{
  "session_id": "ses_001",
  "duration_ms": 180000,
  "metrics": {
    "task_completion_rate": 0.85,
    "average_task_duration_ms": 45000,
    "total_tokens": 12500,
    "input_tokens": 8500,
    "output_tokens": 4000,
    "total_cost_usd": 0.0855,
    "tool_call_count": 18,
    "tool_success_rate": 0.94,
    "error_count": 2,
    "error_types": ["TOOL_TIMEOUT", "PERMISSION_DENIED"],
    "retry_count": 1
  }
}
```

### Example 2: Daily Aggregation

```json
{
  "date": "2024-01-15",
  "sessions": 8,
  "total_metrics": {
    "total_tasks": 40,
    "completed_tasks": 36,
    "failed_tasks": 4,
    "task_completion_rate": 0.90,
    "total_tokens": 100000,
    "total_cost_usd": 0.60,
    "total_tool_calls": 150,
    "total_errors": 8,
    "total_retries": 5
  },
  "averages": {
    "avg_session_duration_ms": 225000,
    "avg_tasks_per_session": 5,
    "avg_cost_per_session": 0.075
  },
  "top_errors": [
    {"type": "TOOL_TIMEOUT", "count": 3},
    {"type": "NETWORK_ERROR", "count": 2}
  ],
  "top_tools": [
    {"name": "read", "count": 45},
    {"name": "edit", "count": 38},
    {"name": "bash", "count": 25}
  ]
}
```

## Configuration

```yaml
metrics_aggregation:
  aggregation_levels:
    - session
    - daily
    - weekly
    
  track_metrics:
    - task_completion_rate
    - average_duration
    - token_usage
    - cost
    - error_rate
    - retry_rate
    
  trend_analysis:
    enabled: true
    comparison_periods: 4
    alert_on_decline: true
    decline_threshold: 0.05
```