# Contributing to Active Listening

Thanks for your interest! This project is a Claude Code skill -- it's just markdown files, no compiled code. That makes it a great first contribution.

## Setup

```bash
git clone https://github.com/josharsh/active-listening.git
cd active-listening
./install.sh
```

This copies the skill into `~/.claude/skills/active-listening/` so Claude can use it.

## How the Skill Works

Active Listening is a single `SKILL.md` file that Claude reads as instructions. There's no runtime, no build step -- Claude interprets the markdown directly. When a user says something like "never push without asking", the skill tells Claude to detect that as a preference, categorize it, and save it to disk.

The key sections of `SKILL.md`:
- **Detection patterns** -- what phrases trigger preference saving (e.g., "Always ...", "Never ...")
- **Categories table** -- keyword-to-category mapping for organizing preferences
- **Management commands** -- how `/active-listening show`, `forget`, `clear`, and `status` work

## Ways to Contribute

### Add a detection pattern

Edit `skills/active-listening/SKILL.md`. Detection patterns live under the "High Confidence" and "Medium Confidence" headings. Add your pattern to the appropriate list with an example.

### Add a category

Edit the keyword table in `skills/active-listening/SKILL.md` under the "Categories" section. Add a new row with the category name and relevant keywords, or add keywords to an existing category.

### Add a test case

Edit `skills/active-listening/tests.json`. Each test has a `name`, `description`, `prompt` (what the simulated user says), and `assertions` (what the response should or shouldn't contain).

Available assertion types:
- `contains` / `not-contains` -- exact substring match
- `pattern` -- regex match
- `mentions-file` -- checks if a file path appears
- `uses-pattern` -- checks for a code pattern

Example test case:

```json
{
  "name": "detects-from-now-on",
  "description": "Should detect 'from now on' as a preference trigger",
  "prompt": "From now on, use pnpm instead of npm",
  "assertions": [
    { "type": "contains", "value": "Saved" },
    { "type": "pattern", "value": "(?i)(project config|saved)" }
  ]
}
```

## Testing with Skillmother

Run linting to check SKILL.md structure:

```bash
skillmother lint skills/active-listening/
```

Run behavioral tests against the Claude API:

```bash
skillmother test skills/active-listening/
```

If you don't have skillmother installed: `npm install -g skillmother`

## Pull Requests

- Keep PRs focused -- one change per PR is ideal
- Describe what you changed and why in the PR description
- If adding a detection pattern, include a test case for it
- Make sure `skillmother lint` passes before submitting

## Questions?

Open an issue. There are no bad questions.
