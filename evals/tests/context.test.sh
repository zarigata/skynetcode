#!/usr/bin/env bash
# T-800 Context System Tests

set -e

echo "=== Context System Tests ==="

# Test 1: ContextScout exists and is MVI compliant
test_contextscout_mvi() {
    echo "Test 1: ContextScout MVI compliance..."
    local lines=$(wc -l < .opencode/agent/subagents/core/contextscout.md)
    if [ "$lines" -le 200 ]; then
        echo "  ✅ PASS: ContextScout is MVI compliant ($lines lines)"
    else
        echo "  ❌ FAIL: ContextScout exceeds MVI limit ($lines lines)"
        return 1
    fi
}

# Test 2: ExternalScout exists and is MVI compliant  
test_externalscout_mvi() {
    echo "Test 2: ExternalScout MVI compliance..."
    local lines=$(wc -l < .opencode/agent/subagents/core/externalscout.md)
    if [ "$lines" -le 200 ]; then
        echo "  ✅ PASS: ExternalScout is MVI compliant ($lines lines)"
    else
        echo "  ❌ FAIL: ExternalScout exceeds MVI limit ($lines lines)"
        return 1
    fi
}

# Test 3: Context7 skill files exist
test_context7_skill() {
    echo "Test 3: Context7 skill files..."
    local files=("SKILL.md" "router.sh" "README.md")
    for file in "${files[@]}"; do
        if [ -f ".opencode/skills/context7/${file}" ]; then
            echo "  ✅ ${file} exists"
        else
            echo "  ❌ ${file} missing"
            return 1
        fi
    done
}

# Test 4: MVI audit exists
test_mvi_audit() {
    echo "Test 4: MVI audit report..."
    if [ -f ".sisyphus/mvi-audit.md" ]; then
        local flagged=$(grep -c "EXCEEDS MVI" .sisyphus/mvi-audit.md)
        echo "  ✅ PASS: MVI audit exists ($flagged files flagged)"
    else
        echo "  ❌ FAIL: MVI audit missing"
        return 1
    fi
}

# Test 5: Context files exist
test_context_files() {
    echo "Test 5: Core context files..."
    local files=("t800-standards.md" "t800-workflows.md")
    for file in "${files[@]}"; do
        if [ -f ".opencode/context/core/${file}" ]; then
            echo "  ✅ ${file} exists"
        else
            echo "  ❌ ${file} missing"
            return 1
        fi
    done
}

# Run all tests
test_contextscout_mvi
test_externalscout_mvi
test_context7_skill
test_mvi_audit
test_context_files

echo ""
echo "=== All Context Tests Passed ==="
