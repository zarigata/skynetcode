# T-800 Pre-Agent Skill

## Skill Name
`pre-agent`

## Description
Task optimization layer that runs BEFORE T-800 starts working. Analyzes tasks, retrieves knowledge, optimizes context, and selects the best model.

## When to Use
Use this skill when:
- Starting a new T-800 session
- Task complexity is unclear
- Need to optimize context before execution
- Want best model selection for task

## Core Principle
**PREPARE THE BEST CONTEXT. SELECT THE BEST MODEL. START SMART.**

---

## ▓▒▓ PRE-AGENT WORKFLOW █▓▒▓

```
┌─────────────────────────────────────────────────────────────────────────────────┐
│                           PRE-AGENT WORKFLOW                                     │
├─────────────────────────────────────────────────────────────────────────────────┤
│                                                                                 │
│   INPUT: User Task                                                              │
│       │                                                                         │
│       ▼                                                                         │
│   ┌─────────────────────────────────────────────────────────────────────────┐  │
│   │  STEP 1: CLASSIFY TASK                                                   │  │
│   │  ├── Extract keywords                                                    │  │
│   │  ├── Match task type (CODE_GEN, DEBUG, etc.)                             │  │
│   │  ├── Detect domain (FRONTEND, BACKEND, etc.)                             │  │
│   │  ├── Estimate complexity (TRIVIAL → EPIC)                                │  │
│   │  └── Identify dependencies                                               │  │
│   └─────────────────────────────────────────────────────────────────────────┘  │
│       │                                                                         │
│       ▼                                                                         │
│   ┌─────────────────────────────────────────────────────────────────────────┐  │
│   │  STEP 2: RETRIEVE KNOWLEDGE                                              │  │
│   │  ├── Read .opencode/memory/AGENTS.md                                     │  │
│   │  ├── Search codebase for similar implementations                        │  │
│   │  ├── Query Context7 for library docs (if needed)                        │  │
│   │  └── Extract relevant patterns, gotchas, examples                       │  │
│   └─────────────────────────────────────────────────────────────────────────┘  │
│       │                                                                         │
│       ▼                                                                         │
│   ┌─────────────────────────────────────────────────────────────────────────┐  │
│   │  STEP 3: OPTIMIZE CONTEXT                                                │  │
│   │  ├── Apply balanced compression strategy                                 │  │
│   │  ├── Preserve critical gotchas and patterns                              │  │
│   │  ├── Compress verbose documentation                                      │  │
│   │  └── Fit within 10K token budget                                         │  │
│   └─────────────────────────────────────────────────────────────────────────┘  │
│       │                                                                         │
│       ▼                                                                         │
│   ┌─────────────────────────────────────────────────────────────────────────┐  │
│   │  STEP 4: ROUTE MODEL                                                     │  │
│   │  ├── Match complexity to model tier                                      │  │
│   │  ├── Adjust for task type                                                │  │
│   │  ├── Consider cost efficiency                                            │  │
│   │  └── Select primary + fallback models                                    │  │
│   └─────────────────────────────────────────────────────────────────────────┘  │
│       │                                                                         │
│       ▼                                                                         │
│   OUTPUT: YAML Intelligence Package                                             │
│                                                                                 │
└─────────────────────────────────────────────────────────────────────────────────┘
```

---

## ▓▒▓ TASK CLASSIFICATION █▓▒▓

### Task Types

| Type | Indicators | Complexity Range |
|------|------------|------------------|
| CODE_GEN | "create", "build", "implement" | Medium-Complex |
| CODE_MOD | "update", "refactor", "change" | Simple-Medium |
| DEBUG | "bug", "error", "fix", "crash" | Simple-Complex |
| RESEARCH | "how", "find", "understand" | Simple-Medium |
| DESIGN | "architecture", "design", "plan" | Complex-Epic |
| TEST | "test", "spec", "coverage" | Simple-Medium |
| DEPLOY | "deploy", "ci/cd", "release" | Medium-Complex |
| DOC | "document", "readme", "comment" | Trivial-Simple |

### Domains

| Domain | Indicators |
|--------|------------|
| FRONTEND | "component", "react", "css", "ui" |
| BACKEND | "api", "server", "database", "express" |
| DEVOPS | "docker", "kubernetes", "deploy" |
| DATA | "sql", "schema", "migration" |
| TESTING | "test", "spec", "mock" |

### Complexity Levels

| Level | Token Estimate | Time Estimate |
|-------|----------------|---------------|
| TRIVIAL | 500-2K | 1-5 min |
| SIMPLE | 2K-8K | 5-20 min |
| MEDIUM | 8K-20K | 20-60 min |
| COMPLEX | 20K-50K | 1-4 hours |
| EPIC | 50K+ | 4+ hours |

---

## ▓▒▓ KNOWLEDGE SOURCES █▓▒▓

### Priority Order

1. **AGENTS.md** (Priority 1)
   - Project-specific patterns
   - Known gotchas
   - User preferences
   - Recent learnings

2. **Codebase** (Priority 2)
   - Similar implementations
   - Existing patterns
   - Related files
   - Test examples

3. **Context7** (Priority 3)
   - Library documentation
   - API references
   - Best practices
   - Version info

4. **Web Search** (Priority 4 - Fallback)
   - Unknown libraries
   - Recent changes
   - Security info

---

## ▓▒▓ CONTEXT OPTIMIZATION █▓▒▓

### Balanced Strategy

```yaml
preserve_100_percent:
  - Critical gotchas
  - Working code patterns
  - Essential API signatures

compress_40_60_percent:
  - Verbose documentation
  - Redundant examples
  - Explanatory text

remove_entirely:
  - Obsolete patterns
  - Irrelevant library docs
  - Duplicate information
```

### Token Budget

```yaml
total: 10000
allocation:
  gotchas: 1500
  patterns: 3000
  examples: 2000
  docs: 2500
  preferences: 1000
```

---

## ▓▒▓ MODEL ROUTING █▓▒▓

### Complexity-Based Routing

| Complexity | Primary | Fallback |
|------------|---------|----------|
| EPIC | claude-opus-4 | claude-sonnet-4 |
| COMPLEX | claude-sonnet-4 | claude-opus-4 |
| MEDIUM | claude-sonnet-4 | claude-haiku |
| SIMPLE | claude-haiku | claude-sonnet-4 |
| TRIVIAL | claude-haiku | none |

### Task-Type Adjustments

```yaml
DESIGN: Prefer opus (architecture needs)
DEBUG complex: Prefer opus (deep analysis)
DOC: Prefer haiku (efficiency)
CODE_GEN: Sonnet default (best quality)
```

---

## ▓▒▓ OUTPUT FORMAT █▓▒▓

### Standard Output

```yaml
# T-800 PRE-AGENT ANALYSIS COMPLETE

task_profile:
  original: "[task description]"
  type: [TYPE]
  domain: [DOMAIN]
  complexity: [LEVEL]
  confidence: 0.XX
  dependencies: [...]
  
knowledge_package:
  token_budget: 10000
  tokens_used: XXXX
  
  gotchas:
    critical:
      - "⚠️ [GOTCHA]"
      
  patterns:
    recommended:
      - pattern: "[NAME]"
        description: "[DESC]"
        
  examples:
    from_codebase:
      - file: "[PATH]"
        relevance: "[WHY]"
        
model_selection:
  primary:
    model: "[MODEL]"
    reason: "[WHY]"
  fallback:
    model: "[MODEL]"
    trigger: "[WHEN]"
  estimated_cost: "$X.XX"
  
ready_for_t800: true
```

---

## ▓▒▓ USAGE █▓▒▓

### Automatic (Recommended)

Pre-Agent runs automatically before T-800:

```bash
# Pre-Agent is called automatically
opencode --agent t800 "Build a REST API"

# Output includes:
# 1. Task classification
# 2. Knowledge retrieval
# 3. Context optimization
# 4. Model selection
# 5. Ready-for-T800 signal
```

### Manual Analysis

```bash
# Run Pre-Agent analysis only
opencode --agent t800-pre-agent "Analyze this task"
```

---

## ▓▒▓ BEST PRACTICES █▓▒▓

1. **Always check AGENTS.md first** - Project-specific knowledge is most valuable
2. **Search codebase before external docs** - Existing patterns are proven to work
3. **Be conservative with token estimates** - Better to underestimate complexity
4. **Include fallback models** - Tasks can prove more complex than expected
5. **Document learnings** - Update AGENTS.md after task completion
