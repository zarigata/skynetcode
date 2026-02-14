# T-800 Usage Guide

## Getting Started

### Starting T-800

**From command line**:
```bash
# With a project description
./scripts/run-t800.sh "Build a user authentication system"

# Interactive mode (no description)
./scripts/run-t800.sh
```

**From OpenCode**:
```bash
opencode --agent t800 "Your project description"
```

### Workflow

1. **User Request** → T-800 receives your request
2. **THINK** → T-800 analyzes what you want
3. **QUESTION** → T-800 asks clarifying questions
4. **PLAN** → T-800 creates detailed plan
5. **APPROVE** → You review and approve the plan
6. **EXECUTE** → T-800 builds without stopping
7. **VALIDATE** → Tests pass, code works

## Example Sessions

### Example 1: New Feature

```
> /start-t800 Add user authentication to my app

T-800: I'll help you add user authentication.

## QUESTION Phase

**Scope Discovery**:
1. What is the primary purpose? (login, register, password reset, etc.)
2. Who are the target users?
3. What are the top 3 must-haves?

**Technical Architecture**:
4. What authentication method? (password, OAuth, magic links)
5. What database are you using?
6. What's your current tech stack?

[... more questions ...]

## PLAN Phase

Based on your answers, here's the implementation plan:

# Project: User Authentication

## Features
- User registration
- Email verification
- Login/logout
- Password reset
- Session management

## Tasks
- [ ] Create user database schema
- [ ] Implement registration endpoint
- [ ] Implement login endpoint
- [ ] Add session management
- [ ] Create auth middleware
- [ ] Add password reset flow
- [ ] Write tests
- [ ] Add documentation

**Approve this plan?** (yes/no)
```

### Example 2: Bug Fix

```
> /start-t800 Fix the login timeout issue

T-800: I'll help you fix the login timeout issue.

## QUESTION Phase

1. What is the exact behavior you're seeing?
2. How do you reproduce the issue?
3. What is the expected behavior?
4. When did this start happening?
5. Any recent changes to the auth system?

## PLAN Phase

Based on your answers, the issue appears to be session expiration timing.

Bug Fix Plan:
1. Analyze current session timeout configuration
2. Identify race condition in refresh token flow
3. Implement fix with proper token refresh
4. Add regression test
5. Update documentation

**Approve this plan?** (yes/no)
```

## Phase Details

### THINK Phase
T-800 analyzes your request to understand:
- Request type (feature, bug fix, refactor, etc.)
- Complexity level
- What questions to ask
- What context to load

### QUESTION Phase
T-800 asks systematic questions covering:
- Scope & Goals
- Technical Architecture
- Features & Functionality
- Security & Validation
- User Experience
- Testing & Quality
- Deployment & Maintenance

### PLAN Phase
T-800 creates a detailed implementation plan:
- Executive summary
- Requirements breakdown
- Architecture design
- Task decomposition
- Testing strategy
- Acceptance criteria

### APPROVAL Gate
You review and approve/reject the plan:
- Review all tasks
- Request modifications
- Approve to proceed

### EXECUTE Phase
T-800 implements without stopping:
- Follows plan exactly
- Completes each task fully
- Validates after each step
- Documents everything
- Handles errors immediately

### VALIDATE Phase
T-800 verifies everything works:
- Runs all tests
- Checks types
- Validates integration
- Confirms completion

## Configuration Options

### Agent Selection
You can use specific subagents directly:

```bash
# Question only
opencode --agent t800-questioner "What should I build?"

# Plan only (with existing requirements)
opencode --agent t800-planner "Create a plan for authentication"

# Execute only (with approved plan)
opencode --agent t800-executor "Implement the approved plan"
```

### Context Loading
T-800 automatically loads context files:
- Standards for coding conventions
- Workflows for process guidance
- Strategies for questioning
- Templates for planning

## Tips

### For Faster Sessions
1. Provide detailed initial descriptions
2. Answer questions completely
3. Provide examples when asked
4. Clarify assumptions immediately

### For Better Plans
1. Specify constraints upfront
2. Mention must-haves separately
3. Include acceptance criteria
4. Specify non-negotiables

### For Successful Execution
1. Review plans carefully
2. Ask questions before approval
3. Don't interrupt during execution
4. Let T-800 complete each phase
