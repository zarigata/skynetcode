# ReAct Pattern (Reason + Act)

Interleaved reasoning and action pattern for dynamic environments.

## Description

ReAct combines reasoning traces with action execution in an interleaved manner. After each action, the agent observes the result and uses that observation to inform the next reasoning step.

**Core Philosophy**: Think, Act, Observe, Repeat.

## Workflow

```
┌─────────────┐
│   REASON    │ ← Analyze current state and decide next action
└──────┬──────┘
       ↓
┌─────────────┐
│    ACT      │ ← Execute the decided action
└──────┬──────┘
       ↓
┌─────────────┐
│   OBSERVE   │ ← Capture results and feedback
└──────┬──────┘
       ↓
   [Repeat until done]
```

## When to Use

| Scenario | Appropriate? | Reason |
|----------|--------------|--------|
| Dynamic environments | ✅ Yes | Conditions change after each action |
| Unknown outcomes | ✅ Yes | Need to observe results before deciding |
| Exploratory tasks | ✅ Yes | Discover requirements through action |
| Predictable workflows | ❌ No | Overhead of observation not needed |
| Simple linear tasks | ❌ No | Can plan completely upfront |

## Implementation in T-800

```yaml
react_in_t800:
  phase_integration:
    THINK: "Initial reasoning about approach"
    QUESTION: "Clarify uncertainties (first Reason)"
    PLAN: "Not applicable - ReAct plans dynamically"
    EXECUTE: "Repeated Act-Observe cycles"
    
  triggers:
    - User request involves exploration
    - Environment state unknown
    - Interdependencies between actions
    
  configuration:
    max_iterations: 20
    observation_timeout_ms: 30000
    reasoning_depth: 2
```

## Examples

### Example 1: Debugging Unknown Issue

```markdown
**User**: "Fix the login timeout issue"

[REASON]
The user reports login timeouts. I need to investigate the cause.
Possible causes: database connection, authentication service, session management.
I'll start by checking the authentication service logs.

[ACT]
Read auth service logs at /var/log/auth.log

[OBSERVE]
Found: Multiple "connection refused" errors to database host at 10.0.0.5:5432
Errors correlate with timeout timestamps.

[REASON]
The database connection is failing. This explains the timeouts.
Possible causes: database down, network issue, credentials expired.
I'll check if the database is reachable.

[ACT]
Bash: ping -c 3 10.0.0.5

[OBSERVE]
Ping successful - database host is reachable.
But connection refused suggests PostgreSQL not listening.

[REASON]
The host is up but PostgreSQL not accepting connections.
Could be: service stopped, wrong port, firewall blocking.
I'll check PostgreSQL service status.

[ACT]
Bash: ssh 10.0.0.5 "systemctl status postgresql"

[OBSERVE]
PostgreSQL is inactive (dead). Service stopped.

[REASON]
Root cause found: PostgreSQL service stopped.
Fix: Start the service and ensure it restarts automatically.

[ACT]
Bash: ssh 10.0.0.5 "systemctl start postgresql && systemctl enable postgresql"

[OBSERVE]
PostgreSQL started successfully and enabled for auto-start.

[FINAL ANSWER]
Root cause: PostgreSQL service was stopped.
Resolution: Started PostgreSQL and enabled auto-start on boot.
Verified service is now running and accepting connections.
```

### Example 2: Feature Discovery

```markdown
**User**: "Add export functionality to the app"

[REASON]
User wants export functionality. I need to understand what kind of export:
- Data format (CSV, JSON, PDF, Excel?)
- What data to export
- Where exports should be saved
- Who can access exports

[ACT]
Search existing codebase for any export-related code:
Grep: "export" in src/

[OBSERVE]
Found:
- Partial export in src/utils/pdf-export.ts (PDF only)
- Comment: "// TODO: add CSV export"
- Export button exists in UI but not wired

[REASON]
Partial implementation exists. PDF export works, CSV needed.
Need to understand what data the existing export handles.

[ACT]
Read: src/utils/pdf-export.ts

[OBSERVE]
PDF export handles user reports.
Expects data array with { name, email, role, lastActive } structure.

[REASON]
The export is for user data. CSV export would use same data structure.
I need to confirm with user if this is the expected export.

[ACT]
Question user: "Found existing PDF export for user data. Should CSV export the same user data, or different data?"

[OBSERVE]
User response: "Same user data is fine. Also add a date filter if possible."

[REASON]
Requirements clarified:
- CSV export same user data
- Add date filter for lastActive field
- Build on existing export infrastructure

[FINAL ANSWER]
Plan confirmed:
- Create src/utils/csv-export.ts
- Add date filter to export UI
- Wire export button to both PDF and CSV
```

### Example 3: Integration Discovery

```markdown
**User**: "Connect the app to our CRM"

[REASON]
User wants CRM integration. I need to identify:
- Which CRM system
- What data to sync
- API availability

[ACT]
Question: "Which CRM system are you using?"

[OBSERVE]
User response: "Salesforce"

[REASON]
Salesforce integration needed. Check if API credentials exist.

[ACT]
Grep: "salesforce\|sfdc\|SF_" in .env, config files

[OBSERVE]
Found in .env.example:
- SF_CLIENT_ID=your_client_id
- SF_CLIENT_SECRET=your_client_secret
- SF_USERNAME=your_username
- SF_PASSWORD=your_password

[REASON]
Salesforce configuration expected but not set up.
Need actual credentials.

[ACT]
Question: "I see Salesforce config placeholders. Do you have the credentials ready?"

[OBSERVE]
User response: "Yes, I'll provide them. What access level do you need?"

[REASON]
Need to determine minimum required access.
Depends on what data to sync.

[ACT]
Question: "What data should sync between app and Salesforce?"

[OBSERVE]
User response: "User signups should create Leads in Salesforce"

[REASON]
One-way sync: App users → Salesforce Leads.
Need Leads object create permission.

[FINAL ANSWER]
Integration scope:
- Direction: App → Salesforce
- Object: Create Leads
- Trigger: User signup
- Required: API credentials with Leads create permission
```

## Anti-Patterns

### Over-Observing

❌ **Bad**: Observe after every trivial action
```markdown
[ACT] Change variable name from 'x' to 'count'
[OBSERVE] Variable renamed successfully
[REASON] Success, continue to next action
```

✅ **Good**: Observe only meaningful checkpoints
```markdown
[ACT] Rename variable 'x' to 'count', run tests, verify lint passes
[OBSERVE] All tests pass, no lint errors, name more descriptive
[REASON] Refactoring successful, continue with next feature
```

### Under-Reasoning

❌ **Bad**: Act without thinking
```markdown
[ACT] Delete all node_modules folders
[OBSERVE] Application broken, dependencies missing
```

✅ **Good**: Reason before acting
```markdown
[REASON] Disk space critical. Need to clean node_modules.
Risk: Will need to reinstall dependencies.
Plan: Delete node_modules, run npm install after.

[ACT] rm -rf node_modules && npm install
[OBSERVE] Dependencies reinstalled, disk space freed
```

## Configuration

```yaml
react_pattern:
  enabled: true
  
  iteration_limits:
    max_cycles: 20
    timeout_total_ms: 300000
    
  observation_settings:
    capture_output: true
    capture_errors: true
    capture_metrics: true
    
  reasoning_settings:
    depth_limit: 3
    allow_backtracking: true
```