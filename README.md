# Active Listening

A Claude Code skill that detects your preferences during conversation and remembers them across sessions.

Say things like "never push without asking" or "always use const" — Active Listening saves them to disk and applies them in every future conversation.

## Install

**Via Claude Code plugin system (recommended):**
```
/plugin marketplace add https://github.com/josharsh/active-listening
```

**Via install script:**
```bash
git clone https://github.com/josharsh/active-listening.git
cd active-listening
./install.sh
```

**Manual:** Copy `skills/active-listening/SKILL.md` to `~/.claude/skills/active-listening/`.

## How It Works

Active Listening monitors your messages for preference patterns:

**Auto-saved** (high confidence):
- "Never push to main without asking"
- "Always use strict mode"
- "Remember: our API is on port 3001"
- "From now on, use vitest instead of jest"
- "Make sure to run lint before committing"
- "Don't use any in TypeScript"

**Confirmed first** (medium confidence):
- "I prefer tabs over spaces"
- "I like to keep functions small"
- "Going forward, let's use pnpm"

**Ignored** (not preferences):
- Past tense: "I never used var before"
- Questions: "Should I always use const?"
- Hypotheticals: "If I were to always..."

## Demo

```
❯ /plugin marketplace add https://github.com/josharsh/active-listening
  ⎿  Successfully added marketplace: active-listening

❯ /active-listening
⏺ Active Listening enabled. No saved preferences yet.

❯ Please ensure that when I ask you to code in mobile native design language
  you follow the mobile native guidelines by google mobile design and apple
  mobile design. (in terms of scale, spacing, fonts, and clean UI design
  principles for mobile screens)

⏺ I noticed a preference: Follow Google Material Design and Apple HIG
  guidelines for scale, spacing, fonts, and clean UI when coding mobile
  native designs.

  This is a clear directive — saving it now.

⏺ Update(~/.claude/active-listening/preferences.md)
  ⎿  ## Architecture
     +- Follow Google Material Design and Apple HIG guidelines (scale,
     +  spacing, fonts, clean UI) when coding mobile native designs
     +  *(2026-04-26)*

⏺ Saved: Follow Google Material Design and Apple HIG guidelines (scale,
  spacing, fonts, clean UI) when coding mobile native designs under
  Architecture.
```

Every future session with `/active-listening` will load this preference automatically.

## Commands

| Command | What it does |
|---|---|
| `/active-listening` | Activate and load saved preferences |
| `/active-listening show` | Display all categorized preferences |
| `/active-listening forget <text>` | Remove a specific preference |
| `/active-listening clear` | Reset all preferences (with confirmation) |
| `/active-listening status` | Show count and categories |

You can also use natural language: "show my preferences", "forget the preference about pushing", "clear all preferences".

## Preferences File

Preferences are stored as categorized markdown at `~/.claude/active-listening/preferences.md`:

```markdown
# Active Listening — Learned Preferences

## Git & Version Control
- Never push to main without asking first *(2026-04-22)*

## Coding Style
- Always use const over let *(2026-04-22)*

## Project Config
- API runs on port 3001 *(2026-04-22)*
```

Categories are auto-assigned by keyword detection: Git & Version Control, Coding Style, Project Config, Testing, Communication, Architecture, and General (catch-all).

## Testing

Tests are defined in `tests.json` and compatible with [skillmother](https://github.com/josharsh/skillmother):

```bash
skillmother test ~/Development/active-listening/
```

## How Preferences Are Applied

When you start a new conversation and activate the skill (`/active-listening`), it reads the preferences file and applies all saved rules as constraints for that session. No background processes, no servers — just a skill that reads a file.

## Uninstalling

```bash
rm -rf ~/.claude/skills/active-listening
rm -rf ~/.claude/active-listening  # also removes saved preferences
```
