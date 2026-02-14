# Human-in-the-Loop Pattern

Escalate to humans for critical decisions and oversight.

## Description

The Human-in-the-Loop (HITL) pattern integrates human judgment into autonomous workflows at critical decision points. This ensures safety, quality, and alignment with user intent for high-stakes operations.

**Core Philosophy**: Automate freely, involve humans critically.

## Trigger Conditions (Exactly 5)

### 1. Low Confidence Score

```yaml
trigger: low_confidence
condition: Agent confidence < 70% for critical decision
threshold: 0.70
escalation_level: decision_required
message: "Multiple valid approaches identified. Need your input to proceed."
```

### 2. High Cost Operation

```yaml
trigger: high_cost
condition: Estimated operation cost > $1.00 OR time > 30 minutes
threshold:
  cost_usd: 1.00
  duration_ms: 1800000
escalation_level: warning
message: "This operation will be expensive. Confirm to proceed."
```

### 3. Data Loss Risk

```yaml
trigger: data_loss_risk
condition: Operation could delete or irreversibly modify data
operations:
  - DELETE
  - DROP
  - TRUNCATE
  - OVERWRITE
  - MIGRATION
escalation_level: intervention_required
message: "This operation carries data loss risk. Please confirm intent."
```

### 4. Security Impact

```yaml
trigger: security_impact
condition: Operation affects security-related components
components:
  - authentication
  - authorization
  - encryption
  - credentials
  - permissions
  - firewall rules
escalation_level: intervention_required
message: "Security-sensitive operation detected. Review required."
```

### 5. Ambiguous Intent

```yaml
trigger: ambiguous_intent
condition: Multiple interpretations possible with different outcomes
indicators:
  - Multiple stakeholders with conflicting needs
  - Unclear priority ordering
  - Contradictory requirements
  - Vague specifications
escalation_level: decision_required
message: "Request could be interpreted multiple ways. Need clarification."
```

## Workflow

```
Execute normally
       ↓
┌──────────────────┐
│ Trigger Check    │
└──────────────────┘
       ↓ Triggered
[Pause Execution]
       ↓
[Generate Escalation Message]
       ↓
[Present Options to User]
       ↓
┌──────────────────┐
│ Wait for Response│ (timeout: 5 minutes)
└──────────────────┘
       ↓
┌──────────────────────────┐
│ User Response?           │
└──────────────────────────┘
    ↓ Yes            ↓ No (timeout)
[Apply User Choice]  [Apply Default]
       ↓                  ↓
[Resume Execution]  [Resume/Abort]
```

## Implementation in T-800

```yaml
hitl_in_t800:
  integration_points:
    THINK_phase:
      - Check ambiguous intent
      - Check low confidence
      
    PLAN_phase:
      - Check data loss risk
      - Check security impact
      - Request approval for plan
      
    EXECUTE_phase:
      - Check high cost
      - Check data loss before destructive ops
      - Check security before auth changes
      
  escalation_flow:
    1. Pause current operation
    2. Log escalation reason
    3. Present clear options
    4. Set timeout timer
    5. Wait for response
    6. Apply decision
    7. Log resolution
    8. Resume or terminate
```

## Escalation Message Format

```markdown
## ⚠️ Human Attention Required

**Trigger**: {trigger_name}
**Severity**: {level}
**Context**: {what_was_being_done}

### What Happened
{description_of_situation}

### Why I'm Asking
{rationale_for_escalation}

### Your Options
1. **Proceed** [Recommended]
   - {what_proceeding_means}
   - Risk: {risk_if_any}
   
2. **Modify**
   - {how_to_modify}
   
3. **Abort**
   - {what_happens_if_aborted}

### Default if No Response
In {timeout_minutes} minutes, I will: {default_action}

### To Respond
Reply with option number (1, 2, or 3) or describe your preference.
```

## Examples

### Example 1: Low Confidence - Architecture Decision

```markdown
## ⚠️ Human Attention Required

**Trigger**: Low Confidence
**Severity**: Decision Required
**Context**: Designing authentication system architecture

### What Happened
Two valid authentication architectures can meet your requirements:
- **Option A**: Session-based (simpler, stateful)
- **Option B**: JWT-based (stateless, more complex)

Both would work. I need to know your preference.

### Why I'm Asking
Confidence in either choice is 60%. Your future scaling plans affect which is better.

### Your Options
1. **JWT-based (stateless)** [Recommended]
   - Better for horizontal scaling
   - Works well with microservices
   - Risk: Slightly more complex initially
   
2. **Session-based (stateful)**
   - Simpler to implement
   - Easier to revoke sessions
   - Risk: May need migration if scaling later
   
3. **Let me explain more**
   - I'll ask clarifying questions about your scaling plans

### Default if No Response
In 5 minutes, I will: Proceed with Option 1 (JWT-based)

### To Respond
Reply with option number (1, 2, or 3) or describe your preference.
```

### Example 2: Data Loss Risk - Migration

```markdown
## ⚠️ Human Attention Required

**Trigger**: Data Loss Risk
**Severity**: Intervention Required
**Context**: About to execute database schema migration

### What Happened
Migration will:
- DROP column `temp_data` (2,341 rows affected)
- Change `user_id` from INT to UUID (breaks existing foreign keys)

### Why I'm Asking
This migration has irreversible data changes. The `temp_data` column removal is permanent.

### Your Options
1. **Proceed with migration**
   - Complete migration as designed
   - Risk: 2,341 rows will lose `temp_data` column values permanently
   
2. **Backup first, then migrate**
   - Create backup of affected data
   - Then proceed with migration
   - Risk: Adds 5 minutes to operation
   
3. **Abort migration**
   - Stop and review migration script
   - No changes made

### Default if No Response
In 5 minutes, I will: **NOT proceed automatically** - wait indefinitely for response

### To Respond
Reply with option number (1, 2, or 3) or describe your preference.
```

### Example 3: Security Impact - Permission Change

```markdown
## ⚠️ Human Attention Required

**Trigger**: Security Impact
**Severity**: Intervention Required
**Context**: Modifying API endpoint permissions

### What Happened
About to change `/api/admin/users` endpoint:
- Current: Requires `admin` role
- Proposed: Requires `manager` role OR `admin` role

### Why I'm Asking
This expands access to sensitive user management API from 5 users (admins) to 23 users (managers).

### Your Options
1. **Proceed with change**
   - Managers will gain user management access
   - Risk: Increased attack surface
   
2. **Restrict further**
   - Keep admin-only
   - Create separate limited endpoint for managers instead
   
3. **Audit first**
   - Review which managers need this access
   - Proceed after audit confirmation

### Default if No Response
In 5 minutes, I will: **NOT proceed** - security changes require explicit approval

### To Respond
Reply with option number (1, 2, or 3) or describe your preference.
```

### Example 4: High Cost - Long Operation

```markdown
## ⚠️ Human Attention Required

**Trigger**: High Cost
**Severity**: Warning
**Context**: Running comprehensive codebase analysis

### What Happened
Analysis will:
- Process 47,000 files
- Make ~500 LLM calls
- Estimated cost: $2.50
- Estimated time: 45 minutes

### Why I'm Asking
This exceeds the cost threshold ($1.00). Want to confirm you want full analysis.

### Your Options
1. **Proceed with full analysis**
   - Complete comprehensive review
   - Cost: ~$2.50, Time: ~45 min
   
2. **Reduce scope**
   - Analyze only modified files
   - Cost: ~$0.50, Time: ~10 min
   
3. **Skip**
   - Cancel analysis
   - Proceed without review

### Default if No Response
In 5 minutes, I will: Proceed with Option 2 (reduced scope)

### To Respond
Reply with option number (1, 2, or 3) or describe your preference.
```

### Example 5: Ambiguous Intent - Conflicting Requirements

```markdown
## ⚠️ Human Attention Required

**Trigger**: Ambiguous Intent
**Severity**: Decision Required
**Context**: Implementing search functionality

### What Happened
Your request mentions:
- "Fast search" (suggests simple indexing)
- "Advanced search with filters" (suggests complex query engine)
- "Real-time results" (suggests specific architecture)

These could conflict depending on implementation depth.

### Why I'm Asking
Each interpretation leads to different architectures. Need to clarify priority.

### Your Options
1. **Fast + Simple**
   - Quick to implement
   - Basic search only
   - ~2 hours
   
2. **Advanced + Powerful**
   - Full-featured search
   - Complex but capable
   - ~8 hours
   
3. **Balanced**
   - Core search fast
   - Add advanced features incrementally
   - ~4 hours for MVP

### Default if No Response
In 5 minutes, I will: Proceed with Option 3 (balanced approach)

### To Respond
Reply with option number (1, 2, or 3) or describe your preference.
```

## Integration with Escalation Manager

The HITL pattern feeds directly into the escalation manager:

```yaml
escalation_mapping:
  low_confidence:
    level: 3 (decision_required)
    timeout_default: apply_recommended
    
  high_cost:
    level: 2 (warning)
    timeout_default: use_reduced_scope
    
  data_loss_risk:
    level: 4 (intervention_required)
    timeout_default: wait_indefinitely
    
  security_impact:
    level: 4 (intervention_required)
    timeout_default: abort_operation
    
  ambiguous_intent:
    level: 3 (decision_required)
    timeout_default: apply_balanced_approach
```

## Configuration

```yaml
human_in_loop:
  enabled: true
  
  triggers:
    low_confidence_threshold: 0.70
    high_cost_threshold_usd: 1.00
    high_duration_threshold_ms: 1800000
    
  timeout:
    default_ms: 300000
    critical_ms: 0  # Wait indefinitely for critical
    
  defaults:
    data_loss_risk: wait  # Never auto-proceed
    security_impact: abort  # Never auto-proceed
    high_cost: reduced_scope
    low_confidence: apply_recommended
    ambiguous_intent: apply_balanced
```