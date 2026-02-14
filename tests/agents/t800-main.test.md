# T-800 Main Agent Tests

## Test Suite: Main T-800 Agent

### Test 1: Agent Configuration
**Description**: Verify main agent configuration is valid
**Steps**:
1. Load `.opencode/agents/t800.md`
2. Verify YAML frontmatter exists
3. Verify required fields: description, mode, model, temperature, tools
4. Verify mode is "primary"
5. Verify all tools are enabled

**Expected**: Configuration loads successfully with all required fields

### Test 2: Agent Description
**Description**: Verify agent description is comprehensive
**Steps**:
1. Load agent file
2. Extract description from frontmatter
3. Verify description mentions "questioning", "planning", "execution"
4. Verify description mentions "non-stop"

**Expected**: Description covers T-800 philosophy

### Test 3: System Prompt Sections
**Description**: Verify system prompt has required sections
**Steps**:
1. Load agent file
2. Verify "THINK" phase exists
3. Verify "QUESTION" phase exists
4. Verify "PLAN" phase exists
5. Verify "EXECUTE" phase exists

**Expected**: All four phases are documented

### Test 4: Philosophy Statement
**Description**: Verify core philosophy is present
**Steps**:
1. Load agent file
2. Search for "Better to ask 100 questions"
3. Verify philosophy is stated

**Expected**: Core philosophy is present

### Test 5: Success Criteria
**Description**: Verify success criteria are defined
**Steps**:
1. Load agent file
2. Search for "Success Criteria" section
3. Verify at least 3 criteria are listed

**Expected**: Success criteria are defined

## Test Summary
- Total Tests: 5
- Status: Ready for validation
