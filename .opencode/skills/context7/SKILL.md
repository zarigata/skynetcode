# Context7 Skill

---
description: "Fetch live library documentation via Context7 API"
version: "1.0.0"
tags: ["documentation", "libraries", "external", "api"]
---

## Purpose

Fetch current, version-specific documentation for any library or framework via Context7 API.

## Quick Start

```bash
# Set API key
export CONTEXT7_API_KEY=your_key_here

# Use skill
./router.sh resolve-library express
./router.sh query-docs express "middleware authentication"
```

## Commands

| Command | Description |
|---------|-------------|
| `resolve-library` | Get Context7 library ID |
| `query-docs` | Fetch documentation |

## API Endpoints

### Resolve Library ID
```
POST https://api.context7.com/v1/resolve
Body: { "query": "express", "libraryName": "express" }
Response: { "libraryId": "/expressjs/express", "version": "4.18.2" }
```

### Query Documentation
```
POST https://api.context7.com/v1/query
Body: { "libraryId": "/expressjs/express", "query": "middleware" }
Response: { "docs": [...], "codeExamples": [...] }
```

## Caching

- Directory: `~/.cache/t800/context7/`
- Format: JSON files per library/version
- TTL: 7 days

## Rate Limits

- Requests: 60/hour
- Tokens: 10,000/day

## Error Codes

| Code | Meaning | Action |
|------|---------|--------|
| 401 | Invalid API key | Check env var |
| 429 | Rate limited | Wait and retry |
| 404 | Library not found | Try alternate name |
