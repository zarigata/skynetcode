# T-799 Research & Planning Skill

## Skill Name
`t799-research-planning`

## Description
Open-source internet agent skill for exhaustive research and multi-file planning with test coverage targets. Creates detailed step-by-step blueprints for T-800 execution.

## When to Use
Use this skill when:
- User wants to plan a project before implementation
- Research is needed to understand technologies
- Detailed step-by-step breakdown is required
- Test coverage targets need to be defined
- Handoff to T-800 for execution is desired

## Research Tools (API-less)

| Tool | Purpose | When to Use |
|------|---------|-------------|
| `websearch_web_search_exa` | Web search | Find tutorials, solutions, best practices |
| `google_search` | Google with URL analysis | Current info, specific URLs |
| `grep_app_searchGitHub` | GitHub code search | Find real implementation patterns |
| `context7_resolve-library-id` | Library ID resolution | Before querying Context7 docs |
| `context7_query-docs` | Documentation query | Official library documentation |
| `webfetch` | URL content fetch | Extract from specific URLs |

## Workflow

### Step 1: RECEIVE REQUEST
1. Parse user request
2. Identify scope and domain
3. Ask clarifying questions using `question` tool
4. Confirm understanding

### Step 2: RESEARCH
1. Query Context7 for library documentation
2. Search GitHub for implementation patterns
3. Web search for best practices
4. Document findings in research.md

### Step 3: DECOMPOSE
1. Break into major STEPS
2. Define step dependencies
3. Order by critical path
4. Create step file for each

### Step 4: DETAIL
For each step:
1. Create atomic SUB-STEPS
2. Define test strategy
3. Set coverage targets (aim for 100%)
4. List files to create/modify
5. Document edge cases
6. Add code patterns

### Step 5: GENERATE
Create folder structure:
```
.opencode/plans/{project}/
├── 00-overview.md
├── 01-step-{name}.md
├── 02-step-{name}.md
├── ...
├── research.md
└── manifest.json
```

### Step 6: HANDOFF
1. Present plan summary
2. Ask for confirmation
3. On approval: invoke T-800 executor

## Step File Template

```markdown
# Step N: [Name]

## Metadata
- **Dependencies**: [Prerequisite steps]
- **Estimated Effort**: [SMALL|MEDIUM|LARGE]
- **Files Affected**: [File list]

## Sub-Steps
- [ ] N.1 [Description] → `path/to/file.ts`
- [ ] N.2 [Description] → `path/to/file2.ts`

## Implementation Details

### N.1: [Sub-step Name]
**File**: `path/to/file.ts`
**Description**: [What it does]
**Code Pattern**:
```language
// Pattern or pseudocode
```
**Gotchas**:
- ⚠️ [Warning]

## Test Strategy

| Test Type | What | Target | Achievability |
|-----------|------|--------|---------------|
| Unit      | [...] | 100%  | REALISTIC     |
| Integration| [...] | 90%   | REALISTIC     |
| E2E       | [...] | 80%   | STRETCH       |

### Test Commands
```bash
npm test -- --coverage
```

## Acceptance Criteria
- [ ] All sub-steps complete
- [ ] Tests pass at target rates
- [ ] No errors

## Edge Cases
| Case | Handling |
|------|----------|
| [...] | [...] |

## Dependencies
- **Requires**: Step [N-1]
- **Blocks**: Step [N+1]
```

## Manifest Template

```json
{
  "project": "{name}",
  "created": "{ISO timestamp}",
  "steps": [
    {
      "id": 1,
      "name": "{step name}",
      "file": "01-step-{slug}.md",
      "effort": "SMALL|MEDIUM|LARGE",
      "dependencies": [],
      "test_target": 100
    }
  ],
  "total_steps": 0,
  "estimated_files": 0,
  "overall_test_target": 95,
  "ready_for_t800": true
}
```

## Test Coverage Targets

| Test Type | Default Target | Achievability |
|-----------|---------------|---------------|
| Unit      | 100%          | REALISTIC     |
| Integration | 90%         | REALISTIC     |
| E2E       | 80%           | STRETCH       |
| Overall   | 95%           | TARGET        |

### Achievability Ratings
- **REALISTIC**: Achievable with standard testing
- **STRETCH**: Requires extra effort but possible
- **IDEAL**: Perfect scenario, may need adjustment

## Handoff Protocol

```yaml
ask_confirmation: true

confirmation_message: |
  Plan created at .opencode/plans/{project}/
  
  Summary:
  - {N} steps
  - {M} files estimated  
  - Target test coverage: {X}%
  
  Proceed with T-800 execution?

on_approval:
  invoke_t800_executor: true
  prompt_template: |
    Execute plan from .opencode/plans/{project}/
    
    Start with: 01-step-{first}.md
    Follow: manifest.json for order
    
    Execute NON-STOP until complete.
```

## Best Practices

1. **Research First**: Always research before planning
2. **Atomic Sub-steps**: Each sub-step = single file change
3. **100% Target**: Aim for 100% unit test coverage
4. **Real Patterns**: Use real GitHub patterns in examples
5. **Document Gotchas**: Include warnings from research
6. **Clear Dependencies**: Map step dependencies explicitly

## Escalation Criteria

Request user input when:
- Scope is unclear after initial questions
- Technology choice is ambiguous
- Test targets seem unrealistic
- Dependencies are circular
- Research reveals conflicting approaches
