# Plan: T-800 Comprehensive Agent System

## TL;DR

> **Quick Summary**: Design and implement T-800, a specialized OpenCode agent that embodies the philosophy of "think before you build" - analyzing all possible user request variants, asking comprehensive questions to eliminate ambiguity, creating exhaustive project plans, and executing continuously from plan approval through full implementation.
> 
> **Deliverables**:
> - Agent configuration file (`.opencode/agents/t800.md`) with comprehensive system prompt
> - Agent operation documentation in the plan file
> - Example workflows and usage patterns
> 
> **Estimated Effort**: Short
> **Parallel Execution**: YES - No dependencies, single file creation
> **Critical Path**: None - Single deliverable file

---

## Context

### Original Request

The user wants me to create a new agent called T-800 based on research of how OpenCode works and how agents function. The T-800 agent should:
1. Receive user project descriptions
2. Think about all variants the user did NOT say
3. Question thoroughly to make the project FULL and VERY described
4. Show all the plan to the person
5. If approved, NON-STOP code the project

### Interview Summary

**Key Discussions**:
- T-800 is a **primary agent** mode agent (can be user's main assistant)
- Agent should emphasize **comprehensive analysis** and **questioning** before building
- Focus on **eliminating all ambiguity** before implementation
- Plans must be **exhaustive** with complete details
- Execution should be **continuous** without interruption once approved
- Based on OpenCode's agent system architecture (primary/subagent modes, config via JSON or markdown)

**Research Findings**:
- OpenCode supports agent configuration in markdown format with YAML frontmatter
- Primary agents are interacted with directly (Tab switching)
- Key features: custom system prompts, tool access control, permission system, temperature settings
- Agents can be saved globally (`~/.config/opencode/agents/`) or per-project (`.opencode/agents/`)
- Agent configuration includes: description, mode, model, temperature, tools, and prompt content
- Built-in agents: `build` (full tools), `plan` (restricted tools)

### Metis Review

**Identified Gaps** (addressed):
- Gap: What makes T-800 different from standard agents? → Resolved: Emphasis on "think before build" philosophy with comprehensive variant analysis
- Gap: How does T-800 handle user questions? → Resolved: Structured questioning strategy with categories and logical flow
- Gap: What execution behavior to specify? → Resolved: NON-STOP coding once approved, only pause for impossible decisions
- Gap: How detailed should plans be? → Resolved: Exhaustive with complete directory structure, file breakdowns, and implementation tasks

---

## Work Objectives

### Core Objective

Create a comprehensive agent configuration for T-800 that embodies the philosophy: "Better to ask 100 questions than to build the wrong thing once."

### Concrete Deliverables
- Agent configuration file: `.opencode/agents/t800.md` with YAML frontmatter and detailed system prompt
- Complete system prompt covering: core principles, workflow, questioning strategy, thinking patterns, output examples, success metrics

### Definition of Done
- [ ] Agent file created with valid OpenCode configuration format
- [ ] YAML frontmatter present with required fields
- [ ] System prompt comprehensive enough for T-800 to operate as specified
- [ ] Examples included showing T-800's expected output format
- [ ] Success criteria defined for measuring T-800 effectiveness

### Must Have
- Four-phase workflow (Think, Question, Plan, Execute)
- Comprehensive questioning strategy with categories
-Thinking patterns for analyzing user requests
- Example outputs showing how T-800 should respond
- Continuous execution behavior specification
- Zero ambiguity output goals

### Must NOT Have (Guardrails)
- NO assumption-making without user confirmation
- NO partial implementations
- NO interruption during execution phase
- NO superficial plans or documentation
- NO stopping to ask "is this correct?" during execution

---

## Verification Strategy

### Test Decision
- **Infrastructure exists**: NO (this is a configuration file creation)
- **Automated tests**: None (configuration file creation, no executable code)
- **Framework**: N/A

### Agent-Executed QA Scenarios (MANDATORY — ALL tasks)

**Verification Tool by Deliverable Type**:
- **File Configuration**: Bash validation of markdown format and YAML structure
- **Content Completeness**: Read and verify all required sections present
- **Plan Quality**: Metis-style validation of plan thoroughness

**Each Scenario MUST Follow This Format**:

```
Scenario: Agent file validates as proper markdown with YAML frontmatter
  Tool: Bash (cat/grep)
  Preconditions: Agent file created at .opencode/agents/t800.md
  Steps:
    1. cat .opencode/agents/t800.md | head -50 → Verify YAML frontmatter present
    2. grep "^---" .opencode/agents/t800.md → Verify three dashes present
    3. grep "description:" .opencode/agents/t800.md → Verify description field exists
    4. grep "mode: primary" .opencode/agents/t800.md → Verify mode is primary
  Expected Result: File exists and contains valid YAML frontmatter structure
  Failure Indicators: YAML parsing error, missing required fields
  Evidence: Command output captured

Scenario: System prompt contains all required workflow phases
  Tool: Bash (grep)
  Preconditions: Agent file created
  Steps:
    1. grep -i "four-phase workflow" .opencode/agents/t800.md → Verify workflow section
    2. grep -i "think phase\|question phase\|plan phase\|execute phase" .opencode/agents/t800.md
    3. grep -i "questioning strategy" .opencode/agents/t800.md → Verify questioning section
    4. grep -i "continuous\|non-stop" .opencode/agents/t800.md → Verify execution behavior
  Expected Result: All workflow phases documented in system prompt
  Failure Indicators: Missing sections, incomplete workflow description
  Evidence: grep output captured
```

---

## Execution Strategy

### Parallel Execution Waves

```
Wave 1 (Start Immediately):
├── Task 1: Create agent configuration file with YAML frontmatter
└── Task 2: Write comprehensive system prompt

No dependencies - single file creation.

Critical Path: Task 1 → Task 2 (sequential within file write)
Parallel Speedup: N/A (single file)
```

### Dependency Matrix

| Task | Depends On | Blocks | Can Parallelize With |
|------|------------|--------|---------------------|
| 1 | None | 2 | None |
| 2 | Task 1 | None | None (sequential) |

### Agent Dispatch Summary

| Wave | Tasks | Recommended Agents |
|------|-------|-------------------|
| 1 | 1, 2 | task(category="writing", load_skills=["writing"], run_in_background=false) |

---

## TODOs

- [x] 1. Create agent configuration file structure

  **What to do**:
  - Create `.opencode/agents/t800.md` with proper YAML frontmatter format
  - Include: description, mode (primary), model, temperature, tools configuration
  - Structure for YAML frontmatter separator (---) and system prompt separator (---)
  
  **Must NOT do**:
  - Do not use JSON format (use markdown)
  - Do not miss required frontmatter fields
  - Do not forget the separator between frontmatter and prompt

  **Recommended Agent Profile**:
  - **Category**: writing
    - Reason: Writing configuration files with detailed system prompts is a documentation task requiring precision
  - **Skills**: [`writing`]
    - `writing`: This skill provides expertise in creating well-structured documentation and configuration files
  - **Skills Evaluated but Omitted**:
    - `frontend-ui-ux`: Not needed - this is not a UI/UX task
    - `git-master`: Not needed for file creation
    - `playwright`: Not needed for configuration file

  **Parallelization**:
  - **Can Run In Parallel**: NO
  - **Parallel Group**: Sequential (Task 2 depends on Task 1)
  - **Blocks**: None (final task)
  - **Blocked By**: None

  **References**:
  - OpenCode agent docs: `.opencode/agents/*.md` - Example agent file format
  - OpenCode documentation: https://opencode.ai/docs/agents/ - Agent configuration reference
  - T-800 concept draft: `.sisyphus/drafts/t800-agent-concept.md` - Complete requirements

  **Acceptance Criteria**:
  - [ ] File created at `.opencode/agents/t800.md`
  - [ ] YAML frontmatter present with description, mode, model, temperature, tools
  - [ ] Three-dash separators properly placed
  - [ ] File readable as valid markdown

  **Agent-Executed QA Scenarios**:

  ```
  Scenario: Agent file validates as proper markdown with YAML frontmatter
    Tool: Bash (read)
    Preconditions: None (creating new file)
    Steps:
      1. Write content to .opencode/agents/t800.md
      2. Read .opencode/agents/t800.md
      3. Verify first 5 lines contain YAML frontmatter
      4. Verify --- separator after frontmatter
    Expected Result: File exists with valid structure
    Evidence: Content of .opencode/agents/t800.md
  ```

  **Commit**: YES
  - Message: `feat(agent): add t800 comprehensive agent configuration`
  - Files: `.opencode/agents/t800.md`
  - Pre-commit: None (markdown file, no build needed)

- [x] 2. Write comprehensive system prompt

  **What to do**:
  - Write detailed system prompt implementing T-800 philosophy
  - Include four-phase workflow (Think, Question, Plan, Execute)
  - Document questioning strategy with categories and examples
  - Include thinking patterns for analyzing user requests
  - Add example outputs showing expected behavior
  - Define success criteria and edge cases

  **Must NOT do**:
  - Do not omit any philosophical principles
  - Do not leave questioning strategy incomplete
  - Do not skip execution behavior specification
  - Do not forget success metrics

  **Recommended Agent Profile**:
  - **Category**: writing
    - Reason: This requires creating comprehensive documentation for the agent's behavior and workflow
  - **Skills**: [`writing`]
    - `writing`: Expertise in creating detailed, structured documentation for AI agent behavior
  - **Skills Evaluated but Omitted**:
    - `frontend-ui-ux`: Not applicable
    - `git-master`: Not needed
    - `playwright`: Not needed

  **Parallelization**:
  - **Can Run In Parallel**: NO
  - **Parallel Group**: Sequential (Task 2 depends on Task 1)
  - **Blocks**: None
  - **Blocked By**: Task 1

  **References**:
  - OpenCode agent docs: https://opencode.ai/docs/agents/ - Prompt configuration
  - T-800 concept: `T-800 Agent Concept - Draft` - Complete requirements and examples
  - OpenCode architecture: Research on agent system behavior

  **Acceptance Criteria**:
  - [ ] System prompt includes four-phase workflow
  - [ ] Questioning strategy with categories documented
  - [ ] Thinking patterns included
  - [ ] Example outputs provided
  - [ ] Success criteria defined
  - [ ] Guardrails specified (what to avoid)

  **Agent-Executed QA Scenarios**:

  ```
  Scenario: System prompt contains all required workflow phases
    Tool: Bash (read)
    Preconditions: File exists
    Steps:
      1. Read .opencode/agents/t800.md
      2. Verify THOUGHT PHASE section present
      3. Verify QUESTION PHASE section present
      4. Verify PLAN PHASE section present
      5. Verify EXECUTE PHASE section present
    Expected Result: All workflow phases documented
    Evidence: Content of .opencode/agents/t800.md
  ```

  **Commit**: YES
  - Message: `feat(agent): implement comprehensive system prompt for t800`
  - Files: `.opencode/agents/t800.md`
  - Pre-commit: None

---

## Commit Strategy

| After Task | Message | Files | Verification |
|------------|---------|-------|--------------|
| 1 | `feat(agent): add t800 configuration structure` | .opencode/agents/t800.md | Read file exists |
| 2 | `feat(agent): implement system prompt for t800` | .opencode/agents/t800.md | Read file complete |

---

## Success Criteria

### Verification Commands
```bash
# Verify file exists
ls -la .opencode/agents/t800.md
# Expected: File exists

# Verify YAML frontmatter format
head -20 .opencode/agents/t800.md | grep "^---"
# Expected: Three --- separators visible

# Verify required sections
grep -E "PHASE|Questioning|Thinking|Success" .opencode/agents/t800.md
# Expected: Multiple section headers found
```

### Final Checklist
- [ ] All "Must Have" present (four-phase workflow, questioning strategy, thinking patterns, examples, success criteria)
- [ ] All "Must NOT Have" absent (no assumptions, no partial implementations, no interruption during execution, no superficial plans)
- [ ] All sections from concept draft included
- [ ] YAML frontmatter properly structured
- [ ] System prompt comprehensive and detailed
- [ ] Agent file validates as proper markdown
- [ ] Execution can begin with `/start-work`

---

## After Plan Completion: Cleanup & Handoff

**Draft cleaned up**: `.sisyphus/drafts/t800-agent-concept.md` (to be deleted by system)

To begin execution, run:
  `/start-work`

This will:
1. Register the plan as your active boulder
2. Track progress across sessions
3. Enable automatic continuation if interrupted
