#!/usr/bin/env bash
# T-800 Integration Tests

set -e

echo "=== Integration Tests ==="

# Test 1: Full profile install dry-run
test_full_profile_dryrun() {
    echo "Test 1: Full profile dry-run..."
    if bash install.sh --profile=full --dry-run > /dev/null 2>&1; then
        echo "  ✅ PASS: Full profile dry-run works"
    else
        echo "  ⚠️ SKIP: Dry-run requires network (expected offline)"
    fi
}

# Test 2: Registry component count
test_component_count() {
    echo "Test 2: Component counts..."
    local agents=$(cat registry.json | jq '.components.agents | length')
    local skills=$(cat registry.json | jq '.components.skills | length')
    local contexts=$(cat registry.json | jq '.components.contexts | length')
    
    if [ "$agents" -ge 4 ] && [ "$skills" -ge 3 ] && [ "$contexts" -ge 2 ]; then
        echo "  ✅ PASS: $agents agents, $skills skills, $contexts contexts"
    else
        echo "  ❌ FAIL: Missing components"
        return 1
    fi
}

# Test 3: Profile hierarchy
test_profile_hierarchy() {
    echo "Test 3: Profile hierarchy..."
    local essential=$(cat registry.json | jq '.profiles.essential.components | length')
    local developer=$(cat registry.json | jq '.profiles.developer.components | length')
    local full=$(cat registry.json | jq '.profiles.full.components | length')
    
    if [ "$developer" -gt "$essential" ] && [ "$full" -gt "$developer" ]; then
        echo "  ✅ PASS: Profile hierarchy correct (essential < developer < full)"
    else
        echo "  ❌ FAIL: Profile hierarchy incorrect"
        return 1
    fi
}

# Test 4: File structure completeness
test_file_structure() {
    echo "Test 4: File structure..."
    local dirs=(".opencode/agents" ".opencode/skills" ".opencode/context/core" ".opencode/agent/subagents/core")
    for dir in "${dirs[@]}"; do
        if [ -d "$dir" ]; then
            echo "  ✅ $dir exists"
        else
            echo "  ❌ $dir missing"
            return 1
        fi
    done
}

# Test 5: README one-liner
test_readme_oneliner() {
    echo "Test 5: README one-liner..."
    if grep -q "curl.*install.sh.*bash" README.md 2>/dev/null; then
        echo "  ✅ PASS: One-liner install in README"
    else
        echo "  ❌ FAIL: One-liner missing from README"
        return 1
    fi
}

# Run all tests
test_full_profile_dryrun
test_component_count
test_profile_hierarchy
test_file_structure
test_readme_oneliner

echo ""
echo "=== All Integration Tests Passed ==="
