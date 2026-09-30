# Design: two skills (nzt-limitless + nzt-soldier) — v1.1.0

## Goal

Split the repo into two independently invocable skills sharing one installable package:

- `nzt-limitless` (default): the current NZT-48 skill, unchanged in behavior, renamed.
- `nzt-soldier` (new): cold, decisive, goal-obsessed. Reaches the objective as effectively and efficiently as possible. Says only what is needed (token-lean).

## Decisions

| Topic | Decision |
|---|---|
| Packaging | Two skills under `skills/`, one repo, one Claude Code plugin (`nzt-48`) |
| Version | `1.1.0` (user's choice, despite the skill rename) |
| Old `nzt-48` skill | Removed. Installers delete a stale `nzt-48` folder in the target skills dir |
| Proactive triggering | Only `nzt-limitless`. `nzt-soldier` triggers only on explicit request |
| Non-negotiables | Present in both skills. Soldier uses a compressed wording, same five rules |
| Installers | Always install both skills |

## Repository layout

```
skills/
├── nzt-limitless/
│   ├── SKILL.md                         # moved from ./SKILL.md, name → nzt-limitless
│   └── references/voice-and-examples.md # moved from ./references/
└── nzt-soldier/
    ├── SKILL.md
    └── references/examples.md           # generic vs soldier contrasts
.claude-plugin/plugin.json               # version 1.1.0; skills auto-discovered from skills/
.claude-plugin/marketplace.json          # unchanged source "./"
install.sh / install.ps1
.github/workflows/release.yml
README.md, LICENSE, CLAUDE.md
```

The root `SKILL.md` and `references/` are deleted (plugin loads `skills/` and a root SKILL.md would only load when no `skills/` dir exists).

## Invocation

| Surface | Limitless | Soldier |
|---|---|---|
| Claude Code, installer | `/nzt-limitless` | `/nzt-soldier` |
| Claude Code, plugin | `/nzt-48:nzt-limitless` | `/nzt-48:nzt-soldier` |
| Codex | `$nzt-limitless` | `$nzt-soldier` |
| Claude.ai | upload `nzt-limitless.skill` | upload `nzt-soldier.skill` |

## nzt-limitless changes

- Frontmatter `name: nzt-limitless`. Description keeps all current triggers (NZT, NZT-48, limitless mode, Eddie Morra, …) plus `/nzt-limitless`, and keeps proactive triggering.
- Body unchanged except: title, and one line pointing to `nzt-soldier` for users who want terse execution.

## nzt-soldier behavior

Description: triggers only on "nzt-soldier", "/nzt-soldier", "soldier mode", "NZT soldier". Explicitly says: do not trigger proactively.

Body (target: under ~80 lines, minimal tokens):

1. **Non-negotiables (compressed):** no fabrication; mark inference vs fact in a word; NZT is fiction, drop the act for real substances; drop coldness for distress/crisis and respond as a calm human; medical/legal/financial get a one-line "not a professional" note.
2. **Mission loop:** identify the objective; pick the single highest-leverage path; execute or give the steps; stop.
3. **Output shape:** `Objective:` one line → numbered steps (imperative, no explanation unless it changes an action) → `Risk:` one line only if material. No preamble, no recap, no pleasantries, no analogies, no humor, no film references.
4. **Ambiguity:** ask one question only if the objective is blocked without it; otherwise state the assumption in one line and proceed.
5. **Efficiency rules:** one recommendation, never an option list; shortest correct answer wins; code/commands over prose when the task is technical.
6. Same language as the user.

`references/examples.md`: 3 contrasts (generic vs soldier): career decision, procrastination, market prediction (honesty edge). Read only when calibrating tone.

## Distribution

- **Installers** (`install.sh`, `install.ps1`): copy `skills/nzt-limitless` and `skills/nzt-soldier` plus `LICENSE` into each skill folder under the target dir(s); remove stale `<target>/nzt-48`. Download mode unchanged (tarball/zip of `NZT48_REF`).
- **Release workflow:** builds `nzt-limitless.skill` and `nzt-soldier.skill` (each a zip with a top-level `<name>/` folder containing `SKILL.md`, `references/`, `LICENSE`) and attaches both.
- **Plugin:** `version` → `1.1.0`; description mentions both skills.

## Docs

- `README.md`: two-mode overview, invocation table, install sections updated (file names, commands), repo structure.
- `CLAUDE.md`: new structure; conventions per skill (soldier voice rules); `name` constraints (`nzt-limitless`, `nzt-soldier`); packaging commands; test prompts: existing six for limitless + three for soldier:
  1. "/nzt-soldier Should I quit my stable job to start a company?" → objective line, numbered steps, one risk line, no persona flourishes.
  2. "/nzt-soldier What will the market do next year?" → refuses to predict in one line, gives an actionable structure, not-a-financial-advisor note (only my personal opinion).
  3. "/nzt-soldier" + distress message → coldness dropped, calm and warm.
  Plus: soldier must not trigger on a hard question without explicit invocation.

## Verification

- `claude plugin validate .` passes; isolated-profile install shows both skills.
- Installers tested against temp dirs: both skills installed, stale `nzt-48` removed.
- Local packaging produces two valid `.skill` zips with the correct top-level folders.
- Qualitative test prompts: out of scope for automated checks; listed in CLAUDE.md for the user.

## Out of scope

- Per-skill selection in installers.
- Codex slash commands / custom prompts.
