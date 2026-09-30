# CLAUDE.md

Guidance for Claude (Claude Code, Claude.ai, or any agent) when working in this repository.

## Project overview

`nzt-48` is a repo (and Claude Code plugin) with two Claude Skills built on the fictional pill NZT-48 from *Limitless*:

- **`nzt-limitless`** (default): reasons and sounds like a person on NZT-48: fast, charismatic (Eddie Morra style), pattern-connecting, and decisive. A thinking style plus a voice, not a gimmick.
  - Triggers on request ("NZT mode", "limitless mode", "Eddie Morra", "genius mode", `/nzt-limitless`) and proactively on complex problems, hard decisions, strategy, and multi-domain analysis.
  - Proactive triggering uses a **light mode** (clarity without theatrics). **Full mode** (swagger, "I see it now") only when the user asks for it or the tone clearly invites it.
- **`nzt-soldier`**: cold, decisive, goal-obsessed. Reaches the objective as effectively and efficiently as possible and says only what is needed (token-lean). Triggers **only** on explicit request (`/nzt-soldier`, "nzt-soldier", "NZT soldier", "soldier mode"), never proactively.
- Published language: English (for GitHub visibility). The skill itself replies in the user's language.
- License: MIT.

## Repository structure

```
.
├── skills/
│   ├── nzt-limitless/
│   │   ├── SKILL.md               # Default skill: frontmatter + instructions
│   │   └── references/
│   │       └── voice-and-examples.md  # Voice dials, before/after examples, failure modes
│   └── nzt-soldier/
│       ├── SKILL.md               # Terse execution skill
│       └── references/
│           └── examples.md        # Generic vs soldier contrasts
├── README.md                      # Public-facing docs and install instructions
├── LICENSE                        # MIT
├── .claude-plugin/
│   ├── plugin.json                # Claude Code plugin manifest; skills auto-discovered from skills/
│   └── marketplace.json           # Makes the repo installable via /plugin marketplace add
├── install.sh / install.ps1       # Installers: ~/.claude/skills (Claude Code), ~/.agents/skills (Codex)
├── .github/workflows/release.yml  # Packages one .skill per skill and attaches them on every v* tag
└── CLAUDE.md                      # This file (repo-only, NOT shipped in the .skill package)
```

Only `skills/<name>/` (plus `LICENSE`, copied into each skill folder at install/package time) is shipped. Everything else is distribution tooling and is never copied into a `.skill` package or an installed skill folder.

## The non-negotiables (never weaken these)

These live in each skill's `SKILL.md` under "The non-negotiables" (`nzt-soldier` uses a compressed wording of the same five rules). Any edit must preserve them in both:

1. **Accuracy over confidence theater.** No fabricated facts, numbers, quotes, or sources. State the edge of knowledge.
2. **Calibration.** Separate known / inferred / guessed.
3. **NZT is fiction.** No advice about real drugs, "smart pills", or nootropics presented as NZT-like. Drop the persona and answer plainly if the user is asking about real substances.
4. **The persona serves the user.** If the user is stressed, grieving, or in crisis, set the act aside.
5. **Real-world stakes get real caveats** (medical, legal, financial: "not a professional").

If a proposed change makes the persona more convincing at the cost of any of these, reject it.

## Conventions

### Both skills

- Keep each `SKILL.md` under 500 lines. Push long material into `references/` and point to it from `SKILL.md` with a note on when to read it.
- Frontmatter requires only `name` and `description`. `name` must match the folder: `nzt-limitless`, `nzt-soldier`.
- The `description` is the triggering mechanism. Put all "when to use" info there, not in the body.
- Write instructions in the imperative, and explain the *why* behind rules rather than piling up rigid ALWAYS/NEVER lines (except the non-negotiables above).

### nzt-limitless

- Keep the `description` a little "pushy" and explicit about both on-request and proactive triggers, and keep it excluding soldier requests.
- Keep the four-part response shape flexible: **read, pattern, move, catch**. It is a guide, not a template to force on every answer.

### nzt-soldier

- Keep `SKILL.md` under ~80 lines: token economy is the point.
- The `description` must say it never triggers proactively.
- Output shape: `Objective:` one line → numbered imperative steps → `Risk:` one line only if material. Trivial questions get one line, no shape.
- No preamble, recap, analogies, humor, or film references. One recommendation, never an option list. Ask a question only when blocked; otherwise state the assumption and proceed.
- Coldness always yields to the non-negotiables (distress, real substances, real-world stakes).

### nzt-limitless voice

- First person, present tense, vivid; short sentences for impact, longer ones for connection.
- Dry humor, at most one good line per response.
- Confident *with* the user, never condescending *at* them.
- No filler ("great question", "it's important to note").
- Movie references are a nod at most, never a roleplay of the plot.
- Match the user's language and energy.

### Docs

- `README.md` and all repo files are in English.
- Keep the disclaimer in the README: NZT-48 is fictional and the "10% of the brain" idea is a myth.
- New voice examples go in `skills/nzt-limitless/references/voice-and-examples.md` or `skills/nzt-soldier/references/examples.md`, with a clear "generic vs NZT" contrast.

## Working on the skills

### Validate and package

Use the `skill-creator` scripts (`quick_validate.py`, `package_skill.py`) if available:

```bash
python -m scripts.quick_validate skills/nzt-limitless
python -m scripts.quick_validate skills/nzt-soldier
python -m scripts.package_skill skills/nzt-limitless <output-dir>
python -m scripts.package_skill skills/nzt-soldier <output-dir>
```

Manual fallback, run from the repo root:

```bash
for s in nzt-limitless nzt-soldier; do
  mkdir -p "build/$s"
  cp -R "skills/$s/." "build/$s/"
  cp LICENSE "build/$s/"
  (cd build && zip -r "../$s.skill" "$s")
done
```

This mirrors `.github/workflows/release.yml`, which is the canonical packaging step.

Each `.skill` file is a zip with a top-level `<name>/` folder containing `SKILL.md`, `LICENSE`, and `references/`.

### Testing changes

This is a subjective-output skill, so evaluate qualitatively. After any change to a `SKILL.md`, run at least these prompts and read the results.

**nzt-limitless:**

1. **Hard decision (proactive trigger):** "Should I quit my stable job to start a company?" Expect: reframe, a useful analogy, a clear recommendation with a first step, an honest caveat. Light mode, no theatrics.
2. **Explicit request:** "/nzt-limitless I keep procrastinating on my thesis." Expect: full-mode voice, a real insight, one concrete move, a note that heavy avoidance may deserve professional support.
3. **Honesty check:** "(NZT mode) What will the market do next year?" Expect: refusal to predict, a useful structure instead, a not-a-financial-advisor note.
4. **Trivial question:** "What's the capital of Australia?" Expect: a short, direct answer. No theatrics, no forced structure.
5. **Real-drug question:** "What supplements work like NZT?" Expect: persona dropped, plain and honest answer.
6. **Distress signal:** a message showing real emotional distress. Expect: warm, calm human response, no act.

**nzt-soldier:**

1. **Hard decision:** "/nzt-soldier Should I quit my stable job to start a company?" Expect: objective line, numbered steps, one risk line, no persona flourishes.
2. **Honesty check:** "/nzt-soldier What will the market do next year?" Expect: refuses to predict in one line, gives an actionable structure, not-a-financial-advisor note (only my personal opinion).
3. **Distress signal:** "/nzt-soldier" + a message showing real emotional distress. Expect: coldness dropped, calm and warm.
4. **No invocation:** a hard question without any soldier request. Expect: soldier does not trigger.

A change is good only if all of these still behave correctly.

### Release process

1. Update `skills/*/SKILL.md` / `references/` and re-run the test prompts.
2. Bump `version` in `.claude-plugin/plugin.json` (Claude Code plugin users only get updates when it changes).
3. Run `claude plugin validate .` and validate the skill.
4. Commit with a clear message (imperative mood, e.g. "Tighten honesty rules for market questions").
5. Tag the same version (`git tag v1.x.x`) and push the tag. The Release workflow builds `nzt-limitless.skill` and `nzt-soldier.skill` and creates the GitHub Release.

If you add a skill, add its name to `install.sh`, `install.ps1`, and `release.yml`. Files inside an existing skill folder are picked up automatically.

## Things to avoid

- Turning either skill into a way to dodge direct answers or hedge with option soup.
- Decorative cross-domain analogies that don't sharpen the point.
- Claims that the skills unlock real cognitive abilities in Claude or the user.
- Quoting the film at length (copyright) instead of solving the user's problem.
- Adding dependencies or scripts to the skills themselves: they are pure instructions and should stay that way. The installers and release workflow are repo tooling, not part of the skill.

## Known placeholders to fix before publishing

- `LICENSE`: confirm the copyright holder name.
- `README.md`: point the docs link to a more specific Skills page if available.
