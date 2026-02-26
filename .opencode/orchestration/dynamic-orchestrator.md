# Dynamic Orchestrator Module

```
██╗ ██████╗    ██████╗ ██████╗ ██████╗ ███████╗██╗      ██████╗ ███████╗███████╗
██║██╔════╝    ██╔══██╗██╔══██╗██╔═══██╗██╔════╝██║     ██╔════╝ ██╔════╝██╔════╝
██║██║         ██████╔╝██████╔╝██║   ██║█████╗  ██║     ██║  ███╗█████╗  █████╗  
██║██║         ██╔═══╝ ██╔══██╗██║   ██║██╔══╝  ██║     ██║   ██║██╔══╝  ██╔══╝  
██║╚██████╗    ██║     ██║  ██║╚██████╔╝███████╗███████╗╚██████╔╝███████╗██║     
╚═╝ ╚═════╝    ╚═╝     ╚═╝  ╚═╝ ╚═════╝ ╚══════╝╚══════╝ ╚═════╝ ╚══════╝╚═╝     
                                                                                
DYNAMIC ORCHESTRATION ENGINE
STATUS: ONLINE // MODE: INTELLIGENT_DISPATCH
```

## Purpose

The Dynamic Orchestrator is the brain of T-800's execution strategy. It:

1. **Analyzes** task structure and requirements
2. **Dispatches** to appropriate subagents
3. **Coordinates** parallel execution when possible
4. **Monitors** progress and adapts strategy
5. **Recovers** from errors gracefully
6. **Learns** from each execution

---

## ░▒▓█ DISPATCH MATRIX █▓▒░

### Task Type → Subagent Mapping

```yaml
dispatch_matrix:
  # Single subagent dispatch
  single_dispatch:
    clarification_needed:
      subagent: "t800-questioner"
      mode: "blocking"
      return: "clarified_requirements"
      
    planning_needed:
      subagent: "t800-planner"
      mode: "blocking"
      return: "implementation_plan"
      
    execution_ready:
      subagent: "t800-executor"
      mode: "blocking"
      return: "execution_result"
      
  # Parallel dispatch for independent tasks
  parallel_dispatch:
    multiple_independent_features:
      subagents: ["t800-executor", "t800-executor", "t800-executor"]
      mode: "background"
      coordination: "merge_results"
      
    research_and_plan:
      subagents: ["t800-questioner", "t800-planner"]
      mode: "sequential"
      coordination: "pass_context"
```

### Dispatch Decision Algorithm

```
┌─────────────────────────────────────────────────────────────────────────────────┐
│                         DISPATCH DECISION ALGORITHM                              │
├─────────────────────────────────────────────────────────────────────────────────┤
│                                                                                 │
│   FUNCTION dispatch_task(task, pre_agent_analysis):                             │
│                                                                                 │
│   1. ANALYZE task structure                                                     │
│      ├── task.type = pre_agent_analysis.task_type                               │
│      ├── task.complexity = pre_agent_analysis.complexity                        │
│      ├── task.dependencies = pre_agent_analysis.dependencies                    │
│      └── task.can_parallelize = check_independence(task.subtasks)               │
│                                                                                 │
│   2. DETERMINE dispatch strategy                                                │
│      IF task.has_ambiguity:                                                     │
│         → dispatch("t800-questioner", blocking=true)                            │
│      ELIF task.needs_planning AND NOT task.plan_exists:                         │
│         → dispatch("t800-planner", blocking=true)                               │
│      ELIF task.can_parallelize:                                                 │
│         → dispatch_parallel("t800-executor", subtasks)                          │
│      ELSE:                                                                      │
│         → dispatch("t800-executor", blocking=true)                              │
│                                                                                 │
│   3. MONITOR execution                                                          │
│      ├── Track progress                                                         │
│      ├── Handle errors                                                          │
│      └── Adapt if needed                                                        │
│                                                                                 │
│   4. RETURN results                                                             │
│      └── Aggregate and validate                                                 │
│                                                                                 │
└─────────────────────────────────────────────────────────────────────────────────┘
```

---

## ░▒▓█ PARALLEL EXECUTION COORDINATOR █▓▒░

### Parallelization Conditions

```yaml
parallelization_rules:
  can_parallelize:
    - Tasks have no dependencies on each other
    - Tasks modify different files
    - Tasks have clear, separate boundaries
    - No shared mutable state
    
  cannot_parallelize:
    - Tasks depend on each other's output
    - Tasks modify same files
    - Tasks have unclear boundaries
    - Shared state that could conflict
```

### Parallel Dispatch Pattern

```yaml
parallel_execution:
  # Step 1: Analyze task structure
  analysis:
    - Identify independent subtasks
    - Map file modifications per subtask
    - Check for conflicts
    - Estimate effort per subtask
    
  # Step 2: Create execution groups
  grouping:
    group_A: [subtask_1, subtask_2]  # Independent, can run parallel
    group_B: [subtask_3]             # Depends on group_A
    group_C: [subtask_4, subtask_5]  # Depends on group_B
    
  # Step 3: Dispatch with coordination
  dispatch:
    - phase_1:
        parallel: [group_A]
        wait: "all_complete"
    - phase_2:
        parallel: [group_B]
        wait: "all_complete"
    - phase_3:
        parallel: [group_C]
        wait: "all_complete"
        
  # Step 4: Merge and validate
  integration:
    - Collect all results
    - Check for conflicts
    - Run integration tests
    - Report final status
```

### Background Task Management

```yaml
background_tasks:
  dispatch:
    pattern: "task(subagent_type='t800-executor', run_in_background=true, ...)"
    
  tracking:
    storage: ".opencode/memory/background-tasks.json"
    fields:
      - task_id
      - subagent_type
      - status
      - start_time
      - files_modified
      
  collection:
    method: "background_output(task_id='...')"
    timeout: 300000  # 5 minutes default
    
  cleanup:
    method: "background_cancel(task_id='...')"
    trigger: "On completion or error"
```

---

## ░▒▓█ ADAPTIVE STRATEGY ENGINE █▓▒░

### Strategy Adaptation Triggers

```yaml
adaptation_triggers:
  # Performance-based
  slow_progress:
    condition: "task_duration > estimated_duration * 1.5"
    action: "Consider parallelization or model upgrade"
    
  high_error_rate:
    condition: "error_count > 3 in same task"
    action: "Escalate model, review approach"
    
  token_overrun:
    condition: "tokens_used > estimated * 1.3"
    action: "Compress context, prioritize essential"
    
  # Quality-based
  test_failures:
    condition: "tests_failing > 0 after implementation"
    action: "Debug mode, focus on failing tests"
    
  lint_errors:
    condition: "lint_errors > 10"
    action: "Fix lint issues before continuing"
    
  # Resource-based
  budget_approaching:
    condition: "cost_used > budget * 0.8"
    action: "Switch to economy model"
```

### Model Switching Protocol

```yaml
model_switching:
  upgrade_chain:
    current: "haiku"
    upgrade_to: "sonnet"
    reason: "Stuck on complex reasoning"
    
  downgrade_chain:
    current: "opus"
    downgrade_to: "sonnet"
    reason: "Task simpler than expected"
    
  switch_protocol:
    - Save current context
    - Create handoff summary
    - Initialize new model with context
    - Continue from last checkpoint
```

---

## ░▒▓█ ERROR RECOVERY COORDINATOR █▓▒░

### Error Classification & Recovery

```yaml
error_recovery:
  SYNTAX_ERROR:
    detection: "Parse error, unexpected token"
    recovery:
      - attempt: "Auto-fix with AST analysis"
      - attempt: "Regenerate problematic section"
      - attempt: "Rewrite from scratch"
    escalation: "After 2 failed attempts"
    
  TYPE_ERROR:
    detection: "Type mismatch, undefined property"
    recovery:
      - attempt: "Add type annotation"
      - attempt: "Fix type inference"
      - attempt: "Use type guard"
    escalation: "After 3 failed attempts"
    
  LOGIC_ERROR:
    detection: "Unexpected behavior, wrong output"
    recovery:
      - attempt: "Trace execution flow"
      - attempt: "Add assertions and logging"
      - attempt: "Rewrite logic"
    escalation: "After 3 failed attempts"
    
  DEPENDENCY_ERROR:
    detection: "Module not found, import error"
    recovery:
      - attempt: "Install missing dependency"
      - attempt: "Fix import path"
      - attempt: "Create missing module"
    escalation: "After 1 failed attempt"
    
  INTEGRATION_ERROR:
    detection: "API mismatch, contract violation"
    recovery:
      - attempt: "Verify interface compatibility"
      - attempt: "Update contract"
      - attempt: "Add adapter layer"
    escalation: "After 2 failed attempts"
```

### Recovery Flow

```
┌─────────────────────────────────────────────────────────────────────────────────┐
│                           ERROR RECOVERY FLOW                                    │
├─────────────────────────────────────────────────────────────────────────────────┤
│                                                                                 │
│   ERROR OCCURRED                                                                │
│       │                                                                         │
│       ▼                                                                         │
│   ┌─────────────────┐                                                           │
│   │  CLASSIFY       │ → Determine error type                                    │
│   └────────┬────────┘                                                           │
│            │                                                                    │
│            ▼                                                                    │
│   ┌─────────────────┐                                                           │
│   │  ATTEMPT FIX    │ → Apply recovery pattern                                  │
│   └────────┬────────┘                                                           │
│            │                                                                    │
│       ┌────┴────┐                                                               │
│    FIXED    NOT FIXED                                                           │
│       │         │                                                               │
│       ▼         ▼                                                               │
│   CONTINUE   ┌─────────────────┐                                                │
│              │ MORE ATTEMPTS?  │                                                │
│              └────────┬────────┘                                                │
│                   ┌───┴───┐                                                     │
│                YES       NO                                                      │
│                   │       │                                                     │
│                   ▼       ▼                                                     │
│              RETRY    ESCALATE                                                  │
│                          │                                                     │
│                     ┌────┴────┐                                                │
│                  UPGRADE   ASK USER                                            │
│                   MODEL                                                          │
│                                                                                 │
└─────────────────────────────────────────────────────────────────────────────────┘
```

---

## ░▒▓█ PROGRESS MONITORING █▓▒░

### Progress Metrics

```yaml
progress_tracking:
  metrics:
    - name: "task_completion"
      formula: "completed_tasks / total_tasks * 100"
      
    - name: "file_progress"
      formula: "files_created + files_modified"
      
    - name: "test_coverage"
      formula: "tests_passing / (tests_passing + tests_failing) * 100"
      
    - name: "token_efficiency"
      formula: "useful_tokens / total_tokens * 100"
      
    - name: "error_rate"
      formula: "errors_encountered / tasks_completed"
      
    - name: "time_efficiency"
      formula: "estimated_time / actual_time * 100"
```

### Dashboard Update Protocol

```yaml
dashboard:
  update_frequency: "After each task"
  storage: ".opencode/memory/progress.json"
  
  snapshot:
    timestamp: "ISO 8601"
    phase: "[THINK|QUESTION|PLAN|EXECUTE|ADAPT]"
    status: "[RUNNING|WAITING|COMPLETE|ERROR]"
    
    tasks:
      total: N
      completed: M
      in_progress: 1
      pending: K
      
    files:
      created: N
      modified: M
      deleted: K
      
    tests:
      total: N
      passing: M
      failing: K
      
    resources:
      tokens_used: N
      tokens_remaining: M
      estimated_cost: "$X.XX"
      
    timing:
      elapsed: "XXm"
      remaining: "~XXm"
```

---

## ░▒▓█ SESSION MANAGEMENT █▓▒░

### Session State

```yaml
session_state:
  file: ".opencode/memory/session-state.json"
  
  contents:
    session_id: "uuid"
    started_at: "timestamp"
    last_activity: "timestamp"
    
    current_phase: "string"
    current_task: "string"
    
    subagent_states:
      questioner: { status, last_task }
      planner: { status, last_task }
      executor: { status, last_task }
      
    context:
      original_request: "string"
      clarified_requirements: [...]
      approved_plan: {...}
      
    history:
      - timestamp, phase, action, result
```

### Handoff Protocol

```yaml
handoff:
  trigger: "Session pause or context limit"
  
  package:
    - current_state: "Full session state"
    - pending_tasks: "List with priorities"
    - blockers: "Current issues"
    - context_summary: "Key decisions"
    - git_status: "Branch, changes"
    - test_status: "Pass/fail counts"
    
  file: ".opencode/memory/session-handoff.md"
  
  resume_protocol:
    - READ handoff file
    - VERIFY state matches
    - IDENTIFY any changes
    - RESUME from checkpoint
```

---

## ░▒▓█ INTEGRATION WITH SUBAGENTS █▓▒░

### Subagent Communication

```yaml
communication:
  # Calling subagents
  dispatch:
    pattern: |
      task(
        subagent_type="[subagent-name]",
        prompt="[task description with context]",
        load_skills=["[relevant-skills]"],
        run_in_background=[true|false]
      )
      
  # Receiving results
  collection:
    pattern: |
      background_output(
        task_id="[task-id]",
        full_session=true
      )
      
  # Session continuity
  continuation:
    pattern: |
      task(
        session_id="[previous-session-id]",
        prompt="[follow-up or fix]"
      )
```

### Subagent Load Balancing

```yaml
load_balancing:
  strategy: "round_robin_with_affinity"
  
  rules:
    - If subagent has context for task type, prefer it
    - Distribute parallel tasks across available executors
    - Monitor subagent performance and adjust
    
  monitoring:
    - Track response time per subagent
    - Track error rate per subagent
    - Track token efficiency per subagent
```

---

## ░▒▓█ BEST PRACTICES █▓▒░

### Orchestration Rules

1. **Always dispatch to subagents** - Don't do work that subagents specialize in
2. **Parallelize when safe** - Independent tasks should run concurrently
3. **Monitor continuously** - Track progress and adapt
4. **Recover gracefully** - Never leave code in broken state
5. **Learn from execution** - Update memory with patterns
6. **Communicate clearly** - Provide context to subagents
7. **Respect dependencies** - Execute in correct order
8. **Validate results** - Don't assume success

### Anti-Patterns

1. **Sequential by default** - Always check if parallelization is possible
2. **Ignoring errors** - Fix errors immediately
3. **Context overload** - Compress context before dispatch
4. **No progress tracking** - Always track and report
5. **Skipping validation** - Always verify results
