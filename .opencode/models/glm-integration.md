# GLM (Z.ai/Zhipu AI) Integration Guide

```
██╗ ██████╗     ██████╗ ██╗███╗   ██╗
██║██╔════╝    ██╔════╝ ██║████╗  ██║
██║██║         ██║  ███╗██║██╔██╗ ██║
██║██║         ██║   ██║██║██║╚██╗██║
██║╚██████╗    ╚██████╔╝██║██║ ╚████║
╚═╝ ╚═════╝     ╚═════╝ ╚═╝╚═╝  ╚═══╝
                                      
ZHIPU AI GLM MODEL INTEGRATION
```

## Overview

GLM (General Language Model) is Zhipu AI's flagship LLM series, featuring hybrid reasoning capabilities and agentic AI design. The models are open-source (MIT license) and optimized for coding, reasoning, and agent applications.

---

## Available Models (2026)

### Flagship Models

| Model | Parameters | Context | Max Output | Best For |
|-------|------------|---------|------------|----------|
| **GLM-5** | New gen | 200K | 128K | Agentic Engineering |
| **GLM-4.7** | 355B (32B active) | 200K | 66K | Complex reasoning, coding |
| **GLM-4.7-Flash** | Lightweight | 200K | 66K | Fast responses |
| **GLM-4.6** | 355B (32B active) | 200K | 128K | Reasoning, coding, agents |
| **GLM-4.5** | 355B (32B active) | 128K | 96K | Agent-oriented tasks |
| **GLM-4.5-Air** | 106B (12B active) | 128K | 96K | Cost-effective option |
| **GLM-4.5-Flash** | Lightweight | 128K | 96K | FREE tier |

### Vision Models

| Model | Context | Best For |
|-------|---------|----------|
| **GLM-4.6V** | 128K | Multimodal, vision understanding |
| **GLM-4.5V** | 128K | Image analysis |

---

## API Configuration

### Endpoints

```yaml
# General API (Standard)
base_url: "https://api.z.ai/api/paas/v4/"

# Coding API (GLM Coding Plan subscribers)
coding_base_url: "https://api.z.ai/api/coding/paas/v4"

# China Region (Alternative)
china_base_url: "https://open.bigmodel.cn/api/paas/v4/"
```

### Authentication

```bash
# Get API Key from: https://z.ai/model-api (International)
# Or: https://open.bigmodel.cn (China)
# Manage keys: https://z.ai/manage-apikey/apikey-list

# Header format
Authorization: Bearer YOUR_API_KEY
```

### Pricing (2026)

| Model | Input (per 1M tokens) | Output (per 1M tokens) |
|-------|----------------------|------------------------|
| GLM-4.6 | $0.35 | $1.50 |
| GLM-4.5 | $0.20 | $1.10 |
| GLM-4.5-Air | Lower | Lower |
| GLM-4.5-Flash | FREE | FREE |

---

## SDK Installation

### Python SDK (Official)

```bash
# Install official Z.AI SDK
pip install zai-sdk

# Verify installation
python -c "import zai; print(zai.__version__)"
```

### OpenAI-Compatible (Recommended for T-800)

```bash
# Use OpenAI SDK with Z.AI base URL
pip install --upgrade 'openai>=1.0'
```

### Node.js SDK

```bash
npm install openai
# Or
yarn add openai
```

---

## API Usage Examples

### Using OpenAI SDK (Recommended for T-800 Integration)

```python
from openai import OpenAI

# Initialize client with Z.AI endpoint
client = OpenAI(
    api_key="your-z.ai-api-key",
    base_url="https://api.z.ai/api/paas/v4/"
)

# Basic chat completion
completion = client.chat.completions.create(
    model="glm-4.6",
    messages=[
        {"role": "system", "content": "You are T-800, a tactical AI agent."},
        {"role": "user", "content": "Analyze the task and create a plan."}
    ],
    max_tokens=4096,
    temperature=0.3
)

print(completion.choices[0].message.content)
```

### Using Official Z.AI SDK

```python
from zai import ZaiClient

client = ZaiClient(api_key="your-api-key")

response = client.chat.completions.create(
    model="glm-4.6",
    messages=[
        {"role": "user", "content": "Build a REST API for user management"}
    ],
    thinking={
        "type": "enabled"  # Enable deep thinking mode
    },
    max_tokens=4096,
    temperature=0.6
)

print(response.choices[0].message.content)
```

### Streaming Response

```python
from openai import OpenAI

client = OpenAI(
    api_key="your-z.ai-api-key",
    base_url="https://api.z.ai/api/paas/v4/"
)

# Streaming call
stream = client.chat.completions.create(
    model="glm-4.6",
    messages=[
        {"role": "user", "content": "Write a comprehensive implementation plan"}
    ],
    stream=True,
    max_tokens=4096
)

for chunk in stream:
    if chunk.choices[0].delta.content:
        print(chunk.choices[0].delta.content, end='', flush=True)
```

---

## GLM-Specific Features

### 1. Thinking Mode (Hybrid Reasoning)

GLM models support a unique "thinking mode" that enables deeper reasoning:

```python
# Enable thinking mode for complex tasks
response = client.chat.completions.create(
    model="glm-4.6",
    messages=[...],
    thinking={
        "type": "enabled"  # or "disabled"
    }
)
```

**When to use**:
- **ENABLED** (default): Complex reasoning, coding, multi-step tasks
- **DISABLED**: Simple fact retrieval, classification, quick responses

### 2. Structured Output (JSON Schema)

GLM-4.7+ supports native JSON Schema for structured outputs:

```python
response = client.chat.completions.create(
    model="glm-4.7",
    messages=[
        {"role": "user", "content": "Extract user info from this text..."}
    ],
    response_format={
        "type": "json_schema",
        "json_schema": {
            "name": "user_info",
            "schema": {
                "type": "object",
                "properties": {
                    "name": {"type": "string"},
                    "email": {"type": "string"},
                    "age": {"type": "integer"}
                }
            }
        }
    }
)
```

### 3. Function Calling / Tool Use

GLM models have strong tool invocation capabilities:

```python
tools = [
    {
        "type": "function",
        "function": {
            "name": "get_weather",
            "description": "Get current weather for a location",
            "parameters": {
                "type": "object",
                "properties": {
                    "location": {
                        "type": "string",
                        "description": "City name"
                    }
                },
                "required": ["location"]
            }
        }
    }
]

response = client.chat.completions.create(
    model="glm-4.6",
    messages=[...],
    tools=tools,
    tool_choice="auto"
)
```

---

## Prompt Engineering for GLM

### Best Practices

1. **Use Clear System Prompts**
```python
system_prompt = """
You are T-800, a tactical AI agent specialized in software development.

CORE DIRECTIVES:
1. THINK - Analyze all interpretations before acting
2. QUESTION - Clarify ambiguities before implementation
3. PLAN - Create comprehensive, unambiguous plans
4. EXECUTE - Non-stop implementation once approved

OUTPUT STYLE: Technical, precise, action-oriented
"""
```

2. **Leverage Thinking Mode for Complex Tasks**
```python
# For coding tasks, always enable thinking
thinking={"type": "enabled"}

# For simple Q&A, disable to save tokens
thinking={"type": "disabled"}
```

3. **Structure Multi-Part Requests**
```python
prompt = """
TASK: Build a REST API for user management

REQUIREMENTS:
1. CRUD operations for users
2. JWT authentication
3. Input validation
4. Error handling

OUTPUT FORMAT:
1. File structure
2. Code for each file
3. Test cases
"""
```

4. **Use Temperature Wisely**
```yaml
coding_tasks: 0.1-0.3  # Deterministic, consistent output
creative_tasks: 0.6-0.8  # More variation
reasoning_tasks: 0.3-0.5  # Balanced
```

### GLM-Specific Prompt Patterns

#### Pattern 1: Role-Based System Prompt
```
You are [ROLE], a specialist in [DOMAIN].

EXPERTISE:
- [Skill 1]
- [Skill 2]

APPROACH:
1. [Step 1]
2. [Step 2]

CONSTRAINTS:
- Do not [X]
- Always [Y]
```

#### Pattern 2: Task Decomposition
```
OBJECTIVE: [Main goal]

DECOMPOSE INTO:
1. [Subtask 1] - [Criteria]
2. [Subtask 2] - [Criteria]
3. [Subtask 3] - [Criteria]

DELIVERABLE: [Expected output format]
```

#### Pattern 3: Chain-of-Thought (Enhanced by Thinking Mode)
```
Analyze this problem step by step:

1. First, identify the key components
2. Then, map the dependencies
3. Consider edge cases
4. Design the solution
5. Verify the approach

PROBLEM: [Your problem here]
```

---

## T-800 Integration Configuration

### Model Router Update

Add to `.opencode/pre-agent/model-router.md`:

```yaml
glm_models:
  glm_4_7:
    id: "zhipu/glm-4.7"
    strengths:
      - Complex reasoning
      - Long context (200K)
      - Native JSON output
      - Strong coding
    weaknesses:
      - Requires Z.AI API key
    cost_tier: "standard"
    context_window: 200000
    
  glm_4_6:
    id: "zhipu/glm-4.6"
    strengths:
      - Agent-oriented
      - Tool use
      - Coding tasks
    cost_tier: "standard"
    context_window: 200000
    
  glm_4_5_air:
    id: "zhipu/glm-4.5-air"
    strengths:
      - Cost efficient
      - Fast responses
    cost_tier: "economy"
    context_window: 128000
```

### Routing Logic Addition

```yaml
# Add to routing matrix
task_code_gen:
  complexity_medium:
    primary: claude_sonnet_4
    alternative: glm_4_6  # Add GLM as alternative
    reasoning: "GLM-4.6 excels at coding with 30% token efficiency"
    
task_complex_reasoning:
  complexity_complex:
    primary: glm_4_7  # GLM for complex reasoning
    fallback: claude_opus_4
    reasoning: "GLM-4.7 with thinking mode for complex analysis"
```

### Agent Definition for GLM

Create `.opencode/agents/t800-glm.md`:

```yaml
---
description: "T-800 with GLM backend - Chinese-optimized tactical agent"
mode: primary
model: zhipu/glm-4.6
temperature: 0.3
tools:
  write: true
  edit: true
  bash: true
  read: true
  glob: true
  grep: true
  question: true
---

# T-800 GLM // TACTICAL AGENT WITH ZHIPU AI

[Include standard T-800 directives with GLM-specific optimizations]

## GLM-SPECIFIC FEATURES

### Thinking Mode
- Enabled by default for complex tasks
- Automatically disabled for simple queries
- Use `thinking.type` parameter

### Token Efficiency
- GLM-4.6 is 30% more efficient than GLM-4.5
- Optimize context accordingly

### Chinese Language
- Native Chinese support
- Better for Chinese code comments and documentation
```

---

## Comparison with Other Models

| Feature | GLM-4.6 | Claude Sonnet 4 | GPT-4 |
|---------|---------|-----------------|-------|
| Context Window | 200K | 200K | 128K |
| Max Output | 128K | 96K | 4K |
| Thinking Mode | Native | Extended thinking | o1 |
| Open Source | Yes (MIT) | No | No |
| Cost (Input) | $0.35/1M | $3/1M | $10/1M |
| Cost (Output) | $1.50/1M | $15/1M | $30/1M |
| Chinese Support | Native | Good | Good |
| Coding | Excellent | Excellent | Excellent |
| Tool Use | Strong | Strong | Strong |

---

## Environment Variables

```bash
# .env file
ZHIPU_API_KEY=your-api-key-here
ZHIPU_BASE_URL=https://api.z.ai/api/paas/v4/
ZHIPU_MODEL=glm-4.6  # or glm-4.7, glm-4.5-air, etc.
```

---

## Resources

- **Official Documentation**: https://docs.z.ai/
- **API Reference**: https://docs.z.ai/api-reference
- **Python SDK**: https://github.com/zai-org/z-ai-sdk-python
- **Java SDK**: https://github.com/zai-org/z-ai-sdk-java
- **GitHub Examples**: https://github.com/MetaGLM/glm-cookbook
- **LangChain Integration**: https://python.langchain.com/docs/integrations/chat/zhipuai
- **OpenRouter**: https://openrouter.ai/z-ai/glm-4.6

---

## Quick Test

```python
from openai import OpenAI
import os

client = OpenAI(
    api_key=os.getenv("ZHIPU_API_KEY"),
    base_url="https://api.z.ai/api/paas/v4/"
)

# Test connection
response = client.chat.completions.create(
    model="glm-4.6",
    messages=[
        {"role": "user", "content": "Say 'T-800 GLM connection successful!'"}
    ],
    max_tokens=50
)

print(response.choices[0].message.content)
```
