# T-800 Cost Tracker

Track LLM costs based on token usage for budget management and optimization.

## Purpose

Calculate, track, and report costs associated with LLM API usage to help users manage budgets and optimize spending.

## Cost Calculation

### Standard Formula

```
total_cost = (input_tokens × input_price_per_1k / 1000) + (output_tokens × output_price_per_1k / 1000)
```

### Pricing Reference

| Model | Input (per 1K) | Output (per 1K) |
|-------|----------------|-----------------|
| Claude Sonnet 4 | $0.003 | $0.015 |
| Claude Opus 4 | $0.015 | $0.075 |
| GPT-4o | $0.0025 | $0.010 |
| GPT-4o-mini | $0.00015 | $0.00060 |
| Gemini Pro | $0.00125 | $0.005 |

### Example Calculations

```yaml
example_1:
  model: claude-sonnet-4
  input_tokens: 10000
  output_tokens: 5000
  calculation: |
    input_cost = 10000 × 0.003 / 1000 = $0.030
    output_cost = 5000 × 0.015 / 1000 = $0.075
    total = $0.030 + $0.075 = $0.105

example_2:
  model: gpt-4o-mini
  input_tokens: 50000
  output_tokens: 25000
  calculation: |
    input_cost = 50000 × 0.00015 / 1000 = $0.0075
    output_cost = 25000 × 0.00060 / 1000 = $0.015
    total = $0.0075 + $0.015 = $0.0225
```

## Cost Tracking Layers

### Per-Call Tracking

```json
{
  "call_id": "llm_001",
  "timestamp": "2024-01-15T10:30:00Z",
  "model": "claude-sonnet-4",
  "input_tokens": 1500,
  "output_tokens": 800,
  "cost_usd": 0.0165,
  "purpose": "task_planning"
}
```

### Per-Task Tracking

```json
{
  "task_id": "task_001",
  "total_input_tokens": 5000,
  "total_output_tokens": 3000,
  "total_cost_usd": 0.060,
  "call_breakdown": [
    {"purpose": "planning", "cost": 0.015},
    {"purpose": "execution", "cost": 0.035},
    {"purpose": "review", "cost": 0.010}
  ]
}
```

### Per-Session Tracking

```json
{
  "session_id": "ses_abc123",
  "total_input_tokens": 25000,
  "total_output_tokens": 15000,
  "total_cost_usd": 0.300,
  "task_count": 5,
  "avg_cost_per_task": 0.060
}
```

### Daily Tracking

```json
{
  "date": "2024-01-15",
  "total_input_tokens": 150000,
  "total_output_tokens": 100000,
  "total_cost_usd": 1.95,
  "session_count": 10,
  "task_count": 50,
  "model_breakdown": {
    "claude-sonnet-4": {"tokens": 200000, "cost": 1.80},
    "gpt-4o-mini": {"tokens": 50000, "cost": 0.15}
  }
}
```

## Budget Management

### Budget Configuration

```yaml
budget:
  daily_limit_usd: 5.00
  session_limit_usd: 1.00
  task_limit_usd: 0.50
  warning_threshold_percent: 80
  
actions:
  on_warning:
    - notify_user
    - suggest_optimization
    
  on_limit_reached:
    - pause_execution
    - require_user_approval
    - offer_alternative_approaches
```

### Budget Alert Format

```markdown
⚠️ Budget Alert

Current Session Cost: $0.85
Session Limit: $1.00
Percentage Used: 85%

Breakdown:
- Planning: $0.15
- Execution: $0.55
- Review: $0.15

Recommendations:
1. Consider using a smaller model for review tasks
2. Combine multiple small edits into one LLM call
3. Use cached context where possible
```

## Cost Optimization Strategies

### 1. Model Selection

```yaml
optimization_model_selection:
  rule: Match model to task complexity
  
  mapping:
    simple_tasks:  # Classification, formatting
      recommended: gpt-4o-mini
      cost_saving: ~80%
      
    medium_tasks:  # Refactoring, debugging
      recommended: claude-sonnet-4
      cost_saving: ~50%
      
    complex_tasks:  # Architecture, design
      recommended: claude-opus-4
      cost_saving: none (appropriate use)
```

### 2. Context Optimization

```yaml
optimization_context:
  strategies:
    - Trim redundant context
    - Use semantic search for relevant context
    - Cache frequently used context
    - Progressive context loading
    
  estimated_savings: 30-50% token reduction
```

### 3. Caching

```yaml
optimization_caching:
  cacheable:
    - Frequently used prompts
    - Standard responses
    - Project context
    
  cache_hit_savings: 
    tokens_saved: 100%
    cost_saved: 100% of cached calls
```

## Cost Reporting

### Session Cost Report

```markdown
# Session Cost Report

## Session: ses_abc123
**Duration**: 30 minutes
**Tasks Completed**: 5

## Cost Summary
| Category | Input Tokens | Output Tokens | Cost |
|----------|-------------|---------------|------|
| Planning | 5,000 | 3,000 | $0.060 |
| Execution | 15,000 | 8,000 | $0.165 |
| Review | 5,000 | 4,000 | $0.075 |
| **Total** | **25,000** | **15,000** | **$0.300** |

## Model Usage
- Claude Sonnet 4: $0.300 (100%)

## Cost Efficiency
- Cost per Task: $0.060
- Tokens per Task: 8,000
- Efficiency Score: Good (top 40%)

## Recommendations
- ✅ Planning costs optimized
- ⚠️ Consider smaller model for simple reviews
```

### Daily Cost Report

```markdown
# Daily Cost Report

## Date: 2024-01-15

## Summary
- Total Cost: $1.95
- Sessions: 10
- Tasks: 50
- Avg Cost per Task: $0.039

## Model Breakdown
| Model | Calls | Cost | % of Total |
|-------|-------|------|------------|
| Claude Sonnet 4 | 45 | $1.80 | 92% |
| GPT-4o-mini | 10 | $0.15 | 8% |

## Top Cost Drivers
1. Task execution (65%): $1.27
2. Task planning (20%): $0.39
3. Code review (15%): $0.29

## Optimization Opportunities
- 12 simple tasks could use GPT-4o-mini
- Estimated savings: $0.25/day
```

## Integration Points

### LLM Call Hook

```yaml
hook_point: after_llm_call
actions:
  1. Extract token counts from response
  2. Calculate cost using model pricing
  3. Update session cost total
  4. Check against budget limits
  5. Trigger alerts if needed
```

### Trace Collector Integration

```yaml
integration: trace_events
mapping:
  llm_call_event:
    - tokens_in → input_tokens
    - tokens_out → output_tokens
    - model → pricing_model
    - cost → calculated_cost
```

## Configuration

```yaml
cost_tracker:
  enabled: true
  
  pricing:
    default_model: claude-sonnet-4
    models:
      claude-sonnet-4:
        input_per_1k: 0.003
        output_per_1k: 0.015
      gpt-4o-mini:
        input_per_1k: 0.00015
        output_per_1k: 0.00060
        
  budget:
    daily_usd: 5.00
    session_usd: 1.00
    task_usd: 0.50
    warning_threshold: 0.80
    
  reporting:
    session_report: true
    daily_report: true
    include_recommendations: true
```

## Privacy Considerations

```yaml
privacy:
  track_cost: true
  track_tokens: true
  track_content: false  # NEVER track content
  store_prompts: false
  store_completions: false
  
  user_control:
    - Can disable cost tracking
    - Can set own budgets
    - Can delete cost history
```