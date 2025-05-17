#!/usr/bin/env bash

# Run this, to setup prettier and editorconfig in your current project (usually my second commit after inti script of framework / library)

# - copy file from https://raw.githubusercontent.com/tobiaskraus/tk-boilerplate/refs/heads/main/editorconfig/.editorconfig into current dictionary
# - copy file from https://raw.githubusercontent.com/tobiaskraus/tk-boilerplate/refs/heads/main/prettier/.prettierrc into current dict
# - ask interactively if I want to install via bun, yarn, npm or pnpm
# - install prettier
# - add script into package.json: "format:write": "bun prettier . --write" (or other package-manager chosen before)
# - execute this script



set -eo pipefail # Exit on error, treat unset variables as an error, and propagate pipe failures

# --- Configuration ---
EDITORCONFIG_URL="https://raw.githubusercontent.com/tobiaskraus/tk-boilerplate/refs/heads/main/editorconfig/.editorconfig"
PRETTIERRC_URL="https://raw.githubusercontent.com/tobiaskraus/tk-boilerplate/refs/heads/main/prettier/.prettierrc"
PRETTIER_PACKAGE="prettier"

# --- Helper Functions ---
info() {
  echo -e "\033[34m[INFO]\033[0m $1"
}

success() {
  echo -e "\033[32m[SUCCESS]\033[0m $1"
}

warn() {
  echo -e "\033[33m[WARN]\033[0m $1"
}

error() {
  echo -e "\033[31m[ERROR]\033[0m $1" >&2
  exit 1
}

# --- Prerequisite Checks ---
check_command() {
  if ! command -v "$1" &> /dev/null; then
    error "$1 could not be found. Please install it first."
  fi
}

check_command "curl"
check_command "jq" # jq is used for safely editing package.json

# --- Main Logic ---

# 1. Copy .editorconfig
info "Downloading .editorconfig..."
if curl -fsSL "$EDITORCONFIG_URL" -o .editorconfig; then
  success ".editorconfig downloaded."
else
  error "Failed to download .editorconfig."
fi

# 2. Copy .prettierrc
info "Downloading .prettierrc..."
if curl -fsSL "$PRETTIERRC_URL" -o .prettierrc; then
  success ".prettierrc downloaded."
else
  error "Failed to download .prettierrc."
fi

# 3. Ask for package manager
info "Choose a package manager to install Prettier:"
options=("bun" "yarn" "npm" "pnpm" "skip")
COLUMNS=1 # For select to display options vertically
select opt in "${options[@]}"; do
  case "$opt" in
    "bun")
      PKG_MANAGER="bun"
      INSTALL_CMD="bun add -D"
      RUN_CMD_PREFIX="bun run"
      INIT_CMD="bun init -y"
      PRETTIER_EXEC_CMD="bun prettier"
      break
      ;;
    "yarn")
      PKG_MANAGER="yarn"
      INSTALL_CMD="yarn add -D"
      RUN_CMD_PREFIX="yarn" # yarn run is often optional for scripts
      INIT_CMD="yarn init -y"
      PRETTIER_EXEC_CMD="yarn prettier"
      break
      ;;
    "npm")
      PKG_MANAGER="npm"
      INSTALL_CMD="npm install -D"
      RUN_CMD_PREFIX="npm run"
      INIT_CMD="npm init -y"
      PRETTIER_EXEC_CMD="npx prettier" # npm typically uses npx to run package binaries
      break
      ;;
    "pnpm")
      PKG_MANAGER="pnpm"
      INSTALL_CMD="pnpm add -D"
      RUN_CMD_PREFIX="pnpm" # pnpm run is often optional
      INIT_CMD="pnpm init" # pnpm init doesn't have a -y, but is non-interactive
      PRETTIER_EXEC_CMD="pnpm prettier"
      break
      ;;
    "skip")
      info "Skipping Prettier installation and package.json modification."
      success "tk-init finished."
      exit 0
      ;;
    *)
      warn "Invalid option $REPLY. Please choose a number from the list."
      ;;
  esac
done

# Check if the chosen package manager is installed
check_command "$PKG_MANAGER"
info "Using $PKG_MANAGER."

# Ensure package.json exists
if [ ! -f "package.json" ]; then
  warn "package.json not found."
  read -p "Do you want to create it using '$INIT_CMD'? (y/N) " confirm_init
  if [[ "$confirm_init" =~ ^[Yy]$ ]]; then
    info "Initializing package.json with $PKG_MANAGER..."
    if $INIT_CMD; then
      success "package.json initialized."
    else
      error "Failed to initialize package.json."
    fi
  else
    error "package.json is required to proceed. Please create one manually or allow initialization."
  fi
fi

# 4. Install Prettier
info "Installing Prettier using $PKG_MANAGER..."
if $INSTALL_CMD $PRETTIER_PACKAGE; then
  success "Prettier installed successfully."
else
  error "Failed to install Prettier."
fi

# 5. Add script to package.json
SCRIPT_NAME="format:write"
SCRIPT_COMMAND="$PRETTIER_EXEC_CMD . --write"

info "Adding '$SCRIPT_NAME' script to package.json..."
# Use jq to safely add/update the script
# This creates the "scripts" object if it doesn't exist
if jq --arg name "$SCRIPT_NAME" --arg cmd "$SCRIPT_COMMAND" \
  '.scripts //= {} | .scripts[$name] = $cmd' \
  package.json > package.json.tmp && mv package.json.tmp package.json; then
  success "Script '$SCRIPT_NAME': '$SCRIPT_COMMAND' added to package.json."
else
  error "Failed to add script to package.json. Make sure package.json is valid."
fi

# 6. Execute the script
info "Executing '$SCRIPT_NAME' script ($RUN_CMD_PREFIX $SCRIPT_NAME)..."
if $RUN_CMD_PREFIX "$SCRIPT_NAME"; then
  success "Script '$SCRIPT_NAME' executed successfully."
else
  # Don't exit with error here, as formatting might "fail" if there are issues,
  # but the setup itself was successful.
  warn "Script '$SCRIPT_NAME' execution finished, possibly with formatting issues. Please check the output."
fi

success "tk-init setup complete!"
