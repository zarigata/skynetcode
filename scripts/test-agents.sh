#!/bin/bash
# T-800 Agent Test Runner
# Usage: ./scripts/test-agents.sh [agent-name]

set -e

echo "=== T-800 Agent Test Runner ==="
echo ""

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Test counters
TESTS_PASSED=0
TESTS_FAILED=0

# Function to run test
run_test() {
    local test_file=$1
    local test_name=$(basename "$test_file" .test.md)
    
    echo -e "${YELLOW}Running: $test_name${NC}"
    
    # Check if test file exists
    if [ ! -f "$test_file" ]; then
        echo -e "${RED}FAIL: Test file not found: $test_file${NC}"
        ((TESTS_FAILED++))
        return 1
    fi
    
    # Validate test file structure
    local has_description=$(grep -c "## Test Suite" "$test_file" || true)
    local has_tests=$(grep -c "### Test" "$test_file" || true)
    
    if [ "$has_description" -lt 1 ]; then
        echo -e "${RED}FAIL: Missing test suite description${NC}"
        ((TESTS_FAILED++))
        return 1
    fi
    
    if [ "$has_tests" -lt 1 ]; then
        echo -e "${RED}FAIL: No tests defined${NC}"
        ((TESTS_FAILED++))
        return 1
    fi
    
    echo -e "${GREEN}PASS: $test_name ($has_tests tests defined)${NC}"
    ((TESTS_PASSED++))
    return 0
}

# Run tests based on argument or all
if [ "$1" ]; then
    # Run specific agent tests
    test_file="tests/agents/$1.test.md"
    if [ -f "$test_file" ]; then
        run_test "$test_file"
    else
        echo -e "${RED}Error: Test file not found for agent '$1'${NC}"
        exit 1
    fi
else
    # Run all tests
    echo "Running all agent tests..."
    echo ""
    
    # Run agent tests
    for test_file in tests/agents/*.test.md; do
        [ -f "$test_file" ] && run_test "$test_file"
        echo ""
    done
    
    # Run integration tests
    echo "Running integration tests..."
    echo ""
    for test_file in tests/integration/*.test.md; do
        [ -f "$test_file" ] && run_test "$test_file"
        echo ""
    done
fi

# Print summary
echo "================================"
echo -e "${GREEN}Tests Passed: $TESTS_PASSED${NC}"
[ $TESTS_FAILED -gt 0 ] && echo -e "${RED}Tests Failed: $TESTS_FAILED${NC}"
echo "================================"

# Exit with appropriate code
[ $TESTS_FAILED -gt 0 ] && exit 1
exit 0
