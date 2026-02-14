# T-800 Workflow Integration Tests

## Test Suite: End-to-End Workflow

### Test 1: Full Questioning Flow
**Description**: Verify questioning workflow completes
**Steps**:
1. Provide sample project request
2. Verify questioner generates questions
3. Verify questions cover all phases
4. Verify output format is correct

**Expected**: Questioning produces structured summary

### Test 2: Full Planning Flow
**Description**: Verify planning workflow completes
**Steps**:
1. Provide sample clarified requirements
2. Verify planner generates plan
3. Verify plan has all required sections
4. Verify tasks are defined

**Expected**: Planning produces complete plan

### Test 3: Agent Transition
**Description**: Verify agents can escalate
**Steps**:
1. Questioner completes questioning
2. Verify transition to planner
3. Planner completes planning
4. Verify transition to executor

**Expected**: Smooth transitions between agents

### Test 4: Context Loading
**Description**: Verify context files load correctly
**Steps**:
1. Verify t800-standards.md is accessible
2. Verify t800-workflows.md is accessible
3. Verify questioning-strategies.md is accessible
4. Verify planning-templates.md is accessible

**Expected**: All context files are loadable

### Test 5: Skills Integration
**Description**: Verify skills are available
**Steps**:
1. Verify t800-questioning skill exists
2. Verify t800-planning skill exists
3. Verify t800-execution skill exists

**Expected**: All skills are available
