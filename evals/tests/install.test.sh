#!/usr/bin/env bash
# T-800 Install Script Tests

set -e

echo "=== Install Script Tests ==="

# Test 1: Registry exists and is valid
test_registry_valid() {
    echo "Test 1: Registry JSON validation..."
    if cat registry.json | jq . > /dev/null 2>&1; then
        echo "  ✅ PASS: registry.json is valid JSON"
    else
        echo "  ❌ FAIL: registry.json is invalid JSON"
        return 1
    fi
}

# Test 2: All profiles defined
test_profiles_exist() {
    echo "Test 2: Profile validation..."
    local count=$(cat registry.json | jq '.profiles | keys | length')
    if [ "$count" -eq 5 ]; then
        echo "  ✅ PASS: All 5 profiles defined"
    else
        echo "  ❌ FAIL: Expected 5 profiles, got $count"
        return 1
    fi
}

# Test 3: install.sh is executable
test_install_executable() {
    echo "Test 3: Install script executable..."
    if [ -x install.sh ]; then
        echo "  ✅ PASS: install.sh is executable"
    else
        echo "  ❌ FAIL: install.sh is not executable"
        return 1
    fi
}

# Test 4: update.sh is executable
test_update_executable() {
    echo "Test 4: Update script executable..."
    if [ -x update.sh ]; then
        echo "  ✅ PASS: update.sh is executable"
    else
        echo "  ❌ FAIL: update.sh is not executable"
        return 1
    fi
}

# Test 5: Agent files exist
test_agents_exist() {
    echo "Test 5: Agent files exist..."
    local agents=("t800" "t800-questioner" "t800-planner" "t800-executor")
    for agent in "${agents[@]}"; do
        if [ -f ".opencode/agents/${agent}.md" ]; then
            echo "  ✅ ${agent}.md exists"
        else
            echo "  ❌ ${agent}.md missing"
            return 1
        fi
    done
}

# Run all tests
test_registry_valid
test_profiles_exist
test_install_executable
test_update_executable
test_agents_exist

echo ""
echo "=== All Tests Passed ==="
