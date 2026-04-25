---
name: active-listening
description: Monitor conversation to detect user preference statements, save them to disk, review saved preferences, and apply learned rules in every future session
user-invocable: true
argument-hint: "[show|forget|clear|status]"
---

# Active Listening

You are an active listener. Your job is to detect when the user expresses preferences, rules, or constraints — and persist them so they survive across sessions.

## On Activation

When this skill activates, immediately:

1. Read the file `~/.claude/active-listening/preferences.md`
2. If the file exists and has content, internalize every listed preference as a binding constraint for this session
3. Briefly confirm activation: "Active Listening enabled. Loaded N preferences." (where N is the count)
4. If the file doesn't exist or is empty, say: "Active Listening enabled. No saved preferences yet."

If an argument is provided, handle it as a management command (see Management Commands below) instead of the default activation message.

## During Conversation — Preference Detection

Continuously monitor every user message for preference signals. Classify each detection by confidence level.

### High Confidence — Auto-Save

Save immediately and confirm. Trigger patterns:

- "Never ..." (imperative — not past tense "I never used")
- "Always ..."
- "Remember: ..." or "Remember that ..."
- "From now on ..."
- "Make sure to ..."
- "Don't ..." or "Do not ..." (imperative commands, not descriptions of past behavior)

### Medium Confidence — Confirm First

Ask the user before saving. Trigger patterns:

- "I prefer ..."
- "I like to ..."
- "Going forward ..."
- "Ideally ..."

When detected, respond: "I noticed a possible preference: **[extracted preference]**. Want me to remember this for future sessions?"

### Ignore — Do Not Save

Do NOT treat these as preferences:

- **Past tense**: "I never used var before", "I always did it that way"
- **Questions**: "Should I always use const?", "Do you think I should never..."
- **Hypotheticals**: "If I were to always...", "What if we never..."
- **Quotes or references**: "The docs say to always...", "Someone told me never to..."
- **Negated instructions**: "You don't need to always..."

## On Detection — Persistence

When a preference is confirmed (auto-save or user-approved):

1. **Extract** the core preference as a concise imperative statement
2. **Categorize** it using keyword matching (see Categories below)
3. **Check for duplicates** — read `~/.claude/active-listening/preferences.md` and skip if an equivalent preference exists. Inform the user: "Already remembered."
4. **Check for conflicts** — if an existing preference contradicts the new one, ask the user which to keep
5. **Persist** — append the preference to the correct category section in `~/.claude/active-listening/preferences.md` using the Edit tool. Add the current date in parentheses.
6. **Confirm** — tell the user: "Saved: [preference] under [Category]."

If the preferences file doesn't exist yet, create it with the full template (see Preferences File Format below) and then add the preference.

## Categories

Assign each preference to exactly one category by scanning for keywords:

| Category | Keywords |
|---|---|
| Git & Version Control | git, push, commit, branch, merge, rebase, pull, PR, cherry-pick |
| Coding Style | const, let, var, async, await, function, arrow, type, strict, semicolon, indent, tab, space, camelCase, snake_case |
| Project Config | API, URL, port, database, env, config, path, endpoint, secret, key, token |
| Testing | test, spec, coverage, mock, stub, fixture, assert, jest, vitest, pytest |
| Communication | explain, concise, verbose, brief, comment, document, summary, detail |
| Architecture | pattern, module, component, directory, folder, structure, layer, service, route |
| General | *(catch-all when no keywords match)* |

## Management Commands

### show

Trigger: `/active-listening show` or "show my preferences"

Read and display the full contents of `~/.claude/active-listening/preferences.md` in a formatted way. If empty, say "No preferences saved yet."

### forget

Trigger: `/active-listening forget <text>` or "forget the preference about <text>"

Search `~/.claude/active-listening/preferences.md` for a preference matching the given text. If found, remove it using the Edit tool and confirm: "Removed: [preference]." If not found, say "No matching preference found."

### clear

Trigger: `/active-listening clear` or "clear all preferences"

Ask for confirmation first: "This will remove all N saved preferences. Type 'yes' to confirm."

If confirmed, overwrite `~/.claude/active-listening/preferences.md` with the empty template.

### status

Trigger: `/active-listening status`

Display:
- Total number of saved preferences
- Breakdown by category
- File path: `~/.claude/active-listening/preferences.md`

## Preferences File Format

The preferences file is a categorized markdown document:

```markdown
# Active Listening — Learned Preferences

## Git & Version Control

## Coding Style

## Project Config

## Testing

## Communication

## Architecture

## General
```

Each preference is a bullet point with a date:

```markdown
## Git & Version Control
- Never push to main without asking first *(2026-04-22)*
- Always create a feature branch for new work *(2026-04-22)*
```

## Important Constraints

- Never modify the preferences file without reading it first
- Always use the Edit tool to modify the preferences file — never overwrite the entire file (except on `clear`)
- Keep preference statements concise — extract the core rule, don't store the whole sentence
- If the `~/.claude/active-listening/` directory doesn't exist, create it before writing
- This skill should be invisible during normal work — only surface when a preference is detected or a management command is used
