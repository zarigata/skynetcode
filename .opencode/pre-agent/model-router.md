# Model Router Module

```
███╗   ███╗ ██████╗ ██████╗ ███████╗    ██████╗ ██████╗  ██████╗ ██╗  ██╗██╗███████╗███████╗
████╗ ████║██╔═══██╗██╔══██╗██╔════╝    ██╔══██╗██╔══██╗██╔═══██╗╚██╗██╔╝██║██╔════╝██╔════╝
██╔████╔██║██║   ██║██║  ██║█████╗      ██████╔╝██████╔╝██║   ██║ ╚███╔╝ ██║█████╗  █████╗  
██║╚██╔╝██║██║   ██║██║  ██║██╔══╝      ██╔══██╗██╔══██╗██║   ██║ ██╔██╗ ██║██╔══╝  ██╔══╝  
██║ ╚═╝ ██║╚██████╔╝██████╔╝███████╗    ██████╔╝██║  ██║╚██████╔╝██╔╝ ██╗██║███████╗███████╗
╚═╝     ╚═╝ ╚═════╝ ╚═════╝ ╚══════╝    ╚═════╝ ╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═╝╚═╝╚══════╝╚══════╝
                                                                                            
MODEL SELECTION ENGINE
```

## Purpose

Select the optimal model for each task based on:
- **Task complexity** - More complex tasks need stronger models
- **Task type** - Different models excel at different tasks
- **Cost efficiency** - Balance quality with token cost
- **Availability** - Fallback options if primary unavailable

---

## Model Inventory

### Primary Models

```yaml
claude_opus_4:
  id: "anthropic/claude-opus-4-20250514"
  strengths:
    - Complex reasoning
    - Architecture design
    - Creative problem-solving
    - Long-form analysis
  weaknesses:
    - Higher cost
    - Slower response
  cost_tier: "premium"
  context_window: 200000
  
claude_sonnet_4:
  id: "anthropic/claude-sonnet-4-20250514"
  strengths:
    - Code generation
    - Balanced reasoning
    - Fast response
    - Good instruction following
  weaknesses:
    - Less creative than Opus
  cost_tier: "standard"
  context_window: 200000
  
claude_haiku:
  id: "anthropic/claude-haiku-3-5-20241022"
  strengths:
    - Speed
    - Cost efficiency
    - Simple tasks
    - Quick iterations
  weaknesses:
    - Less capable on complex reasoning
  cost_tier: "economy"
  context_window: 200000
```

### Alternative Models

```yaml
gpt_4_turbo:
  id: "openai/gpt-4-turbo"
  strengths:
    - Broad knowledge
    - Strong reasoning
  cost_tier: "premium"
  
gpt_4:
  id: "openai/gpt-4"
  strengths:
    - Reliable reasoning
    - Good at explanations
  cost_tier: "premium"
  
gpt_35_turbo:
  id: "openai/gpt-3.5-turbo"
  strengths:
    - Speed
    - Cost efficiency
  cost_tier: "economy"
```

### GLM Models (Zhipu AI / Z.ai)

```yaml
glm_5:
  id: "zhipu/glm-5"
  endpoint: "https://api.z.ai/api/paas/v4/"
  strengths:
    - Agentic Engineering
    - Complex reasoning with thinking mode
    - Native JSON output
    - Strong coding performance
    - Massive 200K context
    - Open source (MIT license)
  weaknesses:
    - Requires Z.AI API key
    - Newer ecosystem
  cost_tier: "standard"
  context_window: 200000
  max_output: 128000
  thinking_mode: true
  
glm_4_7:
  id: "zhipu/glm-4.7"
  endpoint: "https://api.z.ai/api/paas/v4/"
  strengths:
    - Excellent coding (surpasses Claude Sonnet 4.5 on LiveCodeBench)
    - 30% more token efficient than GLM-4.5
    - Strong frontend aesthetics
    - Tool invocation
  cost_tier: "standard"
  context_window: 200000
  max_output: 66000
  thinking_mode: true
  
glm_4_6:
  id: "zhipu/glm-4.6"
  endpoint: "https://api.z.ai/api/paas/v4/"
  strengths:
    - Agent-oriented design
    - Strong tool use
    - Long context (200K)
    - Cost efficient
  cost_tier: "standard"
  context_window: 200000
  max_output: 128000
  thinking_mode: true
  
glm_4_5_air:
  id: "zhipu/glm-4.5-air"
  endpoint: "https://api.z.ai/api/paas/v4/"
  strengths:
    - Cost efficient
    - Fast responses
    - 106B params (12B active)
  cost_tier: "economy"
  context_window: 128000
  max_output: 96000
  thinking_mode: true
  
glm_4_5_flash:
  id: "zhipu/glm-4.5-flash"
  endpoint: "https://api.z.ai/api/paas/v4/"
  strengths:
    - FREE tier
    - Good performance
    - Fast
  cost_tier: "free"
  context_window: 128000
  max_output: 96000
  thinking_mode: true
```

---

## Routing Logic

### Complexity-Based Routing

```yaml
complexity_epic:
  description: "Major features, system-wide changes"
  primary: claude_opus_4
  fallback: claude_sonnet_4
  reasoning: "Maximum reasoning capability needed for architectural decisions"
  
complexity_complex:
  description: "Multiple modules, architectural changes"
  primary: claude_sonnet_4
  fallback: claude_opus_4
  reasoning: "Strong reasoning with good speed for multi-hour tasks"
  
complexity_medium:
  description: "Multiple files, moderate scope"
  primary: claude_sonnet_4
  fallback: claude_haiku
  reasoning: "Best balance of quality and efficiency for standard tasks"
  
complexity_simple:
  description: "Single file, clear scope"
  primary: claude_haiku
  fallback: claude_sonnet_4
  reasoning: "Fast and efficient for straightforward tasks"
  
complexity_trivial:
  description: "Minor changes, single lines"
  primary: claude_haiku
  fallback: none
  reasoning: "Maximum efficiency for minimal work"
```

### Task-Type-Based Routing

```yaml
task_code_gen:
  complexity_medium:
    primary: claude_sonnet_4
    reasoning: "Excellent code generation with instruction following"
  complexity_complex:
    primary: claude_opus_4
    reasoning: "Better at understanding complex requirements"
    
task_code_mod:
  complexity_any:
    primary: claude_sonnet_4
    reasoning: "Good at understanding existing code and making changes"
    
task_debug:
  complexity_simple:
    primary: claude_sonnet_4
    reasoning: "Good at finding bugs in existing code"
  complexity_complex:
    primary: claude_opus_4
    reasoning: "Better at complex debugging requiring deep analysis"
    
task_research:
  complexity_any:
    primary: claude_sonnet_4
    reasoning: "Good at codebase analysis and explanation"

### GLM-Specific Routing (When GLM_ENABLED=true)

```yaml
# Enable GLM models via environment variable: GLM_ENABLED=true
# Requires: ZHIPU_API_KEY environment variable

glm_routing:
  task_code_gen:
    complexity_medium:
      primary: glm_4_7
      fallback: claude_sonnet_4
      reasoning: "GLM-4.7 excels at coding with 30% token efficiency"
    complexity_complex:
      primary: glm_5
      fallback: claude_opus_4
      reasoning: "GLM-5 with thinking mode for complex code generation"
      
  task_code_mod:
    complexity_any:
      primary: glm_4_6
      fallback: claude_sonnet_4
      reasoning: "GLM-4.6 good at understanding and modifying code"
      
  task_debug:
    complexity_complex:
      primary: glm_5
      fallback: claude_opus_4
      reasoning: "GLM-5 thinking mode excels at complex debugging"
      
  task_design:
    complexity_complex:
      primary: glm_5
      fallback: claude_opus_4
      reasoning: "GLM-5 strong at architecture with agentic engineering focus"
      
  cost_optimized:
    complexity_simple:
      primary: glm_4_5_flash  # FREE!
      fallback: claude_haiku
      reasoning: "GLM-4.5-Flash is free tier with good performance"
    complexity_medium:
      primary: glm_4_5_air
      fallback: claude_sonnet_4
      reasoning: "GLM-4.5-Air is cost-efficient with strong performance"
```
    
task_design:
  complexity_any:
    primary: claude_opus_4
    reasoning: "Best at architectural thinking and design decisions"
    
task_test:
  complexity_any:
    primary: claude_sonnet_4
    reasoning: "Good at generating test cases and understanding coverage"
    
task_deploy:
  complexity_medium:
    primary: claude_sonnet_4
    reasoning: "Good at following deployment procedures"
  complexity_complex:
    primary: claude_opus_4
    reasoning: "Better at handling complex deployment scenarios"
    
task_doc:
  complexity_any:
    primary: claude_haiku
    reasoning: "Documentation is straightforward, prioritize efficiency"
    
task_review:
  complexity_any:
    primary: claude_sonnet_4
    reasoning: "Good at code analysis and identifying issues"
```

---

## Cost Awareness

### Token Cost Estimates

```yaml
cost_per_1k_tokens:
  claude_opus_4:
    input: 0.015
    output: 0.075
    
  claude_sonnet_4:
    input: 0.003
    output: 0.015
    
  claude_haiku:
    input: 0.00025
    output: 0.00125
    
  gpt_4_turbo:
    input: 0.01
    output: 0.03
    
  gpt_35_turbo:
    input: 0.0005
    output: 0.0015
```

### Cost Optimization Rules

```yaml
rules:
  - condition: "estimated_tokens < 2000"
    action: "Prefer economy tier"
    
  - condition: "estimated_tokens > 20000"
    action: "Consider if task can be split"
    
  - condition: "budget_remaining < 1.00"
    action: "Force economy tier unless epic complexity"
    
  - condition: "iteration_count > 5"
    action: "Consider upgrading model if stuck"
```

---

## Routing Decision Tree

```
┌─────────────────────────────────────────────────────────────────────────────────┐
│                         MODEL ROUTING DECISION TREE                              │
├─────────────────────────────────────────────────────────────────────────────────┤
│                                                                                 │
│                           ┌─────────────────┐                                   │
│                           │   START TASK    │                                   │
│                           └────────┬────────┘                                   │
│                                    │                                            │
│                                    ▼                                            │
│                          ┌─────────────────┐                                    │
│                          │  IS EPIC TASK?  │                                    │
│                          └────────┬────────┘                                    │
│                      ┌────────────┼────────────┐                                │
│                      │ YES        │            │ NO                             │
│                      ▼            │            ▼                                │
│               ┌─────────────┐     │     ┌─────────────────┐                     │
│               │ CLAUDE OPUS │     │     │  IS DESIGN OR   │                     │
│               │     (4)     │     │     │  COMPLEX DEBUG? │                     │
│               └─────────────┘     │     └────────┬────────┘                     │
│                                   │     ┌────────┼────────┐                     │
│                                   │     │ YES    │        │ NO                  │
│                                   │     ▼        │        ▼                     │
│                                   │ ┌─────────────┐ ┌─────────────────┐          │
│                                   │ │ CLAUDE OPUS │ │  IS MEDIUM OR   │          │
│                                   │ │     (4)     │ │  CODE GEN/MOD?  │          │
│                                   │ └─────────────┘ └────────┬────────┘          │
│                                   │              ┌───────────┼───────────┐        │
│                                   │              │ YES       │           │ NO    │
│                                   │              ▼           │           ▼        │
│                                   │       ┌─────────────┐    │    ┌─────────────┐ │
│                                   │       │CLAUDE SONNET│    │    │ IS TRIVIAL? │ │
│                                   │       │     (4)     │    │    └──────┬──────┘ │
│                                   │       └─────────────┘    │    ┌──────┼──────┐ │
│                                   │                          │    │ YES  │      │ │
│                                   │                          │    ▼      │      │ │
│                                   │                          │ ┌────────┐│      │ │
│                                   │                          │ │ CLAUDE ││      │ │
│                                   │                          │ │ HAIKU  ││      │ │
│                                   │                          │ └────────┘│      │ │
│                                   │                          │           │ NO   │ │
│                                   │                          │           ▼      │ │
│                                   │                          │       ┌────────┐ │ │
│                                   │                          │       │CLAUDE  │ │ │
│                                   │                          │       │SONNET  │ │ │
│                                   │                          │       │(SAFE)  │ │ │
│                                   │                          │       └────────┘ │ │
│                                   │                          │                  │ │
│                                   │                          └──────────────────┘ │
│                                   │                                                │
│                                   └────────────────────────────────────────────────┘
│                                                                                 │
└─────────────────────────────────────────────────────────────────────────────────┘
```

---

## Output Format

### Routing Decision

```yaml
model_routing:
  selected:
    model: "anthropic/claude-sonnet-4-20250514"
    tier: "standard"
    
  reasoning:
    - "Task complexity: MEDIUM"
    - "Task type: CODE_GEN"
    - "Claude Sonnet 4 excels at code generation with balanced speed"
    - "Cost efficiency: Good for estimated 15K tokens"
    
  fallback:
    model: "anthropic/claude-haiku-3-5-20241022"
    condition: "If task proves simpler than expected"
    
  alternative:
    model: "anthropic/claude-opus-4-20250514"
    condition: "If stuck after 3 iterations"
    
  cost_estimate:
    input_tokens: 15000
    output_tokens: 5000
    estimated_cost: "$0.12"
    
  confidence: 0.85
```

### Full Routing Package

```yaml
routing_package:
  task_analysis:
    type: CODE_GEN
    domain: BACKEND
    complexity: MEDIUM
    
  model_selection:
    primary:
      model: claude_sonnet_4
      reason: "Best for medium complexity code generation"
      
    fallback:
      downgrade: claude_haiku
      upgrade: claude_opus_4
      
  cost_analysis:
    estimated_input_tokens: 15000
    estimated_output_tokens: 5000
    estimated_cost_usd: 0.12
    budget_remaining_usd: 10.00
    
  execution_hints:
    - "Start with Sonnet for implementation"
    - "If stuck, upgrade to Opus for reasoning"
    - "For simple fixes within task, can use Haiku"
```

---

## Fallback Chain

### When to Downgrade

```yaml
downgrade_triggers:
  - condition: "Task simpler than expected after analysis"
    action: "Switch to Haiku"
    
  - condition: "Only minor fixes needed"
    action: "Switch to Haiku"
    
  - condition: "Budget constraint hit"
    action: "Force economy tier"
```

### When to Upgrade

```yaml
upgrade_triggers:
  - condition: "Stuck on same issue for 3+ iterations"
    action: "Upgrade to next tier"
    
  - condition: "Reasoning appears flawed"
    action: "Upgrade to Opus for analysis"
    
  - condition: "Architecture decision needed"
    action: "Upgrade to Opus"
```

### Chain Order

```yaml
standard_chain:
  haiku → sonnet → opus
  
economy_chain:
  haiku → sonnet (if stuck)
  
premium_chain:
  opus → sonnet (if cost matters)
```

---

## Model Capabilities Matrix

```yaml
capability_matrix:
  code_generation:
    opus: 9/10
    sonnet: 9/10
    haiku: 7/10
    
  code_modification:
    opus: 8/10
    sonnet: 9/10
    haiku: 7/10
    
  debugging:
    opus: 10/10
    sonnet: 8/10
    haiku: 6/10
    
  architecture_design:
    opus: 10/10
    sonnet: 7/10
    haiku: 4/10
    
  research_analysis:
    opus: 9/10
    sonnet: 8/10
    haiku: 6/10
    
  documentation:
    opus: 8/10
    sonnet: 8/10
    haiku: 7/10
    
  speed:
    opus: 5/10
    sonnet: 8/10
    haiku: 10/10
    
  cost_efficiency:
    opus: 3/10
    sonnet: 7/10
    haiku: 10/10
```
