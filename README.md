# Active Listening

A human-readable preference manager for Claude Code. Detects what you care about, organizes it, and gives you full control.

Say things like "never push without asking" or "always use const" — Active Listening saves them to a categorized markdown file you can read, edit, share, and version control.

## Install

In Claude Code, run:

```
/plugin marketplace add josharsh/active-listening
```

Or manually:

```bash
mkdir -p ~/.claude/skills/active-listening
curl -sL https://raw.githubusercontent.com/josharsh/active-listening/main/skills/active-listening/SKILL.md \
  -o ~/.claude/skills/active-listening/SKILL.md
```

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
❯ /plugin marketplace add josharsh/active-listening
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
| `/active-listening status` | Show count, categories, and sync status |
| `/active-listening no-sync` | Stop writing to CLAUDE.local.md |
| `/active-listening sync` | Resume writing to CLAUDE.local.md |

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

## Why Not Just Use CLAUDE.md or Auto Memory?

Claude Code has built-in memory (Auto Memory, `/remember`, CLAUDE.md). They work. Active Listening is different in a few specific ways:

**Transparency.** Auto Memory writes to an opaque MEMORY.md that you don't control. Active Listening writes to a categorized markdown file — you see exactly what was saved and why.

**Precision.** Auto Memory captures everything it thinks is useful. Active Listening specifically targets preference statements with confidence tiers — auto-saving "Never push without asking" while confirming "I prefer tabs over spaces" and ignoring "I never used var before."

**Management.** No other tool gives you `show`, `forget`, `clear`, and `status` commands for your preferences. You can review what Claude learned, remove things that are wrong, and start fresh.

**Zero infrastructure.** No SQLite, no MCP server, no hooks, no background processes. One SKILL.md file. Works anywhere Claude Code runs.

**Portability.** Your preferences file is plain markdown. Copy it to another machine, commit it to a dotfiles repo, or share team conventions with colleagues.

If Auto Memory and CLAUDE.md cover your needs, use them — they're great. Active Listening is for people who want to see and manage what Claude remembers about them.

## CLAUDE.local.md Sync

By default, Active Listening also writes every preference to `CLAUDE.local.md` in your project. This means preferences work automatically in future sessions — even without activating the skill.

```markdown
## Active Listening Preferences
- Never push to main without asking first
- Always use const over let
- API runs on port 3001
```

This enhances Claude Code's built-in system rather than replacing it. Your preferences become first-class instructions that Claude follows from session start.

To disable: `/active-listening no-sync` or just say "don't write to CLAUDE.local.md".

## How Preferences Are Applied

**With CLAUDE.local.md sync (default):** Preferences are applied automatically every session via Claude Code's built-in CLAUDE.local.md loading. No activation needed.

**Without sync:** Activate with `/active-listening` at the start of a session to read the preferences file and apply all saved rules as constraints.

## Uninstalling

```bash
rm -rf ~/.claude/skills/active-listening
rm -rf ~/.claude/active-listening  # also removes saved preferences
```
