# T-800 Learning System Tests

## Test Suite: Self-Improvement System

### Prerequisites
- Learning module files exist in `.opencode/learning/`
- Memory system available at `.opencode/memory/system.md`
- Session schemas valid JSON

---

## Test 1: Reflection Engine Functionality

### Purpose
Verify reflection engine documentation and logic work correctly.

### Preconditions
- `.opencode/learning/reflection-engine.md` exists
- Memory system documentation exists

### Steps
1. Verify reflection engine file exists:
   ```bash
   test -f .opencode/learning/reflection-engine.md && echo "PASS" || echo "FAIL"
   ```

2. Verify required sections are documented:
   ```bash
   grep -q "Reflection Framework" .opencode/learning/reflection-engine.md && echo "PASS: Framework documented"
   grep -q "Outcome Analysis" .opencode/learning/reflection-engine.md && echo "PASS: Outcome analysis documented"
   grep -q "Memory System" .opencode/learning/reflection-engine.md && echo "PASS: Memory integration documented"
   ```

3. Verify depth levels are defined:
   ```bash
   grep -q "Level 1" .opencode/learning/reflection-engine.md && echo "PASS: Level 1 defined"
   grep -q "Level 2" .opencode/learning/reflection-engine.md && echo "PASS: Level 2 defined"
   grep -q "Level 3" .opencode/learning/reflection-engine.md && echo "PASS: Level 3 defined"
   ```

### Expected Result
- File exists with >100 lines
- Contains all required sections
- Integrates with memory system

### Evidence
- File: `.opencode/learning/reflection-engine.md`
- Line count validation

---

## Test 2: Feedback Processing Accuracy

### Purpose
Verify feedback processor correctly classifies outcomes.

### Preconditions
- `.opencode/learning/feedback-processor.md` exists

### Steps
1. Verify feedback processor exists:
   ```bash
   test -f .opencode/learning/feedback-processor.md && echo "PASS" || echo "FAIL"
   ```

2. Verify failure types are defined:
   ```bash
   grep -q "Planning Failures" .opencode/learning/feedback-processor.md && echo "PASS: Planning failures"
   grep -q "Execution Failures" .opencode/learning/feedback-processor.md && echo "PASS: Execution failures"
   grep -q "Integration Failures" .opencode/learning/feedback-processor.md && echo "PASS: Integration failures"
   grep -q "Resource Failures" .opencode/learning/feedback-processor.md && echo "PASS: Resource failures"
   ```

3. Verify success/failure record formats:
   ```bash
   grep -q '"type": "success"' .opencode/learning/feedback-processor.md && echo "PASS: Success format"
   grep -q '"type": "failure"' .opencode/learning/feedback-processor.md && echo "PASS: Failure format"
   ```

### Expected Result
- File documents all failure types
- Output formats are valid JSON structures
- Integration with reflection engine documented

### Evidence
- File: `.opencode/learning/feedback-processor.md`

---

## Test 3: Pattern Extraction Validation

### Purpose
Verify pattern extractor can identify and store patterns correctly.

### Preconditions
- `.opencode/learning/pattern-extractor.md` exists
- Memory system available

### Steps
1. Verify pattern extractor exists:
   ```bash
   test -f .opencode/learning/pattern-extractor.md && echo "PASS" || echo "FAIL"
   ```

2. Verify pattern types are defined:
   ```bash
   grep -q "Success Patterns" .opencode/learning/pattern-extractor.md && echo "PASS: Success patterns"
   grep -q "Failure Patterns" .opencode/learning/pattern-extractor.md && echo "PASS: Failure patterns"
   grep -q "Workflow Patterns" .opencode/learning/pattern-extractor.md && echo "PASS: Workflow patterns"
   ```

3. Verify memory system integration:
   ```bash
   grep -q "Semantic Memory" .opencode/learning/pattern-extractor.md && echo "PASS: Semantic memory"
   grep -q "Long-Term Memory" .opencode/learning/pattern-extractor.md && echo "PASS: Long-term memory"
   ```

4. Verify validation criteria documented:
   ```bash
   grep -q "Validation Checklist" .opencode/learning/pattern-extractor.md && echo "PASS: Validation documented"
   ```

### Expected Result
- All pattern types documented
- Memory integration specified
- Validation criteria comprehensive

### Evidence
- File: `.opencode/learning/pattern-extractor.md`

---

## Test 4: Session Data Schema Validation

### Purpose
Verify session.json schema is valid JSON and defines required fields.

### Preconditions
- `.opencode/learning/schemas/session.json` exists

### Steps
1. Validate JSON syntax:
   ```bash
   jq '.' .opencode/learning/schemas/session.json > /dev/null && echo "PASS: Valid JSON" || echo "FAIL: Invalid JSON"
   ```

2. Verify required fields:
   ```bash
   jq '.required | contains(["timestamp", "task_count", "success_rate", "duration_ms", "patterns", "recommendations"])' .opencode/learning/schemas/session.json
   ```

3. Verify field definitions:
   ```bash
   jq '.properties.timestamp.type' .opencode/learning/schemas/session.json
   jq '.properties.task_count.type' .opencode/learning/schemas/session.json
   jq '.properties.success_rate.minimum' .opencode/learning/schemas/session.json
   jq '.properties.success_rate.maximum' .opencode/learning/schemas/session.json
   ```

### Expected Result
- JSON is valid
- All required fields defined
- Success rate constrained to 0.0-1.0

### Evidence
- File: `.opencode/learning/schemas/session.json`

---

## Test 5: Recommendation Schema Validation

### Purpose
Verify recommendation.json schema is valid and complete.

### Preconditions
- `.opencode/learning/schemas/recommendation.json` exists

### Steps
1. Validate JSON syntax:
   ```bash
   jq '.' .opencode/learning/schemas/recommendation.json > /dev/null && echo "PASS: Valid JSON" || echo "FAIL: Invalid JSON"
   ```

2. Verify required fields:
   ```bash
   jq '.required | contains(["id", "type", "priority", "description"])' .opencode/learning/schemas/recommendation.json
   ```

3. Verify enum constraints:
   ```bash
   jq '.properties.type.enum' .opencode/learning/schemas/recommendation.json
   jq '.properties.priority.enum' .opencode/learning/schemas/recommendation.json
   ```

### Expected Result
- JSON is valid
- Type enum contains: process, skill, knowledge, tool
- Priority enum contains: critical, high, medium, low

### Evidence
- File: `.opencode/learning/schemas/recommendation.json`

---

## Test 6: Memory System Integration

### Purpose
Verify learning module properly integrates with existing memory system.

### Preconditions
- Memory system at `.opencode/memory/system.md`
- Learning module files exist

### Steps
1. Check reflection engine references memory:
   ```bash
   grep -i "memory" .opencode/learning/reflection-engine.md | wc -l
   ```

2. Check pattern extractor references memory types:
   ```bash
   grep -i "episodic\|semantic\|long-term" .opencode/learning/pattern-extractor.md | wc -l
   ```

3. Verify memory system exists:
   ```bash
   test -f .opencode/memory/system.md && echo "PASS: Memory system exists" || echo "FAIL: No memory system"
   ```

### Expected Result
- Reflection engine references memory system
- Pattern extractor uses all 4 memory types
- Memory system documentation available

### Evidence
- Grep output count > 3 for both files

---

## Summary Checklist

### Wave 1 Files Required

| File | Status |
|------|--------|
| `.opencode/learning/reflection-engine.md` | [ ] Verified |
| `.opencode/learning/feedback-processor.md` | [ ] Verified |
| `.opencode/learning/pattern-extractor.md` | [ ] Verified |
| `.opencode/learning/schemas/session.json` | [ ] Valid JSON |
| `.opencode/learning/schemas/recommendation.json` | [ ] Valid JSON |
| `tests/enhancements/learning.test.md` | [ ] Created |

### Acceptance Criteria

- [ ] Directory `.opencode/learning/` exists with all markdown files
- [ ] Directory `.opencode/learning/schemas/` exists with JSON schemas
- [ ] Session schema validates with `jq`
- [ ] Recommendation schema validates with `jq`
- [ ] Reflection engine references memory system
- [ ] Test file exists with 6 test scenarios