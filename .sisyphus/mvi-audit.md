# MVI Audit Report

**Generated:** 2026-02-14
**Principle:** Maximum Viable Information (MVI) - Context files ≤200 lines

## Summary
- Total files audited: 30
- Files exceeding MVI limit (200 lines): 21
- Total lines: ~7,245

## Files Exceeding MVI Limit

| File | Lines | Recommendation |
|------|-------|----------------|
| .opencode/enhancements/integration.md | 572 | Split into: integration-core.md, integration-learning.md, integration-telemetry.md, integration-recovery.md |
| .opencode/patterns/plan-execute.md | 461 | Split into: plan-execute-overview.md, plan-execute-phases.md, plan-execute-examples.md |
| .opencode/patterns/human-loop.md | 417 | Split into: human-loop-triggers.md, human-loop-workflow.md, human-loop-examples.md |
| .opencode/learning/pattern-extractor.md | 414 | Split into: pattern-extractor-core.md, pattern-extractor-strategies.md |
| .opencode/recovery/handling-patterns.md | 390 | Already organized by exception type - extract each type to separate file |
| .opencode/recovery/escalation-manager.md | 372 | Split into: escalation-levels.md, escalation-workflow.md |
| .opencode/learning/feedback-processor.md | 367 | Split into: feedback-types.md, feedback-processing.md |
| .opencode/recovery/exception-classifier.md | 363 | Split into: exception-types.md (10 separate files) |
| .opencode/telemetry/metrics-aggregator.md | 358 | Split into: metrics-types.md, metrics-aggregation.md |
| .opencode/recovery/state-recovery.md | 357 | Split into: state-persistence.md, state-recovery-workflow.md |
| .opencode/telemetry/trace-collector.md | 352 | Split into: trace-collection.md, trace-storage.md |
| .opencode/telemetry/cost-tracker.md | 330 | Split into: cost-tracking.md, cost-optimization.md |
| .opencode/patterns/react.md | 289 | Split into: react-pattern.md, react-examples.md |
| .opencode/enhancements/README.md | 259 | Split into: enhancements-overview.md, enhancements-modules.md |
| .opencode/memory/system.md | 255 | Split into: memory-types.md, memory-operations.md |
| .opencode/reasoning/patterns.md | 251 | Split into: reasoning-types.md, reasoning-workflows.md |
| .opencode/learning/reflection-engine.md | 251 | Split into: reflection-triggers.md, reflection-workflow.md |
| .opencode/context/project-intelligence/planning-templates.md | 237 | Split into: template-types.md, template-examples.md |
| .opencode/mcp/integrations.md | 235 | Split into: mcp-overview.md, mcp-integrations-list.md |
| .opencode/agents/t800.md | 224 | Split into: t800-core.md, t800-workflow.md, t800-delegation.md |
| .opencode/patterns/pattern-selector.md | 201 | Just over limit - minor trim needed |

## Compliant Files (≤200 lines)

- .opencode/context/project-intelligence/questioning-strategies.md (139)
- .opencode/skills/t800-execution.md (129)
- .opencode/agents/t800-planner.md (117)
- .opencode/workflows/t800-full-workflow.md (114)
- .opencode/agents/t800-executor.md (110)
- .opencode/agents/t800-questioner.md (105)
- .opencode/skills/t800-questioning.md (101)
- .opencode/skills/t800-planning.md (101)
- .opencode/context/core/t800-standards.md (90)
- .opencode/context/core/t800-workflows.md (90)

## Recommendations

1. **Priority 1** (500+ lines): integration.md, plan-execute.md, human-loop.md
2. **Priority 2** (350-500 lines): pattern-extractor.md, handling-patterns.md, escalation-manager.md, feedback-processor.md, exception-classifier.md, metrics-aggregator.md, state-recovery.md, trace-collector.md, cost-tracker.md
3. **Priority 3** (200-350 lines): react.md, README.md, system.md, patterns.md, reflection-engine.md, planning-templates.md, integrations.md, t800.md, pattern-selector.md
