# T-800 Questioner Agent Tests

## Test Suite: Questioner Agent

### Test 1: Questioner Configuration
**Description**: Verify questioner agent configuration
**Steps**:
1. Load `.opencode/agents/t800-questioner.md`
2. Verify mode is "subagent"
3. Verify temperature is 0.2 or lower
4. Verify question tool is enabled

**Expected**: Questioner is configured for focused questioning

### Test 2: Questioning Framework
**Description**: Verify questioning framework is complete
**Steps**:
1. Load agent file
2. Verify 7 phases exist (Scope, Technical, Features, Security, UX, Testing, Deployment)
3. Verify each phase has questions

**Expected**: Complete questioning framework with all phases

### Test 3: Output Format
**Description**: Verify output format is defined
**Steps**:
1. Load agent file
2. Verify "Questioning Summary" section exists
3. Verify output format includes clarifications, assumptions, questions

**Expected**: Clear output format for summarizing questions

### Test 4: Escalation Trigger
**Description**: Verify escalation criteria
**Steps**:
1. Load agent file
2. Search for escalation instructions
3. Verify it mentions transitioning to planner

**Expected**: Clear escalation criteria to t800-planner
