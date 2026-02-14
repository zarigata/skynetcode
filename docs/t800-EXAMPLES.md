# T-800 Examples

## Example 1: Simple Web Application

### User Request
```
/start-t800 Build a todo list app
```

### T-800 Response

**THINK Phase**:
Analyzing request type: New web application
Complexity: Medium
Strategy: Full questioning workflow

**QUESTION Phase**:

1. What is the primary purpose?
   - Task management for personal use or teams?

2. Who are the target users?
   - Personal productivity?
   - Team collaboration?
   - Enterprise?

3. What features are must-haves?
   - Create/edit/delete tasks?
   - Categories/tags?
   - Due dates?
   - Priority levels?

4. What's your tech stack?
   - Frontend: React, Vue, Svelte?
   - Backend: Node, Python, Go?
   - Database: PostgreSQL, MongoDB, SQLite?

5. Deployment target?
   - Local only?
   - Cloud hosting?
   - Mobile responsive needed?

[... user answers questions ...]

**PLAN Phase**:

# Project: Todo List Application

## Executive Summary
A personal task management application with categories, due dates, and priorities.

## Technology Stack
- Frontend: React with TypeScript
- Backend: Node.js with Express
- Database: SQLite (easier setup for personal use)
- Deployment: Vercel (frontend) + Render (backend)

## Features
- [ ] Create, edit, delete tasks
- [ ] Mark tasks complete/incomplete
- [ ] Add categories
- [ ] Set due dates
- [ ] Priority levels (high, medium, low)
- [ ] Filter by category/status
- [ ] Local storage backup

## Architecture
### Frontend
```
src/
├── components/
│   ├── TaskList.tsx
│   ├── TaskItem.tsx
│   ├── TaskForm.tsx
│   └── Filter.tsx
├── services/
│   └── api.ts
└── App.tsx
```

### Backend
```
src/
├── routes/
│   └── tasks.ts
├── models/
│   └── Task.ts
└── server.ts
```

## Tasks
- [ ] Task 1: Set up React project with Vite
- [ ] Task 2: Create Express backend
- [ ] Task 3: Set up SQLite database
- [ ] Task 4: Build task CRUD endpoints
- [ ] Task 5: Build task UI components
- [ ] Task 6: Connect frontend to backend
- [ ] Test: Write tests for API
- [ ] Test: Write tests for components

**Approve this plan?** (yes/no)

[User approves]

**EXECUTE Phase**:

## Task 1: Set up React project - COMPLETE ✓
- Created project with Vite
- Configured TypeScript
- Set up Tailwind CSS
- Files: 12 created

## Task 2: Create Express backend - COMPLETE ✓
- Created Express server
- Configured middleware
- Set up API routes
- Files: 5 created

[... continues non-stop ...]

## COMPLETE

Tasks Completed: 8/8
Files Created: 34
Tests Passing: All
Status: ✅ READY FOR USE

---

## Example 2: REST API Endpoint

### User Request
```
/start-t800 Add a rate limiting feature to my API
```

### T-800 Response

**QUESTION Phase**:

1. What's the current request volume?
2. What rate limits do you need? (requests/time)
3. Should limits be per-user or global?
4. Do you need different limits for different endpoints?
5. How should rate limit errors be communicated?

**PLAN Phase**:

# Feature: API Rate Limiting

## Requirements
- Limit: 100 requests per minute per user
- Global limit: 1000 requests per minute
- Different limits for auth vs public endpoints
- Return 429 status with retry-after header

## Implementation
- [ ] Install express-rate-limit
- [ ] Configure user-based limits
- [ ] Configure global limits
- [ ] Add custom error response
- [ ] Add rate limit headers
- [ ] Write tests

**Approve?** (yes/no)

[User approves]

**EXECUTE Phase**: [Implements without stopping]

---

## Example 3: Bug Fix

### User Request
```
/start-t800 Fix the memory leak in the worker process
```

### T-800 Response

**QUESTION Phase**:

1. What symptoms are you seeing?
2. When does the leak occur?
3. How did you identify it as a memory leak?
4. What's the memory growth pattern?
5. Any recent changes to the worker?

**PLAN Phase**:

# Bug Fix: Worker Memory Leak

## Root Cause
Event listeners not being cleaned up on task completion

## Fix Plan
- [ ] Add cleanup method to worker
- [ ] Remove all listeners on task complete
- [ ] Clear intervals and timers
- [ ] Add memory monitoring
- [ ] Write regression test
- [ ] Update documentation

**Approve?** (yes/no)

[User approves]

**EXECUTE Phase**: [Implements without stopping]

---

## Key Patterns

### Complete Requests Give Better Results
- ✅ "Build a user authentication system with OAuth and email verification"
- ❌ "Build auth"

### Answer All Questions
The more detail you provide in questioning, the better the plan.

### Review Plans Carefully
Take time to review the plan before approving. Request changes if needed.

### Trust Execution
Once approved, let T-800 complete the work without interruption.
