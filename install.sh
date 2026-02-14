#!/usr/bin/env bash

#############################################################################
# T-800 Ecosystem Installer
# Interactive installer with profile-based installation
#
# Compatible with:
# - macOS (bash 3.2+)
# - Linux (bash 3.2+)
# - Windows (Git Bash, WSL)
#############################################################################

set -e

# Detect platform
PLATFORM="$(uname -s)"
case "$PLATFORM" in
    Linux*)     PLATFORM="Linux";;
    Darwin*)    PLATFORM="macOS";;
    CYGWIN*|MINGW*|MSYS*) PLATFORM="Windows";;
    *)          PLATFORM="Unknown";;
esac

# Colors for output
if [ "$PLATFORM" = "Windows" ] && [ -z "$WT_SESSION" ] && [ -z "$ConEmuPID" ]; then
    RED=''; GREEN=''; YELLOW=''; BLUE=''; CYAN=''; BOLD=''; NC=''
else
    RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'
    BLUE='\033[0;34m'; CYAN='\033[0;36m'; BOLD='\033[1m'
    NC='\033[0m'
fi

# Configuration
REPO_URL="https://github.com/zarigata/skynetcode"
BRANCH="${T800_BRANCH:-main}"
RAW_URL="https://raw.githubusercontent.com/zarigata/skynetcode/${BRANCH}"
INSTALL_DIR="${T800_INSTALL_DIR:-.opencode}"
TEMP_DIR="/tmp/t800-installer-$$"

# Cleanup temp directory on exit
trap 'rm -rf "$TEMP_DIR" 2>/dev/null || true' EXIT INT TERM

# Global variables
SELECTED_PROFILE=""
NON_INTERACTIVE=false

#############################################################################
# Utility Functions
#############################################################################

print_header() {
    echo -e "${CYAN}${BOLD}"
    echo "╔════════════════════════════════════════════════════════════════╗"
    echo "║                                                                ║"
    echo "║           T-800 Ecosystem Installer v2.0.0                    ║"
    echo "║           \"Think Before You Build\"                            ║"
    echo "║                                                                ║"
    echo "╚════════════════════════════════════════════════════════════════╝"
    echo -e "${NC}"
}

print_success() { echo -e "${GREEN}✓${NC} $1"; }
print_error() { echo -e "${RED}✗${NC} $1"; }
print_info() { echo -e "${BLUE}ℹ${NC} $1"; }
print_warning() { echo -e "${YELLOW}⚠${NC} $1"; }
print_step() { echo -e "\n${MAGENTA}${BOLD}▶${NC} $1\n"; }

#############################################################################
# Dependency Checks
#############################################################################

check_bash_version() {
    local bash_version="${BASH_VERSION%%.*}"
    if [ "$bash_version" -lt 3 ]; then
        echo "Error: This script requires Bash 3.2 or higher"
        echo "Current version: $BASH_VERSION"
        exit 1
    fi
}

check_dependencies() {
    print_step "Checking dependencies..."
    
    local missing_deps=()
    
    if ! command -v curl &> /dev/null; then missing_deps+=("curl"); fi
    if ! command -v jq &> /dev/null; then missing_deps+=("jq"); fi
    
    if [ ${#missing_deps[@]} -ne 0 ]; then
        print_error "Missing dependencies: ${missing_deps[*]}"
        echo ""
        echo "Install with:"
        case "$PLATFORM" in
            macOS) echo "  brew install ${missing_deps[*]}" ;;
            Linux) echo "  sudo apt-get install ${missing_deps[*]}" ;;
            Windows) echo "  Use Git Bash or WSL" ;;
        esac
        exit 1
    fi
    
    print_success "All dependencies found"
}

#############################################################################
# Registry Functions
#############################################################################

fetch_registry() {
    print_step "Fetching component registry..."
    
    mkdir -p "$TEMP_DIR"
    
    # Try local registry first, then remote
    if [ -f "./registry.json" ]; then
        cp "./registry.json" "$TEMP_DIR/registry.json"
        print_success "Using local registry"
    else
        if ! curl -fsSL "$RAW_URL/registry.json" -o "$TEMP_DIR/registry.json"; then
            print_error "Failed to fetch registry"
            exit 1
        fi
        print_success "Registry fetched from GitHub"
    fi
}

get_profile_components() {
    local profile=$1
    jq -r ".profiles.${profile}.components[]?" "$TEMP_DIR/registry.json"
}

get_component_info() {
    local component_id=$1
    local component_type=$2
    local registry_key="${component_type}s"
    
    jq -r ".components.${registry_key}[]? | select(.id == \"${component_id}\")" "$TEMP_DIR/registry.json"
}

#############################################################################
# Profile Selection
#############################################################################

show_profile_menu() {
    clear
    print_header
    
    echo -e "${BOLD}Available Installation Profiles:${NC}\n"
    
    echo -e "  ${GREEN}1) Essential${NC}"
    echo "     Core T-800 agent only - minimal footprint"
    echo -e "     Components: 1\n"
    
    echo -e "  ${BLUE}2) Developer${NC} ${GREEN}[Recommended]${NC}"
    echo "     All 4 agents + skills + standard contexts"
    echo -e "     Components: 14\n"
    
    echo -e "  ${CYAN}3) Business${NC}"
    echo "     Developer + learning module"
    echo -e "     Components: 17\n"
    
    echo -e "  ${MAGENTA}4) Full${NC}"
    echo "     Business + telemetry + recovery + patterns"
    echo -e "     Components: 27\n"
    
    echo -e "  ${YELLOW}5) Advanced${NC}"
    echo "     Full + enhancement integration guides"
    echo -e "     Components: 29\n"
    
    echo "  6) Exit"
    echo ""
    read -r -p "Enter your choice [1-6]: " choice
    
    case $choice in
        1) SELECTED_PROFILE="essential" ;;
        2) SELECTED_PROFILE="developer" ;;
        3) SELECTED_PROFILE="business" ;;
        4) SELECTED_PROFILE="full" ;;
        5) SELECTED_PROFILE="advanced" ;;
        6) exit 0 ;;
        *) print_error "Invalid choice"; sleep 2; show_profile_menu ;;
    esac
}

#############################################################################
# Installation
#############################################################################

perform_installation() {
    print_step "Installing T-800 ecosystem..."
    
    # Create base directory
    mkdir -p "$INSTALL_DIR"
    
    # Get components for profile
    local components
    components=$(get_profile_components "$SELECTED_PROFILE")
    
    local installed=0
    local failed=0
    
    # Process each component
    while IFS= read -r component; do
        [ -z "$component" ] && continue
        
        local type="${component%%:*}"
        local id="${component##*:}"
        
        # Get component info
        local path
        path=$(jq -r ".components.${type}s[]? | select(.id == \"${id}\") | .path" "$TEMP_DIR/registry.json" 2>/dev/null)
        
        if [ -z "$path" ] || [ "$path" = "null" ]; then
            print_warning "Component not found: $component"
            failed=$((failed + 1))
            continue
        fi
        
        local dest="${INSTALL_DIR}/${path#.opencode/}"
        local dest_dir=$(dirname "$dest")
        
        # Create directory
        mkdir -p "$dest_dir"
        
        # Copy file
        if [ -f "$path" ]; then
            cp "$path" "$dest"
            print_success "Installed: $id"
            installed=$((installed + 1))
        else
            print_warning "File not found: $path"
            failed=$((failed + 1))
        fi
    done <<< "$components"
    
    echo ""
    print_info "Installation complete!"
    print_info "Installed: $installed components"
    if [ $failed -gt 0 ]; then
        print_warning "Failed: $failed components"
    fi
}

#############################################################################
# CLI Arguments
#############################################################################

parse_args() {
    while [[ $# -gt 0 ]]; do
        case $1 in
            essential|developer|business|full|advanced)
                SELECTED_PROFILE="$1"
                NON_INTERACTIVE=true
                shift
                ;;
            --profile=*)
                SELECTED_PROFILE="${1#*=}"
                NON_INTERACTIVE=true
                shift
                ;;
            --help|-h)
                echo "Usage: $0 [PROFILE|--profile=PROFILE]"
                echo ""
                echo "Profiles: essential, developer (default), business, full, advanced"
                echo ""
                echo "Examples:"
                echo "  $0 developer        # Install developer profile"
                echo "  $0 --profile=full   # Install full profile"
                exit 0
                ;;
            --dry-run)
                fetch_registry
                echo "Profile: $SELECTED_PROFILE"
                echo "Components:"
                get_profile_components "${SELECTED_PROFILE:-developer}"
                exit 0
                ;;
            *)
                shift
                ;;
        esac
    done
}

#############################################################################
# Main Entry Point
#############################################################################

main() {
    check_bash_version
    
    # Parse arguments
    parse_args "$@"
    
    print_header
    
    check_dependencies
    fetch_registry
    
    # If no profile selected, show menu
    if [ -z "$SELECTED_PROFILE" ]; then
        show_profile_menu
    fi
    
    print_info "Installing profile: ${SELECTED_PROFILE}"
    
    perform_installation
    
    echo ""
    echo -e "${GREEN}${BOLD}T-800 Ecosystem installed successfully!${NC}"
    echo ""
    echo "Quick start:"
    echo "  opencode --agent t800 \"Your project description\""
    echo ""
}

main "$@"
