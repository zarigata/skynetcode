# Knowledge Retriever Module

```
██╗  ██╗ ██████╗ ██████╗ ██████╗  ██████╗ ██╗    ██╗███╗   ██╗
██║  ██║██╔═══██╗██╔══██╗██╔══██╗██╔═══██╗██║    ██║████╗  ██║
███████║██║   ██║██████╔╝██║  ██║██║   ██║██║ █╗ ██║██╔██╗ ██║
██╔══██║██║   ██║██╔══██╗██║  ██║██║   ██║██║███╗██║██║╚██╗██║
██║  ██║╚██████╔╝██║  ██║██████╔╝╚██████╔╝╚███╔███╔╝██║ ╚████║
╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═╝╚═════╝  ╚═════╝  ╚══╝╚══╝ ╚═╝  ╚═══╝
                                                            
KNOWLEDGE RETRIEVAL ENGINE
```

## Purpose

Gather relevant knowledge from multiple sources to provide T-800 with the best context:

1. **AGENTS.md** - Accumulated patterns, gotchas, preferences
2. **Codebase** - Existing implementations, similar code
3. **Context7** - Official library documentation
4. **Web Search** - Current best practices (when needed)

---

## Retrieval Priority

```
┌─────────────────────────────────────────────────────────────────────────────────┐
│                     KNOWLEDGE SOURCE PRIORITY                                    │
├─────────────────────────────────────────────────────────────────────────────────┤
│                                                                                 │
│   Priority 1: AGENTS.md                                                         │
│   ┌─────────────────────────────────────────────────────────────────────────┐  │
│   │ • Patterns that worked in THIS codebase                                  │  │
│   │ • Gotchas that tripped T-800 before                                      │  │
│   │ • User preferences discovered over time                                  │  │
│   │ • Project-specific conventions                                           │  │
│   └─────────────────────────────────────────────────────────────────────────┘  │
│                                                                                 │
│   Priority 2: Codebase Search                                                   │
│   ┌─────────────────────────────────────────────────────────────────────────┐  │
│   │ • Similar implementations in project                                     │  │
│   │ • Existing patterns to follow                                            │  │
│   │ • Related files and dependencies                                         │  │
│   │ • Test examples to match                                                 │  │
│   └─────────────────────────────────────────────────────────────────────────┘  │
│                                                                                 │
│   Priority 3: Context7 (External Docs)                                          │
│   ┌─────────────────────────────────────────────────────────────────────────┐  │
│   │ • Official library documentation                                         │  │
│   │ • API references                                                         │  │
│   │ • Best practices from maintainers                                        │  │
│   │ • Version-specific information                                           │  │
│   └─────────────────────────────────────────────────────────────────────────┘  │
│                                                                                 │
│   Priority 4: Web Search (Fallback)                                             │
│   ┌─────────────────────────────────────────────────────────────────────────┐  │
│   │ • Unknown libraries or patterns                                          │  │
│   │ • Recent changes or deprecations                                         │  │
│   │ • Community solutions to common problems                                 │  │
│   │ • Security advisories                                                    │  │
│   └─────────────────────────────────────────────────────────────────────────┘  │
│                                                                                 │
└─────────────────────────────────────────────────────────────────────────────────┘
```

---

## Source 1: AGENTS.md Retrieval

### What to Extract

```yaml
patterns:
  - Code patterns that worked
  - Architecture patterns discovered
  - Testing patterns effective in this project
  
gotchas:
  - Common pitfalls encountered
  - Environment-specific issues
  - Dependency quirks
  
preferences:
  - Naming conventions
  - File organization
  - Error handling style
  
learnings:
  - Recent session learnings
  - What worked / what failed
  - Resolution patterns
```

### Extraction Logic

```
Input: Task classification + AGENTS.md content

1. Parse AGENTS.md into sections
2. Match task domain to relevant sections
3. Extract patterns matching task type
4. Identify applicable gotchas
5. Note relevant preferences
6. Include recent learnings (last 7 days)

Output: Filtered AGENTS.md knowledge
```

### Example Output

```yaml
from_agents_md:
  patterns:
    - pattern: "Repository pattern for data access"
      relevance: 0.85
      context: "Used in user-service.ts"
    - pattern: "Error boundary with custom AppError class"
      relevance: 0.70
      context: "See src/errors/"
      
  gotchas:
    - gotcha: "Prisma transactions timeout after 5s"
      relevance: 0.90
      context: "Use batch operations instead"
    - gotcha: "Express async errors need express-async-errors"
      relevance: 0.95
      context: "Import at top of app.ts"
      
  preferences:
    - preference: "Use arrow functions for callbacks"
    - preference: "Prefer named exports over default"
    
  recent_learnings:
    - date: "2024-01-15"
      learning: "Mock at service boundary for cleaner tests"
```

---

## Source 2: Codebase Retrieval

### Search Strategy

```yaml
similarity_search:
  description: "Find similar code to what's being built"
  strategy:
    - Search for same domain keywords
    - Find files with similar names
    - Locate related test files
    
pattern_search:
  description: "Find existing patterns to follow"
  strategy:
    - Search for similar class/function names
    - Find same library usage
    - Locate similar API structures
    
dependency_search:
  description: "Find related files and imports"
  strategy:
    - Find files that import same modules
    - Locate files in same directory
    - Find test files for source files
```

### Search Queries

For a task like "Create a REST API for user management":

```yaml
queries:
  - type: similarity
    patterns: ["user", "api", "route", "controller"]
    files: []
    
  - type: pattern
    patterns: ["router", "express", "async"]
    files: ["*.ts", "*.js"]
    
  - type: dependency
    patterns: ["import.*user", "from.*user"]
    files: []
```

### Output Format

```yaml
from_codebase:
  similar_implementations:
    - file: "src/routes/product.routes.ts"
      similarity: 0.82
      relevance: "Similar REST API structure"
      snippets:
        - "Router setup with validation middleware"
        - "Error handling pattern"
        
    - file: "src/controllers/auth.controller.ts"
      similarity: 0.75
      relevance: "Similar authentication pattern"
      snippets:
        - "JWT verification middleware"
        
  related_files:
    - file: "src/models/user.model.ts"
      reason: "User model - likely needed"
    - file: "src/middleware/auth.middleware.ts"
      reason: "Auth middleware - may be reused"
    - file: "src/types/user.types.ts"
      reason: "User types - reference for types"
```

---

## Source 3: Context7 Retrieval

### When to Use Context7

```yaml
always_query:
  - New libraries not in AGENTS.md
  - Specific API questions
  - Version-specific features
  
conditional_query:
  - If codebase search returns no results
  - If task involves unfamiliar patterns
  - If library version is recent
  
skip_query:
  - If AGENTS.md has comprehensive coverage
  - If task is trivial
  - If library is well-known (native JS/TS)
```

### Query Construction

For "Create a REST API with Express and JWT":

```yaml
context7_queries:
  - library: "/expressjs/express"
    query: "How to set up REST API routing with middleware"
    
  - library: "/auth0/node-jsonwebtoken"
    query: "JWT sign and verify best practices"
    
  - library: "/express-validator/express-validator"
    query: "Request validation middleware patterns"
```

### Output Format

```yaml
from_context7:
  express:
    topics_retrieved:
      - "Router setup and middleware"
      - "Error handling patterns"
    snippets:
      - snippet: "app.use(express.json()) for body parsing"
        source: "express docs"
      - snippet: "router.METHOD(path, ...handlers)"
        source: "routing guide"
    tokens_used: 800
    
  jsonwebtoken:
    topics_retrieved:
      - "JWT signing with secret"
      - "Token verification"
    snippets:
      - snippet: "jwt.sign(payload, secret, { expiresIn: '1h' })"
        source: "jwt docs"
    tokens_used: 400
```

---

## Source 4: Web Search (Fallback)

### When to Use Web Search

```yaml
trigger_conditions:
  - Context7 returns no results
  - Library is very new or niche
  - Need current security advisories
  - Need recent deprecation information
  
avoid_when:
  - Task is straightforward
  - AGENTS.md has good coverage
  - Codebase has similar implementations
```

### Search Queries

```yaml
web_queries:
  - "express.js JWT authentication best practices 2024"
  - "node.js REST API security checklist"
  - "prisma user model patterns"
```

---

## Knowledge Aggregation

### Merging Sources

```
┌─────────────────────────────────────────────────────────────────────────────────┐
│                     KNOWLEDGE AGGREGATION PIPELINE                               │
├─────────────────────────────────────────────────────────────────────────────────┤
│                                                                                 │
│   ┌─────────────┐                                                               │
│   │  AGENTS.md  │ ◄── Highest Priority (project-specific)                       │
│   └──────┬──────┘                                                               │
│          │                                                                      │
│          ▼                                                                      │
│   ┌─────────────┐                                                               │
│   │  CODEBASE   │ ◄── Add implementation examples                               │
│   └──────┬──────┘                                                               │
│          │                                                                      │
│          ▼                                                                      │
│   ┌─────────────┐                                                               │
│   │  CONTEXT7   │ ◄── Add library documentation                                 │
│   └──────┬──────┘                                                               │
│          │                                                                      │
│          ▼                                                                      │
│   ┌─────────────┐                                                               │
│   │ WEB SEARCH  │ ◄── Add if needed (fallback)                                  │
│   └──────┬──────┘                                                               │
│          │                                                                      │
│          ▼                                                                      │
│   ┌─────────────────────────────────────────────────────────────────────────┐  │
│   │                    AGGREGATED KNOWLEDGE PACKAGE                          │  │
│   │  ┌─────────────┐ ┌─────────────┐ ┌─────────────┐ ┌─────────────┐       │  │
│   │  │  PATTERNS   │ │   GOTCHAS   │ │   DOCS      │ │  EXAMPLES   │       │  │
│   │  └─────────────┘ └─────────────┘ └─────────────┘ └─────────────┘       │  │
│   └─────────────────────────────────────────────────────────────────────────┘  │
│                                                                                 │
└─────────────────────────────────────────────────────────────────────────────────┘
```

### Output Package

```yaml
knowledge_package:
  summary:
    sources_used: [agents_md, codebase, context7]
    total_patterns: 5
    total_gotchas: 3
    total_examples: 4
    estimated_tokens: 3500
    
  patterns:
    from_agents_md:
      - "Repository pattern for data access"
      - "Error boundary with AppError class"
    from_codebase:
      - "Router setup from product.routes.ts"
      - "Middleware chain from auth.middleware.ts"
    from_context7:
      - "Express routing best practices"
      
  gotchas:
    from_agents_md:
      - "Prisma transaction timeout"
      - "Express async errors import"
    from_context7:
      - "JWT secret should be 256+ bits"
      
  examples:
    from_codebase:
      - file: "src/routes/product.routes.ts"
        relevant_sections: ["router setup", "validation"]
      - file: "src/middleware/auth.middleware.ts"
        relevant_sections: ["JWT verification"]
        
  documentation:
    from_context7:
      - library: "express"
        topics: ["routing", "middleware", "error handling"]
      - library: "jsonwebtoken"
        topics: ["sign", "verify", "expiration"]
```

---

## Token Budgeting

### Allocation Strategy

```yaml
token_budget:
  total: 10000  # Maximum tokens for knowledge
  
  allocation:
    agents_md: 2000     # 20% - Project-specific knowledge
    codebase: 4000      # 40% - Implementation examples
    context7: 3000      # 30% - Library documentation
    web_search: 1000    # 10% - Fallback (if needed)
    
  compression:
    enabled: true
    strategy: "balanced"
    preserve:
      - Critical patterns
      - Active gotchas
      - Working code examples
    compress:
      - Verbose documentation
      - Redundant examples
    remove:
      - Outdated patterns
      - Irrelevant sections
```

### Budget Tracking

```yaml
token_usage:
  agents_md:
    requested: 2500
    compressed: 1800
    used: 1800
    
  codebase:
    requested: 4500
    compressed: 3500
    used: 3500
    
  context7:
    requested: 2000
    compressed: 1500
    used: 1500
    
  total:
    budget: 10000
    used: 6800
    remaining: 3200
    efficiency: "68%"
```

---

## Caching Strategy

### Cache Levels

```yaml
session_cache:
  description: "In-memory cache for current session"
  ttl: "1 hour"
  max_entries: 50
  
daily_cache:
  description: "Persisted cache for repeated queries"
  ttl: "24 hours"
  storage: ".opencode/cache/knowledge/"
  
invalidation:
  - AGENTS.md modified → Clear session cache
  - New files added → Clear codebase cache
  - Day change → Clear daily cache
```
