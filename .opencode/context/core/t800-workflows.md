# T-800 Workflows

## Overview
Standard workflows for T-800 agent system.

## Workflow 1: New Feature Development

### Step 1: Requirements Gathering (t800-questioner)
- Input: User's initial request
- Output: Clarified requirements document
- Duration: ~5-10 questions

### Step 2: Planning (t800-planner)
- Input: Clarified requirements
- Output: Complete implementation plan
- Duration: One comprehensive plan

### Step 3: Approval Gate
- Input: Implementation plan
- Output: User approval
- REQUIRED: User must approve before execution

### Step 4: Execution (t800-executor)
- Input: Approved plan
- Output: Complete implementation
- Duration: Non-stop until complete

### Step 5: Validation
- Input: Implementation
- Output: Test results, verification
- REQUIRED: All tests pass

## Workflow 2: Bug Fix

### Step 1: Bug Analysis (t800-questioner)
- Question: "What is the bug?"
- Question: "How to reproduce?"
- Question: "Expected vs actual behavior?"
- Question: "When did it start?"

### Step 2: Root Cause Analysis (t800-planner)
- Analyze code
- Identify root cause
- Plan fix
- Plan prevention

### Step 3: Fix Implementation (t800-executor)
- Implement fix
- Add regression test
- Verify fix

## Workflow 3: Refactoring

### Step 1: Scope Definition (t800-questioner)
- Question: "What are we refactoring?"
- Question: "What is the goal?"
- Question: "What constraints exist?"
- Question: "What must not change?"

### Step 2: Refactoring Plan (t800-planner)
- Identify all affected files
- Plan incremental changes
- Define verification strategy
- Set rollback plan

### Step 3: Incremental Execution (t800-executor)
- Execute one change at a time
- Test after each change
- Document all changes

## Error Handling Workflow

When errors occur during execution:
1. LOG: Record the error
2. ANALYZE: Determine root cause
3. FIX: Implement solution
4. VERIFY: Test the fix
5. DOCUMENT: Update docs
6. CONTINUE: Resume execution

## Rollback Workflow

When execution fails critically:
1. STOP: Halt execution
2. ASSESS: Determine failure scope
3. ROLLBACK: Revert to last known good state
4. REPORT: Document what went wrong
5. PLAN: Create new approach
6. RETRY: Execute new plan
