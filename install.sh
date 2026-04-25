#!/usr/bin/env bash
set -euo pipefail

SKILL_DIR="$HOME/.claude/skills/active-listening"
DATA_DIR="$HOME/.claude/active-listening"
SOURCE_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "Installing Active Listening skill..."

# Create directories
mkdir -p "$SKILL_DIR"
mkdir -p "$DATA_DIR"

# Copy skill files
cp "$SOURCE_DIR/skills/active-listening/SKILL.md" "$SKILL_DIR/SKILL.md"
cp "$SOURCE_DIR/skills/active-listening/tests.json" "$SKILL_DIR/tests.json"

# Seed empty preferences file if it doesn't exist
if [ ! -f "$DATA_DIR/preferences.md" ]; then
  cat > "$DATA_DIR/preferences.md" << 'EOF'
# Active Listening — Learned Preferences

## Git & Version Control

## Coding Style

## Project Config

## Testing

## Communication

## Architecture

## General
EOF
  echo "Created preferences file at $DATA_DIR/preferences.md"
fi

echo ""
echo "Active Listening installed successfully!"
echo ""
echo "Usage:"
echo "  /active-listening          — activate and load saved preferences"
echo "  /active-listening show     — display all preferences"
echo "  /active-listening forget   — remove a specific preference"
echo "  /active-listening clear    — reset all preferences"
echo "  /active-listening status   — show stats"
echo ""
echo "Preferences are stored at: $DATA_DIR/preferences.md"
echo "Skill is installed at: $SKILL_DIR/SKILL.md"
