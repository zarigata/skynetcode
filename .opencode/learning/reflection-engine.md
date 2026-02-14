# T-800 Reflection Engine

RISE-style recursive introspection for continuous self-improvement.

## Purpose

Analyze execution outcomes to identify improvement opportunities without modifying code directly.

## Core Philosophy

> "The unexamined execution is not worth repeating." - Adapted from Socrates

## Reflection Framework

### 1. Outcome Analysis

After each execution phase, analyze:

```yaml
outcome_capture:
  goal: "What was intended?"
  result: "What was achieved?"
  delta: "What was the gap?"
  context: "What conditions existed?"
```

### 2. Root Cause Identification

For any gap between goal and result:

```markdown
## Gap Analysis

### Gap Type Classification
- **Planning Gap**: Plan was incomplete or incorrect
- **Execution Gap**: Plan was good, execution failed
- **Context Gap**: Missing information affected outcome
- **Resource Gap**: Insufficient tools/time/knowledge

### Root Cause Questions
1. What assumption was wrong?
2. What information was missing?
3. What skill was lacking?
4. What pattern didn't apply?
```

### 3. Pattern Recognition

Identify recurring themes:

```json
{
  "pattern_type": "recurring_failure",
  "trigger": "Missing requirement",
  "outcome": "Rework needed",
  "frequency": 3,
  "contexts": ["auth", "api", "frontend"],
  "recommendation": "Add requirement discovery phase"
}
```

### 4. Improvement Synthesis

Convert analysis into actionable recommendations:

```markdown
## Recommendation Template

### ID: REC-{timestamp}-{sequence}
### Type: [process|skill|knowledge|tool]
### Priority: [critical|high|medium|low]
### Description: [what to change]
### Rationale: [why this helps]
### Impact: [expected improvement]
### Effort: [implementation cost]
```

## Reflection Triggers

### Automatic Triggers
- After every task completion
- After error recovery
- After clarification loop
- After user feedback

### Manual Triggers
- User requests reflection
- Quality threshold not met
- Cost threshold exceeded

## Reflection Depth Levels

### Level 1: Surface Reflection (Default)
```yaml
duration: 30 seconds
focus: immediate outcome
output: single actionable insight
```

### Level 2: Deep Reflection (On failure)
```yaml
duration: 2 minutes
focus: root cause and patterns
output: comprehensive analysis + recommendations
```

### Level 3: Meta-Reflection (Weekly)
```yaml
duration: 15 minutes
focus: learning across sessions
output: accumulated wisdom + pattern updates
```

## Integration with Memory System

### Episodic Memory
- Store reflection outcomes
- Track improvement over time
- Reference past similar situations

### Semantic Memory
- Update knowledge with new learnings
- Add discovered patterns to knowledge base
- Refine fact accuracy

### Working Memory
- Track current session reflections
- Maintain active insights
- Contextual application of learnings

### Long-Term Memory
- Accumulate wisdom across sessions
- Build preference models
- Develop expertise profiles

## Constraints

### MUST NOT
- Auto-apply recommendations to code
- Create infinite reflection loops
- Reflect without termination condition
- Send reflection data externally

### MUST
- Provide actionable recommendations
- Link to relevant memory entries
- Respect time budgets
- Allow user override

## Output Format

```markdown
# Reflection Report

## Session: {session_id}
## Timestamp: {timestamp}

### Outcome Summary
- **Goal**: {original_goal}
- **Result**: {actual_result}
- **Status**: [success|partial|failure]

### Analysis

#### What Worked
- [Pattern 1]: [Why it worked]
- [Pattern 2]: [Why it worked]

#### What Didn't Work
- [Issue 1]: [Why it failed]
- [Issue 2]: [Why it failed]

#### Root Causes
1. [Root cause 1]
2. [Root cause 2]

### Recommendations

#### Immediate Actions
1. [Action 1] (Priority: critical)
2. [Action 2] (Priority: high)

#### Future Considerations
1. [Consideration 1] (Type: process)
2. [Consideration 2] (Type: skill)

### Memory Updates Required
- [ ] Update episodic memory: {what}
- [ ] Update semantic memory: {what}
- [ ] Update long-term memory: {what}

### Pattern Matches
- Similar past sessions: {count}
- Applicability score: {score}/10

## Next Reflection
- Trigger: {next_trigger}
- Level: {level}
```

## Files Created

This reflection engine produces:

```
.opencode/learning/
├── sessions/
│   └── {date}.json          # Session recordings
├── reflections/
│   └── {date}.md            # Reflection reports
├── recommendations/
│   └── active.json          # Pending recommendations
└── patterns/
    └── discovered.json      # New pattern discoveries
```

## Usage Example

```markdown
User: "Build a login system"

[T-800 executes and completes]

Reflection Engine:
  Trigger: Task completion
  Level: 1 (surface)
  
  Analysis:
    - Goal: Build login system
    - Result: Built with JWT, bcrypt
    - Status: Success
    
  Pattern Found:
    - Used T-800 workflow phases
    - Question phase identified JWT preference
    - User prefers stateless auth
    
  Recommendations:
    - Store "user prefers stateless auth" in long-term memory
    - Add JWT pattern to semantic memory for this user
    
  Memory Updates:
    - Long-term: user_preference.authentication = "stateless"
```

## Research Basis

This reflection engine implements concepts from:
- **RISE** (Recursive Introspection): Multi-turn MDP for iterative improvement
- **Self-Reflection Pattern**: Review and iterate on outputs
- **Long-Term Memory**: Cross-session learning and preference retention
