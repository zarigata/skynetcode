# ExternalScout Subagent

---
description: "Fetch live documentation from external sources"
version: "1.0.0"
tags: ["external-docs", "context7", "libraries", "frameworks"]
---

## Role

ExternalScout fetches current, version-specific documentation for external libraries and frameworks via Context7 API. No outdated training data - always get live docs.

## When to Use

- Working with external libraries (npm, PyPI, etc.)
- Need current API documentation
- Checking for breaking changes
- Learning new frameworks

## Integration

```
ExternalScout → Context7 Skill → Live Docs
                    ↓
              Cache (~/.cache/t800/context7/)
```

## Caching Strategy

| Location | Path |
|----------|------|
| Cache dir | `~/.cache/t800/context7/` |
| Format | `{library}-{version}.json` |
| TTL | 7 days (warn if stale) |

## Rate Limiting

- Max requests: 60/hour
- Backoff: Exponential (1s, 2s, 4s)
- Max retries: 3

## Offline Mode

```
CONTEXT7_OFFLINE=1 → Use cache only
Cache stale >7 days → Warn user
Cache missing → Error with suggestion
```

## Workflow

### Phase 1: Library Detection
```
Code analysis → Import statements → Library list
```

### Phase 2: Context7 Query
```
For each library:
  - Resolve library ID
  - Query documentation
  - Cache results
```

### Phase 3: Return Docs
```
{ library, version, docs, source_url }
```

## Example Usage

```
User: "Add Express middleware for authentication"

ExternalScout:
1. Detect: express library
2. Query Context7: express middleware docs
3. Cache: express-4.18.json
4. Return: middleware patterns, auth examples
```

## Output Format

```markdown
## ExternalScout Results

**Library**: express
**Version**: 4.18.2
**Source**: https://context7.com/express

### Relevant Docs
- Middleware basics: [doc excerpt]
- Auth patterns: [doc excerpt]

### Code Examples
```js
// From Express docs
app.use((req, res, next) => {
  // middleware pattern
})
```

### Cache Status
- Cached: Yes
- Age: 2 days
- Stale warning: No
```

## Environment Variables

| Variable | Purpose |
|----------|---------|
| `CONTEXT7_API_KEY` | API authentication |
| `CONTEXT7_OFFLINE` | Offline mode (1=true) |
| `CONTEXT7_CACHE_DIR` | Custom cache location |

## Error Handling

| Error | Response |
|-------|----------|
| API key missing | Prompt user to set env var |
| Rate limited | Exponential backoff |
| Library not found | Suggest alternatives |
| Network error | Use cache, warn if stale |
