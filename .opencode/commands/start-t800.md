# Command: /start-t800

## Summary
Start a new T-800 agent session to handle a project from requirements to implementation.

## Usage
```
/start-t800 [project-description]
```

## Parameters
- `project-description`: Optional initial description of what you want to build

## Behavior

### Without Parameter
1. Greets user
2. Asks for project description
3. Begins THINK → QUESTION → PLAN → EXECUTE cycle

### With Parameter
1. Acknowledges project description
2. Begins THINK phase immediately
3. Proceeds through cycle

## Example

```
> /start-t800 Build a user authentication system

T-800: I'll help you build a user authentication system.

## THINK Phase
Analyzing request... I need to clarify:
- Authentication methods (password, OAuth, etc.)
- User roles and permissions
- Session management approach
- Security requirements

## QUESTION Phase
Let me ask some clarifying questions:

1. What authentication methods do you need?
   - Password-based?
   - OAuth (Google, GitHub, etc.)?
   - Magic links?
   - Multi-factor authentication?

2. What user roles are needed?
   - Admin?
   - Regular user?
   - Guest?

[... continues with systematic questioning ...]
```

## Configuration
This command invokes the main T-800 agent which coordinates:
- t800-questioner (for clarification)
- t800-planner (for planning)
- t800-executor (for implementation)

## See Also
- `/t800-question` - Jump directly to questioning
- `/t800-plan` - Jump directly to planning
- `/t800-execute` - Jump directly to execution
