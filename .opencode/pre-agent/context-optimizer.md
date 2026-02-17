# Context Optimizer Module

```
 ██████╗ ██████╗  ██████╗ ██████╗ ███████╗██╗      ██████╗ ███████╗███████╗
██╔════╝██╔═══██╗██╔════╝██╔═══██╗██╔════╝██║     ██╔════╝ ██╔════╝██╔════╝
██║     ██║   ██║██║     ██║   ██║█████╗  ██║     ██║  ███╗█████╗  █████╗  
██║     ██║   ██║██║     ██║   ██║██╔══╝  ██║     ██║   ██║██╔══╝  ██╔══╝  
╚██████╗╚██████╔╝╚██████╗╚██████╔╝███████╗███████╗╚██████╔╝███████╗██║     
 ╚═════╝ ╚═════╝  ╚═════╝ ╚═════╝ ╚══════╝╚══════╝ ╚═════╝ ╚══════╝╚═╝     
                                                                          
CONTEXT OPTIMIZATION ENGINE
```

## Purpose

Transform raw knowledge into an optimized context that:
- Fits within token budget
- Prioritizes most relevant information
- Structures for easy consumption by T-800
- Preserves critical details while compressing verbose content

---

## Optimization Strategy: Balanced

```
┌─────────────────────────────────────────────────────────────────────────────────┐
│                     BALANCED OPTIMIZATION STRATEGY                               │
├─────────────────────────────────────────────────────────────────────────────────┤
│                                                                                 │
│   Principle: Essential info preserved, verbose content compressed               │
│                                                                                 │
│   ┌─────────────────────────────────────────────────────────────────────────┐  │
│   │  PRESERVE (100%)                                                         │  │
│   │  • Critical patterns that worked                                         │  │
│   │  • Active gotchas to avoid                                               │  │
│   │  • Working code examples                                                 │  │
│   │  • Essential API signatures                                              │  │
│   └─────────────────────────────────────────────────────────────────────────┘  │
│                                                                                 │
│   ┌─────────────────────────────────────────────────────────────────────────┐  │
│   │  COMPRESS (40-60%)                                                       │  │
│   │  • Verbose documentation                                                 │  │
│   │  • Redundant examples                                                    │  │
│   │  • Explanatory text                                                      │  │
│   │  • Full file paths (use relative)                                        │  │
│   └─────────────────────────────────────────────────────────────────────────┘  │
│                                                                                 │
│   ┌─────────────────────────────────────────────────────────────────────────┐  │
│   │  REMOVE (0%)                                                             │  │
│   │  • Obsolete patterns                                                     │  │
│   │  • Irrelevant library docs                                               │  │
│   │  • Duplicate information                                                 │  │
│   │  • Comment-only sections                                                 │  │
│   └─────────────────────────────────────────────────────────────────────────┘  │
│                                                                                 │
└─────────────────────────────────────────────────────────────────────────────────┘
```

---

## Optimization Pipeline

### Stage 1: Relevance Scoring

Score each piece of knowledge by relevance to the task:

```yaml
scoring_factors:
  domain_match:
    weight: 0.30
    description: "How well does knowledge match task domain"
    
  task_type_match:
    weight: 0.25
    description: "How relevant to task type (CODE_GEN, DEBUG, etc.)"
    
  recency:
    weight: 0.20
    description: "How recently was this learned/used"
    
  success_rate:
    weight: 0.15
    description: "How often has this pattern worked"
    
  specificity:
    weight: 0.10
    description: "How specific vs generic is the knowledge"
```

### Stage 2: Token Budgeting

Allocate tokens across knowledge types:

```yaml
budget_allocation:
  critical_gotchas:
    priority: 1
    min_tokens: 500
    max_tokens: 1500
    
  working_patterns:
    priority: 2
    min_tokens: 1000
    max_tokens: 3000
    
  code_examples:
    priority: 3
    min_tokens: 500
    max_tokens: 2000
    
  library_docs:
    priority: 4
    min_tokens: 0
    max_tokens: 2000
    
  preferences:
    priority: 5
    min_tokens: 200
    max_tokens: 500
```

### Stage 3: Compression

Compress content while preserving meaning:

```yaml
compression_techniques:
  code_snippets:
    - Remove comments (keep only essential)
    - Shorten variable names (if obvious)
    - Remove unused imports
    - Keep only relevant functions
    
  documentation:
    - Extract key points as bullet lists
    - Remove introductory/explanatory text
    - Keep only API signatures
    - Summarize long descriptions
    
  patterns:
    - Extract to one-line summaries
    - Keep context only if critical
    - Reference source instead of full content
```

### Stage 4: Structuring

Organize optimized content for easy consumption:

```yaml
structure:
  header: |
    ## T-800 INTELLIGENCE PACKAGE
    **Task**: {task_summary}
    **Domain**: {domain}
    **Complexity**: {complexity}
    
  sections:
    - name: "⚠️ CRITICAL GOTCHAS"
      priority: 1
      format: "bullet_list"
      
    - name: "✅ PATTERNS TO USE"
      priority: 2
      format: "code_blocks"
      
    - name: "📚 API REFERENCE"
      priority: 3
      format: "signatures"
      
    - name: "💡 EXAMPLES"
      priority: 4
      format: "condensed_code"
```

---

## Compression Examples

### Example 1: Pattern Compression

**Before** (180 tokens):
```markdown
### Repository Pattern for Data Access

When implementing data access in this project, we've found that using the Repository
pattern works very well. This pattern abstracts the data layer behind an interface,
making it easy to swap implementations and test in isolation.

The pattern involves creating a repository class for each entity that handles all
database operations. For example, UserRepository would have methods like findById,
create, update, and delete.

This pattern has been used successfully in:
- src/repositories/user.repository.ts
- src/repositories/product.repository.ts

The key benefit is separation of concerns and easier testing.
```

**After** (60 tokens):
```markdown
### Repository Pattern
- Abstract data layer behind interface
- One repository per entity (UserRepository, ProductRepository)
- Methods: findById, create, update, delete
- Used in: src/repositories/
- Benefits: Separation of concerns, easier testing
```

### Example 2: Gotcha Compression

**Before** (150 tokens):
```markdown
### Prisma Transaction Timeout Issue

When using Prisma transactions, be aware that they have a default timeout of 5 seconds.
This can cause issues when performing multiple operations within a transaction,
especially if you're doing things like sending emails or making API calls.

We encountered this issue when trying to create a user, send a welcome email, and
create their initial settings all in one transaction. The email sending caused the
transaction to time out.

The solution is to either use batch operations instead of transactions, or to
increase the timeout if you really need transactions.
```

**After** (40 tokens):
```markdown
### ⚠️ Prisma Transaction Timeout
- Default: 5 seconds
- Problem: External calls (email, API) cause timeout
- Solution: Use batch operations OR increase timeout
- Affected: User creation with email flow
```

### Example 3: Code Example Compression

**Before** (200 tokens):
```typescript
// This is an example of how to set up an Express router with validation
// It demonstrates the pattern we use for all API routes in this project

import { Router } from 'express';
import { body, validationResult } from 'express-validator';
import { UserController } from '../controllers/user.controller';
import { authMiddleware } from '../middleware/auth.middleware';

const router = Router();

// Validation rules for creating a user
const createUserValidation = [
  body('email').isEmail().withMessage('Must be a valid email'),
  body('password').isLength({ min: 8 }).withMessage('Password must be at least 8 characters'),
];

// POST /api/users - Create a new user
router.post('/', createUserValidation, async (req, res) => {
  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    return res.status(400).json({ errors: errors.array() });
  }
  
  const user = await UserController.create(req.body);
  res.status(201).json(user);
});

export default router;
```

**After** (80 tokens):
```typescript
// Express Router Pattern
const router = Router();

const validation = [
  body('email').isEmail(),
  body('password').isLength({ min: 8 }),
];

router.post('/', validation, async (req, res) => {
  const errors = validationResult(req);
  if (!errors.isEmpty()) return res.status(400).json({ errors: errors.array() });
  
  const user = await UserController.create(req.body);
  res.status(201).json(user);
});
```

---

## Output Format

### Optimized Context Package

```yaml
optimized_context:
  metadata:
    original_tokens: 8000
    optimized_tokens: 3500
    compression_ratio: "56%"
    strategy: "balanced"
    
  sections:
    critical_gotchas:
      tokens: 400
      items:
        - "⚠️ Prisma transactions timeout at 5s - use batch ops"
        - "⚠️ Express needs express-async-errors for async routes"
        - "⚠️ JWT secret must be 256+ bits"
        
    patterns_to_use:
      tokens: 1200
      items:
        - "Repository pattern for data access"
        - "Error boundary with AppError class"
        - "Validation middleware chain"
        
    api_reference:
      tokens: 800
      items:
        - "Router: router.METHOD(path, ...handlers)"
        - "JWT: jwt.sign(payload, secret, { expiresIn })"
        - "Prisma: prisma.entity.create({ data })"
        
    code_examples:
      tokens: 1000
      items:
        - "Express router setup with validation"
        - "JWT middleware implementation"
        
    preferences:
      tokens: 100
      items:
        - "Use arrow functions for callbacks"
        - "Prefer named exports"
```

### Ready-for-Injection Format

```markdown
## T-800 INTELLIGENCE PACKAGE
**Task**: Create REST API for user management
**Domain**: Backend
**Complexity**: Medium

---

### ⚠️ CRITICAL GOTCHAS

- **Prisma transactions**: Default 5s timeout - use batch operations for complex flows
- **Express async**: Must import `express-async-errors` at app entry
- **JWT secret**: Must be 256+ bits for HS256 algorithm

---

### ✅ PATTERNS TO USE

**Repository Pattern**
```typescript
// src/repositories/user.repository.ts
export class UserRepository {
  async findById(id: string) { return prisma.user.findUnique({ where: { id } }); }
  async create(data: CreateUserDTO) { return prisma.user.create({ data }); }
}
```

**Router Pattern**
```typescript
router.post('/', validation, async (req, res) => {
  const errors = validationResult(req);
  if (!errors.isEmpty()) return res.status(400).json({ errors });
  // ... handler logic
});
```

---

### 📚 API REFERENCE

| Library | Key APIs |
|---------|----------|
| Express | Router(), app.use(), router.METHOD() |
| JWT | jwt.sign(), jwt.verify() |
| Prisma | prisma.entity.findUnique(), create(), update() |

---

### 💡 PREFERENCES

- Arrow functions for callbacks
- Named exports over default
- Zod for runtime validation

---

*Package: 3,500 tokens | Sources: AGENTS.md, Codebase, Context7*
```

---

## Quality Checks

### Before Optimization

```yaml
checks:
  - name: "Token count reasonable"
    condition: "input_tokens < 20000"
    
  - name: "All sources represented"
    condition: "agents_md + codebase + context7 > 0"
    
  - name: "No duplicate content"
    condition: "unique_content_ratio > 0.9"
```

### After Optimization

```yaml
checks:
  - name: "Budget met"
    condition: "output_tokens <= budget"
    
  - name: "Critical info preserved"
    condition: "gotchas_preserved == gotchas_input"
    
  - name: "Compression reasonable"
    condition: "compression_ratio > 0.3 && compression_ratio < 0.8"
    
  - name: "Structure valid"
    condition: "all_sections_present"
```
