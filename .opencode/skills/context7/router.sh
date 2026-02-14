#!/usr/bin/env bash
set -e

CACHE_DIR="${CONTEXT7_CACHE_DIR:-$HOME/.cache/t800/context7}"
API_KEY="${CONTEXT7_API_KEY}"
API_URL="https://api.context7.com/v1"

mkdir -p "$CACHE_DIR"

resolve_library() {
    local library="$1"
    curl -s -X POST "$API_URL/resolve" \
        -H "Authorization: Bearer $API_KEY" \
        -H "Content-Type: application/json" \
        -d "{\"query\":\"$library\",\"libraryName\":\"$library\"}"
}

query_docs() {
    local library_id="$1"
    local query="$2"
    local cache_file="$CACHE_DIR/${library_id//\//-}.json"
    
    # Check cache
    if [ -f "$cache_file" ] && [ -z "$CONTEXT7_OFFLINE" ]; then
        cache_age=$(( $(date +%s) - $(stat -c %Y "$cache_file") ))
        if [ $cache_age -lt 604800 ]; then
            cat "$cache_file"
            return
        fi
    fi
    
    # Fetch fresh
    curl -s -X POST "$API_URL/query" \
        -H "Authorization: Bearer $API_KEY" \
        -H "Content-Type: application/json" \
        -d "{\"libraryId\":\"$library_id\",\"query\":\"$query\"}" | tee "$cache_file"
}

case "$1" in
    resolve-library) resolve_library "$2" ;;
    query-docs) query_docs "$2" "$3" ;;
    *) echo "Usage: $0 {resolve-library|query-docs} [args]" ;;
esac
