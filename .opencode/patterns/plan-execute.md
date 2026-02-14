# Plan-and-Execute Pattern

Complete planning followed by sequential execution.

## Description

Plan-and-Execute divides work into two distinct phases: first create a complete plan, then execute all steps sequentially without modification. This pattern is ideal when the environment is predictable and all requirements are known upfront.

**Core Philosophy**: Plan carefully, execute confidently.

## Workflow

```
Phase 1: PLAN ALL
┌─────────────────────────────────────────────┐
│ 1. Gather all requirements                   │
│ 2. Design complete solution                  │
│ 3. Break into ordered steps                  │
│ 4. Review plan with user                     │
│ 5. Get approval to proceed                   │
└─────────────────────────────────────────────┘
                    ↓
Phase 2: EXECUTE ALL
┌─────────────────────────────────────────────┐
│ Step 1 → Step 2 → Step 3 → ... → Step N     │
└─────────────────────────────────────────────┘
                    ↓
Phase 3: VERIFY
┌─────────────────────────────────────────────┐
│ Validate all acceptance criteria met         │
│ Run tests, lint, type checks                 │
│ Report completion                            │
└─────────────────────────────────────────────┘
```

## When to Use

| Scenario | Appropriate? | Reason |
|----------|--------------|--------|
| Predictable environment | ✅ Yes | No surprises during execution |
| Clear requirements | ✅ Yes | Can plan completely upfront |
| Complex multi-step tasks | ✅ Yes | Benefits from thorough planning |
| User approval needed | ✅ Yes | Natural checkpoint for review |
| Dynamic environment | ❌ No | Plan will become outdated |
| Unknown requirements | ❌ No | Cannot plan without complete info |

## Implementation in T-800

```yaml
plan_execute_in_t800:
  phase_integration:
    THINK: "Initial analysis and scope determination"
    QUESTION: "Gather all requirements exhaustively"
    PLAN: "Create complete, ordered execution plan"
    EXECUTE: "Sequential execution without modification"
    
  triggers:
    - User requests detailed plan review
    - Task has clear, stable requirements
    - Multiple sequential dependencies
    - High-stakes operations needing approval
    
  configuration:
    require_user_approval: true
    allow_plan_revision: false  # During execution
    checkpoint_between_steps: false
```

## Examples

### Example 1: API Implementation

```markdown
**User**: "Build a REST API for task management"

## Phase 1: PLAN ALL

### Requirements Gathered
- Resource: Tasks (CRUD operations)
- Fields: id, title, description, status, due_date, created_at
- Endpoints: GET /tasks, POST /tasks, GET /tasks/:id, PUT /tasks/:id, DELETE /tasks/:id
- Authentication: JWT required
- Database: PostgreSQL
- Framework: Express.js with TypeScript

### Execution Plan

**Step 1: Project Setup**
- Create project structure
- Install dependencies: express, typescript, pg, jsonwebtoken
- Configure TypeScript

**Step 2: Database Setup**
- Create tasks table migration
- Define Task model interface
- Set up database connection

**Step 3: Authentication Middleware**
- Implement JWT verification
- Create auth middleware

**Step 4: Routes Implementation**
- GET /tasks - List all tasks
- POST /tasks - Create task
- GET /tasks/:id - Get single task
- PUT /tasks/:id - Update task
- DELETE /tasks/:id - Delete task

**Step 5: Error Handling**
- Add error middleware
- Define error responses

**Step 6: Testing**
- Write unit tests for routes
- Write integration tests

**Step 7: Documentation**
- Document API endpoints
- Add OpenAPI spec

### User Approval Requested
> This plan creates a complete REST API for task management with 7 sequential steps. Estimated time: 2 hours.
> 
> Proceed with execution?

[User: "Proceed"]

## Phase 2: EXECUTE ALL

**Executing Step 1: Project Setup**
[Create structure, install deps, config TS]
✓ Complete

**Executing Step 2: Database Setup**
[Create migration, model, connection]
✓ Complete

**Executing Step 3: Authentication Middleware**
[JWT verification, middleware]
✓ Complete

**Executing Step 4: Routes Implementation**
[All 5 routes implemented]
✓ Complete

**Executing Step 5: Error Handling**
[Middleware and responses]
✓ Complete

**Executing Step 6: Testing**
[Unit and integration tests]
✓ Complete

**Executing Step 7: Documentation**
[API docs and OpenAPI]
✓ Complete

## Phase 3: VERIFY

**Running validation:**
- ✓ TypeScript compiles without errors
- ✓ All 15 tests pass
- ✓ Lint clean
- ✓ API responds correctly to test requests
- ✓ Authentication working

**Result: Complete**
Task management REST API ready at http://localhost:3000/api/tasks
```

### Example 2: Database Migration

```markdown
**User**: "Migrate user data from MySQL to PostgreSQL"

## Phase 1: PLAN ALL

### Requirements Gathered
- Source: MySQL database (users table)
- Target: PostgreSQL database (users table)
- Data volume: ~50,000 records
- Downtime: Maximum 30 minutes allowed
- Preserve: All data, relationships, timestamps

### Execution Plan

**Step 1: Schema Analysis**
- Export MySQL schema
- Convert to PostgreSQL schema
- Identify type differences

**Step 2: Target Setup**
- Create PostgreSQL database
- Create users table with converted schema
- Create indexes

**Step 3: Data Validation**
- Check MySQL data integrity
- Identify any NULL or malformed values
- Document exceptions

**Step 4: Export Strategy**
- Choose export format (CSV)
- Configure chunking (5000 records per chunk)
- Parallel export setup

**Step 5: Import Strategy**
- Configure PostgreSQL COPY command
- Set up transaction boundaries
- Prepare rollback plan

**Step 6: Execute Migration**
- Put application in maintenance mode
- Export from MySQL
- Import to PostgreSQL
- Verify counts match

**Step 7: Validation**
- Run data integrity checks
- Test application connectivity
- Compare record counts

**Step 8: Cutover**
- Switch application to PostgreSQL
- Remove maintenance mode
- Monitor for issues

### User Approval Requested
> This plan migrates 50,000 user records with 8 sequential steps. Estimated downtime: 15 minutes.
> Maximum risk: Data mismatch requiring rollback.
> 
> Proceed with execution?

[User: "Proceed, but confirm before Step 6"]

## Phase 2: EXECUTE ALL

**Executing Step 1: Schema Analysis**
[Analyzed, converted, documented differences]
✓ Complete

**Executing Step 2: Target Setup**
[PG database created, schema applied, indexes built]
✓ Complete

**Executing Step 3: Data Validation**
[Integrity checked, 3 malformed emails found and fixed]
✓ Complete

**Executing Step 4: Export Strategy**
[CSV format, 5000-chunk size, parallel workers configured]
✓ Complete

**Executing Step 5: Import Strategy**
[COPY configured, transactions set, rollback tested]
✓ Complete

**⏸️ CHECKPOINT: User confirmation requested before Step 6**
> Export and import strategies are ready. MySQL has 50,003 valid records.
> Ready to execute migration with ~15 min downtime.
> Confirm to proceed?

[User: "Confirmed, proceed"]

**Executing Step 6: Execute Migration**
[Maintenance mode on]
[Exporting... 50,003 records exported]
[Importing... 50,003 records imported]
[Count match: ✓]
✓ Complete

**Executing Step 7: Validation**
[Integrity checks passed]
[App connectivity tested]
[Record counts match: 50,003 = 50,003]
✓ Complete

**Executing Step 8: Cutover**
[App switched to PostgreSQL]
[Maintenance mode off]
[Monitoring: No errors in first 5 minutes]
✓ Complete

## Phase 3: VERIFY

**Running validation:**
- ✓ 50,003 records migrated successfully
- ✓ Application running on PostgreSQL
- ✓ No data loss detected
- ✓ Downtime: 14 minutes 32 seconds

**Result: Complete**
User data successfully migrated to PostgreSQL.
```

### Example 3: Feature Implementation

```markdown
**User**: "Add two-factor authentication to the login flow"

## Phase 1: PLAN ALL

### Requirements Gathered
- Method: TOTP (Time-based One-Time Password)
- Provider: User can use any authenticator app
- Enrollment: Step-by-step guided process
- Backup codes: Generate 10 single-use codes
- Enforcement: Optional per user, mandatory for admins
- QR code generation for easy setup

### Execution Plan

**Step 1: Dependencies**
- Install speakeasy (TOTP library)
- Install qrcode (QR generation)
- Add types

**Step 2: Database Changes**
- Add two_factor_enabled column to users
- Add two_factor_secret column (encrypted)
- Add backup_codes column (hashed array)
- Create migration

**Step 3: TOTP Service**
- Create secret generation function
- Create token verification function
- Create backup code functions

**Step 4: Enrollment Flow**
- GET /auth/2fa/setup - Return QR code
- POST /auth/2fa/verify - Verify initial setup
- POST /auth/2fa/enable - Enable 2FA

**Step 5: Login Flow Modification**
- Add 2FA code input step
- Integrate verification into auth middleware
- Handle backup code flow

**Step 6: Backup Codes**
- Generate 10 codes on enrollment
- Hash and store securely
- Invalidate on use

**Step 7: Frontend Changes**
- Add 2FA setup page
- Add code input to login
- Show backup codes with download option

**Step 8: Testing**
- Unit tests for TOTP service
- Integration tests for enrollment
- E2E test for complete flow

### User Approval Requested
> This plan adds TOTP-based 2FA with 8 sequential steps. Estimated time: 3 hours.
> Security libraries used: speakeasy, qrcode.
> 
> Proceed with execution?

[User: "Proceed"]

## Phase 2: EXECUTE ALL

**Executing Step 1: Dependencies**
[speakeasy, qrcode installed, types added]
✓ Complete

**Executing Step 2: Database Changes**
[Migration created and applied]
✓ Complete

**Executing Step 3: TOTP Service**
[All functions implemented]
✓ Complete

**Executing Step 4: Enrollment Flow**
[3 endpoints created]
✓ Complete

**Executing Step 5: Login Flow Modification**
[2FA step integrated]
✓ Complete

**Executing Step 6: Backup Codes**
[Generation and validation complete]
✓ Complete

**Executing Step 7: Frontend Changes**
[Setup page, login input, backup display]
✓ Complete

**Executing Step 8: Testing**
[12 tests written and passing]
✓ Complete

## Phase 3: VERIFY

**Running validation:**
- ✓ All 12 tests pass
- ✓ Enrollment flow works end-to-end
- ✓ Login with 2FA works
- ✓ Backup codes work
- ✓ No regressions in existing login

**Result: Complete**
Two-factor authentication successfully implemented.
```

## Anti-Patterns

### Over-Planning

❌ **Bad**: Planning trivial operations
```markdown
Step 1: Create file
Step 2: Write "Hello World"
Step 3: Save file
Step 4: Verify file created
```

✅ **Good**: Plan meaningful chunks
```markdown
Step 1: Create application entry point with Hello World
```

### Inflexible Execution

❌ **Bad**: Ignore critical errors discovered during execution
```markdown
Step 3: Run database migrations
[Error: Table already exists]
[Continuing to Step 4...]  ← WRONG
```

✅ **Good**: Escalate when plan assumptions broken
```markdown
Step 3: Run database migrations
[Error: Table already exists]
[⏸️ STOP: Plan assumed fresh database. Escalating to user.]
```

## Configuration

```yaml
plan_execute_pattern:
  enabled: true
  
  planning_phase:
    max_plan_steps: 50
    require_approval: true
    show_estimated_time: true
    
  execution_phase:
    stop_on_error: true
    log_progress: true
    allow_skip: false
    
  verification_phase:
    run_tests: true
    run_lint: true
    run_typecheck: true
```