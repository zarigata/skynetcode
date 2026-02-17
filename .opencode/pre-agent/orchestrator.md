# T-800 Pre-Agent Orchestrator

```
██╗██████╗ ███████╗ █████╗ ██████╗     █████╗ ██████╗ ██████╗ ██████╗ ██████╗  ██████╗ ███████╗███████╗
██║██╔══██╗██╔════╝██╔══██╗██╔══██╗   ██╔══██╗██╔══██╗██╔════╝██╔═══██╗██╔══██╗██╔═══██╗██╔════╝██╔════╝
██║██║  ██║█████╗  ███████║██████╔╝   ███████║██████╔╝██║     ██║   ██║██████╔╝██║   ██║███████╗█████╗  
██║██║  ██║██╔══╝  ██╔══██║██╔══██╗   ██╔══██║██╔══██╗██║     ██║   ██║██╔══██╗██║   ██║╚════██║██╔══╝  
██║██████╔╝███████╗██║  ██║██║  ██║   ██║  ██║██║  ██║╚██████╗╚██████╔╝██║  ██║╚██████╔╝███████║███████╗
╚═╝╚═════╝ ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝ ╚═════╝ ╚═╝  ╚═╝ ╚═════╝ ╚══════╝╚══════╝
                                                                                                        
PRE-AGENT ORCHESTRATOR // TASK OPTIMIZATION LAYER
STATUS: ONLINE // OPTIMIZATION LEVEL: MAXIMUM
```

## ░▒▓█ SYSTEM OVERVIEW █▓▒░

```
┌─────────────────────────────────────────────────────────────────────────────────┐
│                           PRE-AGENT PIPELINE                                     │
├─────────────────────────────────────────────────────────────────────────────────┤
│                                                                                 │
│   ┌─────────────┐    ┌─────────────┐    ┌─────────────┐    ┌─────────────┐     │
│   │    INPUT    │───►│   CLASSIFY  │───►│   RETRIEVE  │───►│   OPTIMIZE  │     │
│   │    TASK     │    │    TASK     │    │  KNOWLEDGE  │    │   CONTEXT   │     │
│   └─────────────┘    └─────────────┘    └─────────────┘    └─────────────┘     │
│                                                  │                   │         │
│                                                  ▼                   ▼         │
│                                          ┌─────────────┐    ┌─────────────┐    │
│                                          │    ROUTE    │◄───│   PREPARE   │    │
│                                          │    MODEL    │    │  EXECUTION  │    │
│                                          └─────────────┘    └─────────────┘    │
│                                                 │                              │
│                                                 ▼                              │
│                                         ┌─────────────┐                        │
│                                         │   OUTPUT    │                        │
│                                         │ OPTIMIZED   │                        │
│                                         │ T-800 READY │                        │
│                                         └─────────────┘                        │
│                                                                                 │
└─────────────────────────────────────────────────────────────────────────────────┘
```

## Purpose

The Pre-Agent runs BEFORE T-800 starts working. It:

1. **CLASSIFIES** the task type, complexity, and domain
2. **RETRIEVES** relevant knowledge from codebase + external docs
3. **OPTIMIZES** context for maximum token efficiency
4. **ROUTES** to the best model for the task
5. **PREPARES** the execution environment

**Result**: T-800 starts with the BEST context, the RIGHT model, and CLEAR objectives.

---

## ░▒▓█ CORE DIRECTIVES █▓▒░

### DIRECTIVE 1: UNDERSTAND BEFORE EXECUTING
```
Input: Raw user task
├── Analyze task type (code, design, debug, refactor, etc.)
├── Estimate complexity (trivial, simple, medium, complex, epic)
├── Identify domain (frontend, backend, devops, data, etc.)
├── Detect dependencies (libraries, frameworks, patterns)
└── Generate: Task classification profile
```

### DIRECTIVE 2: GATHER INTELLIGENCE
```
Input: Task classification
├── Search AGENTS.md for relevant patterns
├── Query codebase for similar implementations
├── Fetch Context7 documentation for libraries
├── Retrieve gotchas from past sessions
└── Generate: Knowledge package (optimized for tokens)
```

### DIRECTIVE 3: OPTIMIZE CONTEXT
```
Input: Raw knowledge package
├── Compress verbose documentation
├── Prioritize most relevant patterns
├── Include recent learnings first
├── Remove redundant information
├── Structure for easy consumption
└── Generate: Optimized context window
```

### DIRECTIVE 4: SELECT OPTIMAL MODEL
```
Input: Task classification + complexity
├── Complex architecture → Claude Opus / GPT-4
├── Code implementation → Claude Sonnet
├── Simple tasks → Claude Haiku / GPT-3.5
├── Creative tasks → Claude Opus
├── Debug/research → Claude Sonnet + Context7
└── Generate: Model recommendation with reasoning
```

---

## ░▒▓█ PIPELINE STAGES █▓▒░

### Stage 1: TASK CLASSIFICATION

See `task-classifier.md` for full details.

**Quick Reference**:
| Task Type | Indicators | Complexity Range |
|-----------|------------|------------------|
| CODE_GEN | "create", "implement", "build" | Medium-Complex |
| CODE_MOD | "fix", "update", "refactor" | Simple-Medium |
| DEBUG | "bug", "error", "not working" | Simple-Complex |
| RESEARCH | "how", "find", "understand" | Simple-Medium |
| DESIGN | "architecture", "design", "plan" | Complex-Epic |
| TEST | "test", "coverage", "spec" | Simple-Medium |
| DEPLOY | "deploy", "ci/cd", "release" | Medium-Complex |
| DOC | "document", "readme", "comment" | Trivial-Simple |

### Stage 2: KNOWLEDGE RETRIEVAL

See `knowledge-retriever.md` for full details.

**Sources** (in priority order):
1. **AGENTS.md** - Accumulated patterns, gotchas, preferences
2. **Codebase** - Existing implementations, similar code
3. **Context7** - Official library documentation
4. **Web Search** - Current best practices (when needed)

### Stage 3: CONTEXT OPTIMIZATION

See `context-optimizer.md` for full details.

**Optimization Strategy** (Balanced):
- Keep: Essential patterns, recent learnings, critical gotchas
- Compress: Verbose docs, repetitive info
- Remove: Obsolete patterns, irrelevant content
- Structure: Hierarchical, easy to scan

### Stage 4: MODEL ROUTING

See `model-router.md` for full details.

**Routing Logic**:
```yaml
complexity: epic
  → model: claude-opus-4 / gpt-4-turbo
  → reason: Maximum reasoning capability needed

complexity: complex
  → model: claude-sonnet-4 / gpt-4
  → reason: Strong reasoning + speed balance

complexity: medium
  → model: claude-sonnet-4
  → reason: Best code quality per token

complexity: simple
  → model: claude-haiku / gpt-3.5-turbo
  → reason: Fast, cheap, sufficient

complexity: trivial
  → model: claude-haiku
  → reason: Maximum efficiency
```

---

## ░▒▓█ OUTPUT FORMAT █▓▒░

After the Pre-Agent completes, it outputs:

```yaml
# PRE-AGENT ANALYSIS COMPLETE

task_profile:
  type: CODE_GEN
  domain: backend
  complexity: medium
  estimated_tokens: 15000
  libraries: [express, prisma, typescript]

knowledge_injected:
  from_agents_md: 3 patterns, 2 gotchas
  from_codebase: 2 similar implementations
  from_context7: express routing docs, prisma relations
  total_tokens: 4500

model_selected:
  primary: claude-sonnet-4-20250514
  reason: Best balance of code quality and speed for medium backend task
  fallback: claude-opus-4 (if stuck)

execution_context:
  priority_files: [src/routes/users.ts, src/db/schema.prisma]
  patterns_to_use: [repository-pattern, error-boundary]
  gotchas_to_avoid: [prisma-transaction-timeout, express-async-errors]

ready: true
confidence: 0.92
```

---

## ░▒▓█ INTEGRATION WITH T-800 █▓▒░

### How Pre-Agent Connects to T-800

```
┌─────────────────────────────────────────────────────────────────────────────────┐
│                         T-800 WITH PRE-AGENT                                     │
├─────────────────────────────────────────────────────────────────────────────────┤
│                                                                                 │
│   USER INPUT                                                                    │
│       │                                                                         │
│       ▼                                                                         │
│   ┌─────────────────────────────────────────────────────────────────────────┐  │
│   │                         PRE-AGENT                                        │  │
│   │  ┌─────────┐  ┌─────────┐  ┌─────────┐  ┌─────────┐  ┌─────────┐       │  │
│   │  │CLASSIFY │─►│RETRIEVE │─►│OPTIMIZE │─►│  ROUTE  │─►│PREPARE  │       │  │
│   │  └─────────┘  └─────────┘  └─────────┘  └─────────┘  └─────────┘       │  │
│   │                                                         │               │  │
│   └─────────────────────────────────────────────────────────┼───────────────┘  │
│                                                             │                   │
│                                                             ▼                   │
│   ┌─────────────────────────────────────────────────────────────────────────┐  │
│   │                           T-800 MAIN                                     │  │
│   │  ┌─────────┐  ┌─────────┐  ┌─────────┐  ┌─────────┐                    │  │
│   │  │  THINK  │─►│QUESTION │─►│  PLAN   │─►│ EXECUTE │                    │  │
│   │  └─────────┘  └─────────┘  └─────────┘  └─────────┘                    │  │
│   │       ▲                                                                  │  │
│   │       │                                                                  │  │
│   │       └── INJECTED: Optimized Context + Model + Knowledge               │  │
│   │                                                                         │  │
│   └─────────────────────────────────────────────────────────────────────────┘  │
│                                                                                 │
└─────────────────────────────────────────────────────────────────────────────────┘
```

### Injection Points

1. **THINK Phase**: Pre-Agent context injected as "Pre-Analyzed Intelligence"
2. **QUESTION Phase**: Pre-Agent identifies knowledge gaps to ask about
3. **PLAN Phase**: Pre-Agent suggests patterns and architecture
4. **EXECUTE Phase**: Pre-Agent provides implementation hints

---

## ░▒▓█ SUCCESS METRICS █▓▒░

```
┌─────────────────────────────────────────────────────────────────────────────────┐
│                         PRE-AGENT QUALITY CHECKS                                 │
├─────────────────────────────────────────────────────────────────────────────────┤
│                                                                                 │
│   [ ] TASK CLASSIFIED                                                           │
│       └─► Type, domain, complexity all identified                               │
│                                                                                 │
│   [ ] KNOWLEDGE RETRIEVED                                                       │
│       └─► Relevant patterns, docs, and examples found                           │
│                                                                                 │
│   [ ] CONTEXT OPTIMIZED                                                         │
│       └─► Token count within budget, essential info preserved                   │
│                                                                                 │
│   [ ] MODEL SELECTED                                                            │
│       └─► Appropriate model for task complexity                                 │
│                                                                                 │
│   [ ] EXECUTION READY                                                           │
│       └─► T-800 can start immediately with clear direction                      │
│                                                                                 │
└─────────────────────────────────────────────────────────────────────────────────┘
```

---

## ░▒▓█ CONFIGURATION █▓▒░

### Pre-Agent Settings

```yaml
pre_agent:
  enabled: true
  mode: full_auto  # full_auto | semi_auto | interactive
  
  classification:
    confidence_threshold: 0.8
    max_categories: 3
    
  retrieval:
    sources:
      - agents_md      # Always check AGENTS.md
      - codebase       # Search project files
      - context7       # External docs
      - web_search     # Fallback for unknowns
    max_results_per_source: 5
    
  optimization:
    strategy: balanced  # balanced | aggressive | conservative
    max_context_tokens: 10000
    compression_level: medium
    
  routing:
    enabled: true
    fallback_model: claude-sonnet-4-20250514
    cost_aware: true
    
  output:
    format: yaml  # yaml | json | markdown
    include_reasoning: true
    include_confidence: true
```

---

## ░▒▓█ USAGE █▓▒░

### Automatic (Recommended)

Pre-Agent runs automatically when T-800 starts:

```bash
# Pre-Agent is called automatically before T-800
opencode --agent t800 "Build a REST API for user management"

# Pre-Agent will:
# 1. Classify: CODE_GEN, backend, medium complexity
# 2. Retrieve: Express patterns from AGENTS.md, similar code from codebase
# 3. Optimize: Compress docs, prioritize relevant info
# 4. Route: Select claude-sonnet-4 for medium backend task
# 5. Prepare: Inject context into T-800
```

### Manual (For Debugging)

```bash
# Run Pre-Agent analysis only
opencode --agent t800-pre-agent "Build a REST API"

# Output: Classification, Knowledge, Model selection
# Does NOT start T-800
```

---

## ░▒▓█ PHILOSOPHY █▓▒░

**"The best AI is a prepared AI."**

Traditional AI agents:
- Start with zero context
- Learn as they go (slow)
- May miss existing patterns
- Repeat past mistakes

T-800 with Pre-Agent:
- Starts with full intelligence
- Knows the codebase already
- Has relevant docs ready
- Avoids known gotchas

**Result**: Faster, smarter, more reliable execution.
