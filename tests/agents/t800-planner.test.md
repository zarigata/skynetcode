# T-800 Planner Agent Tests

## Test Suite: Planner Agent

### Test 1: Planner Configuration
**Description**: Verify planner agent configuration
**Steps**:
1. Load `.opencode/agents/t800-planner.md`
2. Verify mode is "subagent"
3. Verify temperature is 0.3 or lower
4. Verify write tools are disabled (read-only planning)

**Expected**: Planner is configured for focused planning

### Test 2: Planning Framework
**Description**: Verify planning framework is complete
**Steps**:
1. Load agent file
2. Verify 4 phases exist (Requirements, Architecture, Implementation, Quality)
3. Verify plan template is defined

**Expected**: Complete planning framework

### Test 3: Plan Template
**Description**: Verify plan template structure
**Steps**:
1. Load agent file
2. Verify plan template has: Executive Summary, Requirements, Architecture, Tasks, Testing, Criteria

**Expected**: Complete plan template

### Test 4: Escalation Trigger
**Description**: Verify escalation criteria
**Steps**:
1. Load agent file
2. Search for escalation instructions
3. Verify it mentions transitioning to executor

**Expected**: Clear escalation criteria to t800-executor
