#!/bin/bash
# T-800 Configuration Validator
# Validates all T-800 agent configurations

set -e

echo "=== T-800 Configuration Validator ==="
echo ""

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Validation counters
VALID=0
INVALID=0

# Function to validate YAML frontmatter
validate_frontmatter() {
    local file=$1
    local has_open_separator=$(head -1 "$file" | grep -c "^---$" || true)
    local has_close_separator=$(grep -n "^---$" "$file" | wc -l)
    
    if [ "$has_open_separator" -ne 1 ]; then
        echo -e "${RED}FAIL: $file - Missing opening --- separator${NC}"
        ((INVALID++))
        return 1
    fi
    
    if [ "$has_close_separator" -lt 2 ]; then
        echo -e "${RED}FAIL: $file - Missing closing --- separator${NC}"
        ((INVALID++))
        return 1
    fi
    
    return 0
}

# Function to validate required fields
validate_required_fields() {
    local file=$1
    local has_description=$(grep -c "^description:" "$file" || true)
    local has_mode=$(grep -c "^mode:" "$file" || true)
    
    if [ "$has_description" -lt 1 ]; then
        echo -e "${RED}FAIL: $file - Missing description field${NC}"
        ((INVALID++))
        return 1
    fi
    
    if [ "$has_mode" -lt 1 ]; then
        echo -e "${RED}FAIL: $file - Missing mode field${NC}"
        ((INVALID++))
        return 1
    fi
    
    return 0
}

# Validate agent files
echo "Validating agent configurations..."
echo ""

for agent_file in .opencode/agents/*.md; do
    [ -f "$agent_file" ] || continue
    
    agent_name=$(basename "$agent_file" .md)
    echo -e "${YELLOW}Validating: $agent_name${NC}"
    
    # Check frontmatter
    if validate_frontmatter "$agent_file"; then
        # Check required fields
        if validate_required_fields "$agent_file"; then
            echo -e "${GREEN}PASS: $agent_name${NC}"
            ((VALID++))
        fi
    fi
    echo ""
done

# Validate context files
echo "Validating context files..."
echo ""

for context_file in .opencode/context/core/*.md .opencode/context/project-intelligence/*.md; do
    [ -f "$context_file" ] || continue
    
    context_name=$(basename "$context_file" .md)
    echo -e "${YELLOW}Validating: $context_name${NC}"
    
    # Check file exists and has content
    if [ -s "$context_file" ]; then
        echo -e "${GREEN}PASS: $context_name${NC}"
        ((VALID++))
    else
        echo -e "${RED}FAIL: $context_name - Empty file${NC}"
        ((INVALID++))
    fi
    echo ""
done

# Validate skill files
echo "Validating skill files..."
echo ""

for skill_file in .opencode/skills/*.md; do
    [ -f "$skill_file" ] || continue
    
    skill_name=$(basename "$skill_file" .md)
    echo -e "${YELLOW}Validating: $skill_name${NC}"
    
    # Check file exists and has content
    if [ -s "$skill_file" ]; then
        echo -e "${GREEN}PASS: $skill_name${NC}"
        ((VALID++))
    else
        echo -e "${RED}FAIL: $skill_name - Empty file${NC}"
        ((INVALID++))
    fi
    echo ""
done

# Print summary
echo "================================"
echo -e "${GREEN}Valid: $VALID${NC}"
[ $INVALID -gt 0 ] && echo -e "${RED}Invalid: $INVALID${NC}"
echo "================================"

# Exit with appropriate code
[ $INVALID -gt 0 ] && exit 1
exit 0
