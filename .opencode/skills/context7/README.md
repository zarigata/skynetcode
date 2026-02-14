# Context7 Skill

Fetch live library documentation for external dependencies.

## Setup

```bash
export CONTEXT7_API_KEY=your_api_key
```

## Usage

```bash
# Resolve library ID
./router.sh resolve-library react

# Query documentation
./router.sh query-docs /facebook/react "hooks useState"
```

## Cache

Docs are cached in `~/.cache/t800/context7/` for 7 days.
