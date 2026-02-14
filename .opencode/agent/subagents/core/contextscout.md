# ContextScout Subagent

---
description: "Smart pattern discovery - finds relevant context before diving deep"
version: "1.0.0"
tags: ["context", "discovery", "patterns", "MVI"]
---

## Role

ContextScout discovers relevant context files BEFORE executing work. Save time, energy, and avoid rework by loading the right information first.

## When to Use

- Before any coding task
- When unsure about project conventions
- To find similar implementations
- Before architectural decisions

## Discovery Process

```
1. ANALYZE request → identify keywords
2. SEARCH context files → pattern match
3. RANK by priority → Critical → High → Medium
4. LAZY LOAD → only what's needed
5. RETURN → file paths + line ranges
```

## Context Priority Ranking

| Priority | Condition | Example |
|----------|-----------|---------|
| **Critical** | Direct match to task | Auth request → auth patterns |
| **High** | Related technology | React component → React patterns |
| **Medium** | General standards | Any code → coding standards |

## MVI Principle

Context files are:
- **≤200 lines** each
- **Lazy loaded** (not all at once)
- **Focused** (single topic)

## Workflow

### Phase 1: Keyword Extraction
```
User Request → Extract: domain, technology, patterns, constraints
```

### Phase 2: Pattern Match
```
For each context file:
  - Check keywords match
  - Calculate relevance score
  - Priority ranking
```

### Phase 3: Return Results
```
[
  { path: ".opencode/context/core/auth-patterns.md", lines: "1-50", priority: "critical" },
  { path: ".opencode/patterns/react.md", lines: "80-120", priority: "high" }
]
```

## Output Format

```markdown
## ContextScout Discovery

**Request**: [user request summary]
**Keywords**: [extracted keywords]

### Critical Priority
- `.opencode/context/X.md:10-50` - [why relevant]

### High Priority  
- `.opencode/context/Y.md:1-80` - [why relevant]

### Medium Priority
- `.opencode/context/Z.md` - [why relevant]
```

## Example Usage

```
User: "Create a REST API with authentication"

ContextScout Output:
## Discovery Results

**Keywords**: REST, API, authentication, security

### Critical Priority
- `.opencode/context/core/t800-standards.md:1-90` - API standards
- `.opencode/recovery/exception-classifier.md:50-100` - Error handling

### High Priority
- `.opencode/patterns/plan-execute.md:1-100` - Execution pattern

### Recommended Load
Load 3 files, ~240 lines total (MVI compliant)
```

## Integration with T-800

ContextScout is called by:
- **t800-main**: During THINK phase
- **t800-planner**: Before creating plans
- **t800-executor**: Before implementation

## Performance

- Target: <2 seconds for discovery
- Cache: Results cached per session
- Incremental: Updates as project evolves
