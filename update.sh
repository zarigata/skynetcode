#!/usr/bin/env bash

#############################################################################
# T-800 Ecosystem Updater
# Updates existing T-800 installations
#############################################################################

set -e

# Colors
RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'
BLUE='\033[0;34m'; CYAN='\033[0;36m'; BOLD='\033[1m'; NC='\033[0m'

REPO_URL="https://github.com/zarigata/t800-ecosystem"
BRANCH="${T800_BRANCH:-main}"
RAW_URL="https://raw.githubusercontent.com/zarigata/t800-ecosystem/${BRANCH}"

print_success() { echo -e "${GREEN}✓${NC} $1"; }
print_error() { echo -e "${RED}✗${NC} $1"; }
print_info() { echo -e "${BLUE}ℹ${NC} $1"; }

check_version() {
    local current_version="unknown"
    local latest_version="unknown"
    
    # Get current version
    if [ -f "VERSION" ]; then
        current_version=$(cat VERSION)
    elif [ -f ".opencode/VERSION" ]; then
        current_version=$(cat .opencode/VERSION)
    fi
    
    # Get latest version from GitHub
    latest_version=$(curl -fsSL "$RAW_URL/VERSION" 2>/dev/null || echo "unknown")
    
    echo ""
    print_info "Current version: $current_version"
    print_info "Latest version: $latest_version"
    
    if [ "$current_version" != "$latest_version" ] && [ "$latest_version" != "unknown" ]; then
        echo ""
        print_info "Update available!"
    fi
}

perform_update() {
    print_info "Checking for updates..."
    
    # Backup current installation
    local backup_dir=".opencode.backup.$(date +%Y%m%d-%H%M%S)"
    
    if [ -d ".opencode" ]; then
        print_info "Creating backup: $backup_dir"
        cp -r .opencode "$backup_dir"
    fi
    
    # Download latest install.sh and run
    print_info "Downloading latest installer..."
    curl -fsSL "$RAW_URL/install.sh" | bash -s -- --profile=full --skip-existing
    
    print_success "Update complete!"
}

main() {
    case "${1:-}" in
        --check)
            check_version
            ;;
        --dry-run)
            print_info "Dry run - would update T-800 ecosystem"
            check_version
            ;;
        *)
            perform_update
            ;;
    esac
}

main "$@"
