# Task Classifier Module

```
 ████████╗ █████╗ ███████╗ ██████╗ ██╗    ██╗██╗███╗   ██╗
 ╚══██╔══╝██╔══██╗██╔════╝██╔═══██╗██║    ██║██║████╗  ██║
    ██║   ███████║███████╗██║   ██║██║ █╗ ██║██║██╔██╗ ██║
    ██║   ██╔══██║╚════██║██║   ██║██║███╗██║██║██║╚██╗██║
    ██║   ██║  ██║███████║╚██████╔╝╚███╔███╔╝██║██║ ╚████║
    ╚═╝   ╚═╝  ╚═╝╚══════╝ ╚═════╝  ╚══╝╚══╝ ╚═╝╚═╝  ╚═══╝
                                                        
TASK CLASSIFICATION ENGINE
```

## Purpose

Analyze incoming tasks to determine:
- **Type** - What kind of work is needed
- **Domain** - What area of expertise
- **Complexity** - How difficult/involved
- **Dependencies** - What libraries/frameworks involved

---

## Classification Categories

### Task Types

```yaml
CODE_GEN:
  description: "Generate new code from scratch"
  indicators:
    - "create", "build", "implement", "develop"
    - "add feature", "new endpoint", "new component"
  complexity_range: [medium, complex]
  examples:
    - "Create a REST API for user management"
    - "Build a login form with validation"
    - "Implement a caching layer"

CODE_MOD:
  description: "Modify existing code"
  indicators:
    - "update", "modify", "change", "refactor"
    - "improve", "optimize", "enhance"
  complexity_range: [simple, medium]
  examples:
    - "Update the user model to include avatar"
    - "Refactor the authentication logic"
    - "Optimize the database queries"

DEBUG:
  description: "Find and fix bugs"
  indicators:
    - "bug", "error", "not working", "broken"
    - "fix", "crash", "exception", "fails"
  complexity_range: [simple, complex]
  examples:
    - "Fix the login error on production"
    - "Debug why the API returns 500"
    - "The form validation is not working"

RESEARCH:
  description: "Investigate and understand"
  indicators:
    - "how", "why", "understand", "explain"
    - "find", "search", "investigate", "analyze"
  complexity_range: [simple, medium]
  examples:
    - "How does the authentication flow work?"
    - "Find where the API key is validated"
    - "Analyze the database query performance"

DESIGN:
  description: "Architecture and planning"
  indicators:
    - "design", "architecture", "structure", "plan"
    - "organize", "schema", "system design"
  complexity_range: [complex, epic]
  examples:
    - "Design the microservices architecture"
    - "Plan the database schema for multi-tenancy"
    - "Structure the frontend component hierarchy"

TEST:
  description: "Write or fix tests"
  indicators:
    - "test", "spec", "coverage", "unit test"
    - "integration test", "e2e", "mock"
  complexity_range: [simple, medium]
  examples:
    - "Add unit tests for the user service"
    - "Fix the failing integration tests"
    - "Increase test coverage to 80%"

DEPLOY:
  description: "Deployment and infrastructure"
  indicators:
    - "deploy", "ci/cd", "pipeline", "release"
    - "docker", "kubernetes", "infrastructure"
  complexity_range: [medium, complex]
  examples:
    - "Set up CI/CD pipeline"
    - "Deploy to production"
    - "Configure Kubernetes deployment"

DOC:
  description: "Documentation tasks"
  indicators:
    - "document", "readme", "comment", "docs"
    - "explain", "guide", "tutorial"
  complexity_range: [trivial, simple]
  examples:
    - "Write README for the project"
    - "Add JSDoc comments to the API"
    - "Update the API documentation"

REVIEW:
  description: "Code review and quality"
  indicators:
    - "review", "audit", "quality", "security"
    - "lint", "standard", "best practice"
  complexity_range: [simple, medium]
  examples:
    - "Review the PR for security issues"
    - "Audit the codebase for best practices"
    - "Check for TypeScript errors"
```

### Domain Classification

```yaml
FRONTEND:
  indicators:
    - "component", "ui", "react", "vue", "angular"
    - "css", "html", "dom", "browser", "responsive"
    - "frontend", "client-side", "spa"
  typical_files:
    - "*.tsx", "*.jsx", "*.vue", "*.css", "*.scss"

BACKEND:
  indicators:
    - "api", "server", "endpoint", "route"
    - "database", "query", "model", "controller"
    - "express", "fastify", "nestjs", "django"
  typical_files:
    - "*.ts", "*.js", "*.py", "*.go", "*.rs"

FULLSTACK:
  indicators:
    - Combined frontend + backend keywords
    - "full-stack", "end-to-end", "monorepo"
  typical_files:
    - Mixed frontend and backend files

DEVOPS:
  indicators:
    - "deploy", "ci/cd", "docker", "kubernetes"
    - "terraform", "ansible", "pipeline", "github actions"
  typical_files:
    - "Dockerfile", "*.yaml", "*.yml", "terraform/*"

DATA:
  indicators:
    - "sql", "database", "schema", "migration"
    - "etl", "pipeline", "analytics", "data"
  typical_files:
    - "*.sql", "*.prisma", "migrations/*"

TESTING:
  indicators:
    - "test", "spec", "mock", "fixture"
  typical_files:
    - "*.test.*", "*.spec.*", "__tests__/*"
```

### Complexity Levels

```yaml
TRIVIAL:
  description: "Single line or minor change"
  tokens_estimate: 500-2000
  time_estimate: "1-5 minutes"
  examples:
    - "Fix a typo"
    - "Update a comment"
    - "Change a constant value"

SIMPLE:
  description: "Single file, clear scope"
  tokens_estimate: 2000-8000
  time_estimate: "5-20 minutes"
  examples:
    - "Add a new function"
    - "Fix a simple bug"
    - "Write a unit test"

MEDIUM:
  description: "Multiple files, moderate scope"
  tokens_estimate: 8000-20000
  time_estimate: "20-60 minutes"
  examples:
    - "Create a new API endpoint"
    - "Implement a feature"
    - "Refactor a module"

COMPLEX:
  description: "Multiple modules, architectural changes"
  tokens_estimate: 20000-50000
  time_estimate: "1-4 hours"
  examples:
    - "Implement authentication system"
    - "Design microservices architecture"
    - "Create a new service from scratch"

EPIC:
  description: "Major feature, system-wide changes"
  tokens_estimate: 50000+
  time_estimate: "4+ hours or multiple sessions"
  examples:
    - "Migrate to new framework"
    - "Complete redesign of system"
    - "Build entire application"
```

---

## Classification Algorithm

### Step 1: Keyword Extraction

```
Input: "Build a REST API for user management with JWT authentication"

Extract Keywords:
  action_verbs: ["build"]
  nouns: ["rest api", "user management", "jwt authentication"]
  tech_terms: ["rest", "api", "jwt"]
  modifiers: ["user management"]
```

### Step 2: Pattern Matching

```
Match against task type patterns:

CODE_GEN:
  ✓ "build" matches action_verb indicator
  ✓ "api" matches backend indicator
  Confidence: 0.85

CODE_MOD:
  ✗ No "update" or "modify" keywords
  Confidence: 0.10

DEBUG:
  ✗ No "bug" or "error" keywords
  Confidence: 0.05

Result: CODE_GEN (0.85 confidence)
```

### Step 3: Domain Detection

```
Match against domain patterns:

BACKEND:
  ✓ "rest api" is strong backend indicator
  ✓ "jwt authentication" is backend pattern
  Confidence: 0.90

FRONTEND:
  ✗ No frontend keywords
  Confidence: 0.05

Result: BACKEND (0.90 confidence)
```

### Step 4: Complexity Estimation

```
Analyze scope indicators:

Features mentioned:
  - REST API (multiple endpoints likely)
  - User management (CRUD operations)
  - JWT authentication (security layer)

Estimated components:
  - User model
  - Auth middleware
  - Multiple API routes
  - JWT utilities

Complexity: MEDIUM (0.75 confidence)
  - Not trivial (multiple components)
  - Not simple (multiple files needed)
  - Not complex (well-defined scope)
  - Not epic (single feature area)
```

### Step 5: Dependency Detection

```
Extract mentioned technologies:
  - REST → Express, Fastify, or similar
  - JWT → jsonwebtoken library
  - User management → Database (PostgreSQL, MongoDB)

Suggested libraries:
  - express (API framework)
  - jsonwebtoken (JWT handling)
  - bcrypt (password hashing)
  - prisma or typeorm (database ORM)
```

---

## Output Format

```yaml
classification:
  task_type: CODE_GEN
  task_type_confidence: 0.85
  
  domain: BACKEND
  domain_confidence: 0.90
  
  complexity: MEDIUM
  complexity_confidence: 0.75
  
  secondary_types:
    - type: DESIGN
      confidence: 0.30
      reason: "API design decisions needed"

dependencies:
  detected:
    - express
    - jsonwebtoken
    - bcrypt
  suggested:
    - prisma
    - zod

estimates:
  tokens: 15000
  time: "30-45 minutes"
  files_needed: 5-8

key_entities:
  - "user management"
  - "authentication"
  - "REST API"

risk_factors:
  - "Security considerations for JWT"
  - "Database schema design needed"
```

---

## Special Cases

### Multi-Type Tasks

When a task spans multiple types:

```yaml
# Input: "Fix the login bug and add 2FA support"

classification:
  primary_type: DEBUG
  secondary_types:
    - CODE_GEN  # Adding 2FA is new code
  
  breakdown:
    - task: "Fix login bug"
      type: DEBUG
      complexity: SIMPLE
    - task: "Add 2FA support"
      type: CODE_GEN
      complexity: MEDIUM
  
  combined_complexity: MEDIUM
  recommended_approach: "Fix bug first, then add feature"
```

### Ambiguous Tasks

When classification is uncertain:

```yaml
# Input: "Work on the user thing"

classification:
  task_type: UNKNOWN
  confidence: 0.30
  
  ambiguity_reason: "No clear action verb or scope"
  
  suggestions:
    - "Create new user feature"
    - "Fix user-related bug"
    - "Update user model"
  
  recommendation: "Ask user for clarification"
```

### Epic Tasks

When task is clearly epic:

```yaml
# Input: "Build a complete e-commerce platform"

classification:
  task_type: CODE_GEN
  complexity: EPIC
  epic_breakdown_needed: true
  
  suggested_phases:
    - phase: "Core architecture"
      tasks: 5
      complexity: COMPLEX
    - phase: "User management"
      tasks: 3
      complexity: MEDIUM
    - phase: "Product catalog"
      tasks: 4
      complexity: MEDIUM
    - phase: "Shopping cart"
      tasks: 3
      complexity: MEDIUM
    - phase: "Checkout & payments"
      tasks: 5
      complexity: COMPLEX
  
  recommendation: "Start with Ralph Loop for multi-session execution"
```

---

## Classification Confidence Thresholds

```yaml
high_confidence: 0.85+
  action: "Proceed with classification"

medium_confidence: 0.60-0.84
  action: "Proceed but note uncertainty"

low_confidence: 0.40-0.59
  action: "Proceed with multiple type consideration"

very_low_confidence: < 0.40
  action: "Flag for clarification"
```
