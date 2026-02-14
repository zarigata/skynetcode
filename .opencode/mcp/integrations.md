# T-800 MCP Integration Guide

Model Context Protocol (MCP) extends T-800 with external tools and capabilities.

## Recommended MCP Servers for T-800

### 1. GitHub MCP Server

**Purpose**: Repository operations, PR management, issue tracking

**Installation**:
```json
{
  "mcpServers": {
    "github": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-github"],
      "env": {
        "GITHUB_TOKEN": "your-token"
      }
    }
  }
}
```

**Use Cases**:
- Create and manage repositories
- Review pull requests
- Create and update issues
- Search code across repositories

### 2. Filesystem MCP Server

**Purpose**: Advanced file operations

**Installation**:
```json
{
  "mcpServers": {
    "filesystem": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-filesystem", "/path/to/project"]
    }
  }
}
```

**Use Cases**:
- Complex file searches
- Directory monitoring
- Batch file operations

### 3. PostgreSQL MCP Server

**Purpose**: Database operations and queries

**Installation**:
```json
{
  "mcpServers": {
    "postgres": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-postgres"],
      "env": {
        "DATABASE_URL": "your-connection-string"
      }
    }
  }
}
```

**Use Cases**:
- Schema introspection
- Query generation
- Data migration planning

### 4. Memory MCP Server

**Purpose**: Persistent memory across sessions

**Installation**:
```json
{
  "mcpServers": {
    "memory": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-memory"]
    }
  }
}
```

**Use Cases**:
- Remember user preferences
- Store project context
- Learn from past sessions

## T-800 Enhancement with MCP

### Enhanced Capabilities

**With GitHub MCP**:
```
User: "Create a PR for the authentication changes"

T-800:
1. Questions about PR description, reviewers
2. Reviews changes to include
3. Creates PR with proper formatting
4. Links to relevant issues
```

**With PostgreSQL MCP**:
```
User: "Add user authentication to the database"

T-800:
1. Questions about user fields
2. Introspects existing schema
3. Generates migration script
4. Creates proper indexes
```

**With Memory MCP**:
```
User: "Continue from last session"

T-800:
1. Retrieves project context from memory
2. Remembers user preferences
3. Continues without re-asking questions
4. Builds on previous decisions
```

## Adding MCP Servers to T-800

### Step 1: Configure in opencode.json

```json
{
  "mcp": {
    "servers": {
      "github": {
        "command": "npx",
        "args": ["-y", "@modelcontextprotocol/server-github"],
        "env": {
          "GITHUB_TOKEN": "${GITHUB_TOKEN}"
        }
      },
      "memory": {
        "command": "npx",
        "args": ["-y", "@modelcontextprotocol/server-memory"]
      }
    }
  }
}
```

### Step 2: Update T-800 Context

Add MCP capabilities to T-800's context:

```markdown
## Available MCP Tools

### GitHub
- `github_create_repo`: Create repositories
- `github_create_pr`: Create pull requests
- `github_list_issues`: List issues
- `github_search_code`: Search code

### Memory
- `memory_store`: Store information
- `memory_retrieve`: Retrieve stored info
- `memory_forget`: Clear memory
```

### Step 3: Use in Workflows

Update T-800 workflows to leverage MCP:

```markdown
## Enhanced Execution Workflow

### Phase 2: Questioning (Enhanced)
- Check memory for user preferences
- Use GitHub to check existing code
- Query database schema via MCP

### Phase 4: Execution (Enhanced)
- Create GitHub PRs for changes
- Store learnings in memory
- Update database via MCP
```

## Best Practices for MCP Integration

### 1. Minimal Context
Only enable MCP servers when needed. Each adds to context size.

### 2. Tool Selection
Use specific tools, not all tools from a server.

### 3. Token Budget
Monitor token usage with MCP servers. Some (like GitHub) can be heavy.

### 4. Error Handling
MCP servers may fail. Always have fallback behavior.

## MCP vs Skills

| Aspect | MCP | Skills |
|--------|-----|--------|
| Purpose | External tools | Internal capabilities |
| State | Stateless | Stateful within session |
| Context impact | High (many tools) | Low (prompt only) |
| Flexibility | External services | Agent behavior |
| Example | Database queries | Questioning patterns |

## Recommended Setup for T-800

```json
{
  "mcp": {
    "servers": {
      "memory": {
        "command": "npx",
        "args": ["-y", "@modelcontextprotocol/server-memory"]
      }
    }
  }
}
```

Start with just memory MCP, add others as needed.
