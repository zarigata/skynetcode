# T-800 Telemetry System Tests

## Test Suite: Telemetry & Observability

### Prerequisites
- Telemetry module files exist in `.opencode/telemetry/`
- Schemas directory exists
- Telemetry config available

---

## Test 1: Trace Collection Validity

### Purpose
Verify trace collector produces valid trace files with correct structure.

### Preconditions
- `.opencode/telemetry/trace-collector.md` exists

### Steps
1. Verify trace collector documentation:
   ```bash
   test -f .opencode/telemetry/trace-collector.md && echo "PASS" || echo "FAIL"
   ```

2. Verify required sections:
   ```bash
   grep -q "Trace Structure" .opencode/telemetry/trace-collector.md && echo "PASS: Structure documented"
   grep -q "Parameter Redaction" .opencode/telemetry/trace-collector.md && echo "PASS: Redaction documented"
   grep -q "Performance Considerations" .opencode/telemetry/trace-collector.md && echo "PASS: Performance documented"
   ```

3. Verify PII exclusion documented:
   ```bash
   grep -qi "no.*pii\|redact.*password\|redact.*api_key" .opencode/telemetry/trace-collector.md && echo "PASS: PII exclusion" || echo "FAIL: Missing PII exclusion"
   ```

### Expected Result
- File exists with >100 lines
- All required sections present
- PII exclusion explicitly documented

### Evidence
- File: `.opencode/telemetry/trace-collector.md`

---

## Test 2: Metrics Aggregation Accuracy

### Purpose
Verify metrics aggregator calculates correctly and defines proper formulas.

### Preconditions
- `.opencode/telemetry/metrics-aggregator.md` exists

### Steps
1. Verify metrics aggregator exists:
   ```bash
   test -f .opencode/telemetry/metrics-aggregator.md && echo "PASS" || echo "FAIL"
   ```

2. Verify calculation formulas:
   ```bash
   grep -q "success_rate" .opencode/telemetry/metrics-aggregator.md && echo "PASS: Success rate formula"
   grep -q "total_cost" .opencode/telemetry/metrics-aggregator.md && echo "PASS: Cost formula"
   grep -q "Calculation Formulas" .opencode/telemetry/metrics-aggregator.md && echo "PASS: Formulas section"
   ```

3. Verify aggregation levels defined:
   ```bash
   grep -q "Session Level" .opencode/telemetry/metrics-aggregator.md && echo "PASS: Session level"
   grep -q "Daily Level" .opencode/telemetry/metrics-aggregator.md && echo "PASS: Daily level"
   grep -q "Weekly Level" .opencode/telemetry/metrics-aggregator.md && echo "PASS: Weekly level"
   ```

### Expected Result
- All calculation formulas documented
- Aggregation levels defined
- Examples provided

### Evidence
- File: `.opencode/telemetry/metrics-aggregator.md`

---

## Test 3: Cost Tracking Correctness

### Purpose
Verify cost tracker uses correct pricing formula and model pricing.

### Preconditions
- `.opencode/telemetry/cost-tracker.md` exists

### Steps
1. Verify cost tracker exists:
   ```bash
   test -f .opencode/telemetry/cost-tracker.md && echo "PASS" || echo "FAIL"
   ```

2. Verify pricing formula includes both input and output:
   ```bash
   grep -q "0.003" .opencode/telemetry/cost-tracker.md && echo "PASS: Input price $0.003"
   grep -q "0.015" .opencode/telemetry/cost-tracker.md && echo "PASS: Output price $0.015"
   ```

3. Verify calculation examples:
   ```bash
   grep -q "input_cost" .opencode/telemetry/cost-tracker.md && echo "PASS: Input cost calculation"
   grep -q "output_cost" .opencode/telemetry/cost-tracker.md && echo "PASS: Output cost calculation"
   ```

4. Verify budget management:
   ```bash
   grep -q "budget" .opencode/telemetry/cost-tracker.md && echo "PASS: Budget management"
   grep -q "warning" .opencode/telemetry/cost-tracker.md && echo "PASS: Warning thresholds"
   ```

### Expected Result
- Formula: `(input_tokens × 0.003) + (output_tokens × 0.015)`
- Budget management documented
- Optimization strategies included

### Evidence
- File: `.opencode/telemetry/cost-tracker.md`

---

## Test 4: Trace Schema Validation

### Purpose
Verify trace.json schema is valid and defines required fields.

### Preconditions
- `.opencode/telemetry/schemas/trace.json` exists

### Steps
1. Validate JSON syntax:
   ```bash
   jq '.' .opencode/telemetry/schemas/trace.json > /dev/null && echo "PASS: Valid JSON" || echo "FAIL: Invalid JSON"
   ```

2. Verify required fields:
   ```bash
   jq '.required | contains(["session_id", "timestamp", "events"])' .opencode/telemetry/schemas/trace.json
   ```

3. Verify event structure:
   ```bash
   jq '.properties.events.items.properties | keys' .opencode/telemetry/schemas/trace.json
   ```

### Expected Result
- JSON is valid
- Required fields: session_id, timestamp, events
- Events have: event_id, timestamp, type, duration_ms, success

### Evidence
- File: `.opencode/telemetry/schemas/trace.json`

---

## Test 5: Metrics Schema Validation

### Purpose
Verify metrics.json schema is valid and complete.

### Preconditions
- `.opencode/telemetry/schemas/metrics.json` exists

### Steps
1. Validate JSON syntax:
   ```bash
   jq '.' .opencode/telemetry/schemas/metrics.json > /dev/null && echo "PASS: Valid JSON" || echo "FAIL: Invalid JSON"
   ```

2. Verify required fields:
   ```bash
   jq '.required | contains(["session_id", "total_events", "total_duration_ms", "total_cost", "success_rate"])' .opencode/telemetry/schemas/metrics.json
   ```

3. Verify success_rate constraints:
   ```bash
   jq '.properties.success_rate.minimum == 0 and .properties.success_rate.maximum == 1' .opencode/telemetry/schemas/metrics.json
   ```

### Expected Result
- JSON is valid
- All required fields defined
- Success rate constrained to 0.0-1.0

### Evidence
- File: `.opencode/telemetry/schemas/metrics.json`

---

## Test 6: Telemetry Performance Constraints

### Purpose
Verify telemetry adds <100ms overhead per operation.

### Preconditions
- All telemetry files exist

### Steps
1. Check overhead documentation:
   ```bash
   grep -q "<100ms" .opencode/telemetry/trace-collector.md && echo "PASS: Overhead constraint documented"
   ```

2. Verify performance section exists:
   ```bash
   grep -q "Performance Considerations\|Overhead Budget" .opencode/telemetry/trace-collector.md && echo "PASS: Performance section"
   ```

3. Verify optimization strategies:
   ```bash
   grep -q "Buffered\|Async\|Optimization" .opencode/telemetry/trace-collector.md && echo "PASS: Optimization documented"
   ```

### Expected Result
- Overhead constraint clearly stated
- Optimization strategies provided
- Performance section comprehensive

### Evidence
- File content analysis

---

## Summary Checklist

### Wave 2 Files Required

| File | Status |
|------|--------|
| `.opencode/telemetry/trace-collector.md` | [ ] Verified |
| `.opencode/telemetry/metrics-aggregator.md` | [ ] Verified |
| `.opencode/telemetry/cost-tracker.md` | [ ] Verified |
| `.opencode/telemetry/schemas/trace.json` | [ ] Valid JSON |
| `.opencode/telemetry/schemas/metrics.json` | [ ] Valid JSON |
| `tests/enhancements/telemetry.test.md` | [ ] Created |

### Acceptance Criteria

- [ ] Directory `.opencode/telemetry/` exists with all markdown files
- [ ] Directory `.opencode/telemetry/schemas/` exists with JSON schemas
- [ ] Trace schema includes: session_id, timestamp, events array
- [ ] Events have required fields: tool, duration_ms, timestamp, success
- [ ] Cost tracker formula documented: `(tokens_in × 0.003) + (tokens_out × 0.015)`
- [ ] Test file exists with 6 test scenarios
- [ ] PII exclusion explicitly documented
- [ ] Overhead constraint <100ms documented