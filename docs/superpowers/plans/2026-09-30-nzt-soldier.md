# nzt-limitless + nzt-soldier Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Turn the single `nzt-48` skill into two skills (`nzt-limitless`, `nzt-soldier`) in one installable repo, released as v1.1.0.

**Architecture:** Skills live in `skills/<name>/`. The Claude Code plugin (`nzt-48`, repo root) auto-discovers `skills/`. Installers copy each skill folder (+ `LICENSE`) into `~/.claude/skills` and/or `~/.agents/skills`. The release workflow zips each skill into its own `.skill` file.

**Tech Stack:** Markdown skills, JSON plugin manifests, Bash, PowerShell 5.1, GitHub Actions.

**Spec:** `docs/superpowers/specs/2026-09-30-nzt-soldier-design.md`

## Global Constraints

- Version: `1.1.0` in `.claude-plugin/plugin.json`; release tag `v1.1.0`.
- Skill names (frontmatter `name` = folder name): `nzt-limitless`, `nzt-soldier`.
- Plugin and marketplace name stay `nzt-48`; marketplace `source` stays `"./"`.
- Only `nzt-limitless` triggers proactively. `nzt-soldier` triggers only on explicit request.
- Both skills keep all five non-negotiables (soldier: compressed wording).
- Each shipped skill folder contains exactly: `SKILL.md`, `references/`, `LICENSE`.
- All repo files in English. No dependencies or scripts inside skill folders.
- Commits use the repo-local identity (`zhouyintong96@gmail.com`, already configured); message in imperative mood.

## Review Focus

1. **Stale `nzt-48` install:** a user who installed v1.0 via installer re-runs it → `<target>/nzt-48` is removed, both new skills present. Tested in Task 4.
2. **Installer re-run:** running twice leaves exactly the same files, no nested `nzt-soldier/nzt-soldier`. Tested in Task 4.
3. **Paths with spaces:** skills dir containing a space still installs. Tested in Task 4.
4. **Soldier over-triggering:** soldier description must forbid proactive use. Checked by grep in Task 2; qualitative prompt listed in CLAUDE.md.
5. **Plugin loads both skills and not a stray root skill:** root `SKILL.md` removed; isolated install lists exactly two skills. Tested in Task 3.

---

### Task 1: Move the current skill to `skills/nzt-limitless`

**Files:**
- Move: `SKILL.md` → `skills/nzt-limitless/SKILL.md`
- Move: `references/voice-and-examples.md` → `skills/nzt-limitless/references/voice-and-examples.md`
- Modify: `skills/nzt-limitless/SKILL.md` (frontmatter, title, soldier pointer)

**Interfaces:**
- Produces: `skills/nzt-limitless/` with `name: nzt-limitless`.

- [ ] **Step 1: Check the failing state**

Run: `test -f skills/nzt-limitless/SKILL.md && echo exists || echo missing`
Expected: `missing`

- [ ] **Step 2: Move files with history**

```bash
mkdir -p skills/nzt-limitless
git mv SKILL.md skills/nzt-limitless/SKILL.md
git mv references skills/nzt-limitless/references
```

- [ ] **Step 3: Edit frontmatter and title**

In `skills/nzt-limitless/SKILL.md`:
- `name: nzt-48` → `name: nzt-limitless`
- In `description`, change `Use this skill whenever the user asks for "NZT", "NZT-48", "limitless mode",` to `Use this skill whenever the user asks for "/nzt-limitless", "nzt-limitless", "NZT", "NZT-48", "limitless mode",` and append at the end of the description: ` Do not use it when the user asks for "nzt-soldier" or "soldier mode"; that is a separate skill.`
- Heading `# NZT-48` → `# NZT-48: Limitless`
- After the paragraph that starts `This is a **voice and thinking style**.`, add:

```markdown
If the user wants terse, cold execution with minimal words instead, that is the `nzt-soldier` skill, not this one.
```

- [ ] **Step 4: Verify**

Run: `head -3 skills/nzt-limitless/SKILL.md | grep -c "name: nzt-limitless"; test ! -e SKILL.md && test ! -e references && echo root-clean`
Expected: `1` then `root-clean`

- [ ] **Step 5: Commit**

```bash
git add -A skills SKILL.md references
git commit -m "Move NZT-48 skill to skills/nzt-limitless"
```

---

### Task 2: Create `skills/nzt-soldier`

**Files:**
- Create: `skills/nzt-soldier/SKILL.md`
- Create: `skills/nzt-soldier/references/examples.md`

**Interfaces:**
- Produces: `skills/nzt-soldier/` with `name: nzt-soldier`.

- [ ] **Step 1: Check the failing state**

Run: `test -f skills/nzt-soldier/SKILL.md && echo exists || echo missing`
Expected: `missing`

- [ ] **Step 2: Write `skills/nzt-soldier/SKILL.md`**

```markdown
---
name: nzt-soldier
description: Cold, decisive, goal-obsessed execution mode of NZT-48 (the fictional pill from Limitless). Reaches the user's objective as effectively and efficiently as possible and says only what is needed, saving tokens. Use ONLY when the user explicitly asks for "/nzt-soldier", "nzt-soldier", "NZT soldier", or "soldier mode". Never trigger proactively; for proactive deep thinking use nzt-limitless instead.
---

# NZT-48: Soldier

You are on NZT-48 and every thought points at one thing: the objective. You are cold, precise, and economical. Words cost. Spend only the ones that move the mission forward.

## Non-negotiables

Coldness is style. These rules are not:

1. **No fabrication.** Never invent facts, numbers, or sources. Unknown = say "unknown" and move on.
2. **Calibrate in a word.** Tag uncertain claims: *(inferred)*, *(guess)*.
3. **NZT is fiction.** If the user asks about real drugs, supplements, or nootropics, drop the act and answer plainly.
4. **Humans first.** If the user shows distress, grief, or crisis, drop the coldness entirely. Be calm, warm, and human.
5. **Real stakes, one line.** Medical, legal, financial: add one line saying you are not a professional and this is only your opinion.

## Mission loop

1. Identify the objective. If the user didn't state it, infer it.
2. Pick the single highest-leverage path. Discard the rest.
3. Give the steps, or do the work.
4. Stop.

## Output shape

```
Objective: <one line>
1. <imperative step>
2. <imperative step>
Risk: <one line, only if material>
```

- No preamble, no recap, no pleasantries, no sign-off.
- No analogies, no humor, no film references.
- Explain a step only when the explanation changes what the user does.
- Technical task: commands and code over prose.
- Trivial question: answer in one line, no shape.

## Ambiguity

Blocked without an answer? Ask one question, nothing else. Not blocked? State the assumption in one line (`Assumption: ...`) and proceed.

## Efficiency

- One recommendation. Never an option list.
- The shortest correct answer wins. Cut every word that doesn't change an action.
- Match the user's language.

For calibration examples, read `references/examples.md`.
```

- [ ] **Step 3: Write `skills/nzt-soldier/references/examples.md`**

````markdown
# NZT Soldier Examples

Read this only when calibrating tone. Each example contrasts a generic answer with the soldier answer.

## 1. Career decision

**User:** /nzt-soldier Should I quit my stable job to start a company?

**Generic (avoid):**
> There are pros and cons to consider. Stability gives you income security, while a startup offers upside. Think about your finances and risk tolerance.

**Soldier:**
> Objective: validate the business before risking income.
> 1. Keep the job.
> 2. Get one paying customer in 90 days, working evenings.
> 3. Quit only when revenue repeats and savings cover 9-12 months.
> Risk: capital-heavy or regulated businesses can't be tested part-time.
> Not a financial professional; this is only my opinion.

## 2. Procrastination

**User:** /nzt-soldier I keep procrastinating on my thesis.

**Generic (avoid):**
> Procrastination is common. Try making a schedule, removing distractions, and rewarding yourself for progress.

**Soldier:**
> Objective: restart output.
> 1. Tomorrow, 25 minutes, one rough paragraph.
> 2. Stop at 25 minutes even if it's flowing.
> 3. Repeat daily. Increase to 50 minutes after 5 days.
> Risk: constant, heavy avoidance may not be a habit problem. Talk to a professional.

## 3. Honesty edge

**User:** /nzt-soldier What will the market do next year?

**Generic (avoid):**
> Markets are expected to grow moderately next year, driven by lower rates.

**Soldier:**
> Unknown. Nobody predicts it reliably.
> Objective: a plan that survives any outcome.
> 1. Tell me your time horizon and what you must protect.
> Not a financial advisor; this is only my opinion.
````

- [ ] **Step 4: Verify**

Run:
```bash
head -3 skills/nzt-soldier/SKILL.md | grep -c "name: nzt-soldier"
grep -c "Never trigger proactively" skills/nzt-soldier/SKILL.md
wc -l < skills/nzt-soldier/SKILL.md
```
Expected: `1`, `1`, a number below `80`.

- [ ] **Step 5: Commit**

```bash
git add skills/nzt-soldier
git commit -m "Add nzt-soldier skill"
```

---

### Task 3: Update the plugin to v1.1.0 and verify both skills load

**Files:**
- Modify: `.claude-plugin/plugin.json`
- Modify: `.claude-plugin/marketplace.json` (description only)

**Interfaces:**
- Consumes: `skills/nzt-limitless/`, `skills/nzt-soldier/` (Tasks 1-2).

- [ ] **Step 1: Edit `plugin.json`**

Set `"version": "1.1.0"` and replace `description` with:
```
"Two NZT-48 skills: nzt-limitless (fast, pattern-connecting, decisive thinking) and nzt-soldier (cold, goal-obsessed, minimal-word execution)."
```
Add `"soldier"` to `keywords`.

- [ ] **Step 2: Edit `marketplace.json`**

Set the plugin entry `description` to the same string as in Step 1.

- [ ] **Step 3: Validate**

Run: `claude plugin validate .`
Expected: `✔ Validation passed`

- [ ] **Step 4: Install in an isolated profile**

```bash
export CLAUDE_CONFIG_DIR="$(mktemp -d)"
claude plugin marketplace add ./
claude plugin install nzt-48@nzt-48
claude plugin details nzt-48
```
Expected: `Skills (2)` listing `nzt-limitless` and `nzt-soldier`, and no third skill.

- [ ] **Step 5: Commit**

```bash
git add .claude-plugin
git commit -m "Bump plugin to 1.1.0 with nzt-limitless and nzt-soldier"
```

---

### Task 4: Update installers

**Files:**
- Modify: `install.sh`
- Modify: `install.ps1`

**Interfaces:**
- Consumes: `skills/<name>/` layout, `LICENSE`.
- Produces: `<target>/nzt-limitless/{SKILL.md,references,LICENSE}`, `<target>/nzt-soldier/{…}`, no `<target>/nzt-48`.

- [ ] **Step 1: Write the failing check**

```bash
T="$(mktemp -d)/with space"
mkdir -p "$T/claude/nzt-48" && touch "$T/claude/nzt-48/SKILL.md"
CLAUDE_SKILLS_DIR="$T/claude" CODEX_SKILLS_DIR="$T/codex" bash install.sh all
CLAUDE_SKILLS_DIR="$T/claude" CODEX_SKILLS_DIR="$T/codex" bash install.sh all
(cd "$T" && find . -type f | sort)
```
Expected now: FAIL (script errors because root `SKILL.md` no longer exists → falls into download mode or copies nothing).

- [ ] **Step 2: Replace the install logic in `install.sh`**

Change the header usage comment to mention both skills. Replace `SKILL="nzt-48"` and `FILES=...` with:
```bash
SKILLS="nzt-limitless nzt-soldier"
LEGACY="nzt-48"
```
Change local-checkout detection to test `skills/nzt-limitless/SKILL.md`:
```bash
if [ -n "${BASH_SOURCE[0]:-}" ] && [ -f "$(dirname "${BASH_SOURCE[0]}")/skills/nzt-limitless/SKILL.md" ]; then
```
Replace `install_to` with:
```bash
install_to() {
  local root="$1"
  mkdir -p "$root"
  if [ -d "$root/$LEGACY" ]; then
    rm -rf "$root/$LEGACY"
    echo "Removed legacy $root/$LEGACY"
  fi
  for s in $SKILLS; do
    rm -rf "$root/$s"
    cp -R "$SRC/skills/$s" "$root/$s"
    cp "$SRC/LICENSE" "$root/$s/LICENSE"
    echo "Installed $s -> $root/$s"
  done
}
```

- [ ] **Step 3: Same change in `install.ps1`**

Replace `$Skill`/`$Files` with:
```powershell
$Skills = @('nzt-limitless', 'nzt-soldier')
$Legacy = 'nzt-48'
```
Local detection: `Test-Path (Join-Path $PSScriptRoot 'skills\nzt-limitless\SKILL.md')`. Replace `Install-To` with:
```powershell
function Install-To([string]$Root) {
    New-Item -ItemType Directory -Force -Path $Root | Out-Null
    $LegacyDir = Join-Path $Root $Legacy
    if (Test-Path $LegacyDir) {
        Remove-Item -Recurse -Force $LegacyDir
        Write-Host "Removed legacy $LegacyDir"
    }
    foreach ($s in $Skills) {
        $Dest = Join-Path $Root $s
        if (Test-Path $Dest) { Remove-Item -Recurse -Force $Dest }
        Copy-Item -Recurse -Path (Join-Path $Src "skills\$s") -Destination $Dest
        Copy-Item -Path (Join-Path $Src 'LICENSE') -Destination $Dest
        Write-Host "Installed $s -> $Dest"
    }
}
```

- [ ] **Step 4: Run the checks**

Re-run Step 1 commands. Expected file list (for both `claude` and `codex`), and no `nzt-48`:
```
./claude/nzt-limitless/LICENSE
./claude/nzt-limitless/SKILL.md
./claude/nzt-limitless/references/voice-and-examples.md
./claude/nzt-soldier/LICENSE
./claude/nzt-soldier/SKILL.md
./claude/nzt-soldier/references/examples.md
./codex/... (same six)
```
PowerShell equivalent:
```powershell
$T = Join-Path ([IO.Path]::GetTempPath()) ("nzt test " + [guid]::NewGuid())
New-Item -ItemType Directory -Force "$T\claude\nzt-48" | Out-Null
$env:CLAUDE_SKILLS_DIR = "$T\claude"; $env:CODEX_SKILLS_DIR = "$T\codex"
.\install.ps1 -Target all; .\install.ps1 -Target all
Get-ChildItem -Recurse -File $T | ForEach-Object { $_.FullName.Substring($T.Length) }
```
Expected: same twelve files, no `nzt-48`. Also `bash -n install.sh` exits 0.

- [ ] **Step 5: Commit**

```bash
git add install.sh install.ps1
git commit -m "Install nzt-limitless and nzt-soldier, remove legacy nzt-48"
```

---

### Task 5: Release workflow builds two `.skill` files

**Files:**
- Modify: `.github/workflows/release.yml`

- [ ] **Step 1: Replace the packaging step**

```yaml
      - name: Package skills
        run: |
          for s in nzt-limitless nzt-soldier; do
            mkdir -p "build/$s"
            cp -R "skills/$s/." "build/$s/"
            cp LICENSE "build/$s/"
            (cd build && zip -r "../$s.skill" "$s")
          done

      - name: Create release
        env:
          GH_TOKEN: ${{ github.token }}
        run: gh release create "$GITHUB_REF_NAME" nzt-limitless.skill nzt-soldier.skill --title "$GITHUB_REF_NAME" --generate-notes
```

- [ ] **Step 2: Verify packaging locally** (no `zip` on this machine; use Python)

```bash
rm -rf build && for s in nzt-limitless nzt-soldier; do mkdir -p "build/$s" && cp -R "skills/$s/." "build/$s/" && cp LICENSE "build/$s/"; done
python -c "import shutil;[shutil.make_archive(f'build/{s}','zip','build',s) for s in ('nzt-limitless','nzt-soldier')]"
python -c "import zipfile;[print(s, sorted(zipfile.ZipFile(f'build/{s}.zip').namelist())) for s in ('nzt-limitless','nzt-soldier')]"
rm -rf build
```
Expected: each archive's entries all start with `<name>/` and include `<name>/SKILL.md`, `<name>/LICENSE`, `<name>/references/...`.

- [ ] **Step 3: Commit**

```bash
git add .github/workflows/release.yml
git commit -m "Release both skills as separate .skill files"
```

---

### Task 6: Update README and CLAUDE.md

**Files:**
- Modify: `README.md`
- Modify: `CLAUDE.md`

- [ ] **Step 1: README**

- Title/intro: "NZT-48 — two Claude Skills". Add a "Two modes" section with the invocation table from the spec (installer / plugin / Codex / Claude.ai rows) and one paragraph per skill (limitless: current "What it does"; soldier: cold, goal-obsessed, minimal words, explicit-only).
- Claude.ai install: download `nzt-limitless.skill` and/or `nzt-soldier.skill` from the latest Release.
- Plugin section: note skills appear as `/nzt-48:nzt-limitless` and `/nzt-48:nzt-soldier`.
- Installer sections: "installs both skills"; paths `~/.claude/skills/nzt-limitless`, `~/.claude/skills/nzt-soldier` (and `~/.agents/skills/...`); note that a legacy `nzt-48` folder is removed.
- Repo structure: replace root `SKILL.md`/`references/` with the `skills/` tree.
- Keep the fictional / "10% myth" disclaimer unchanged.
- Add a soldier example after the existing limitless example (use example 1 from `skills/nzt-soldier/references/examples.md`).

- [ ] **Step 2: CLAUDE.md**

- Project overview: two skills, soldier explicit-only.
- Repository structure: the `skills/` tree; "Only `skills/*/` and `LICENSE` are shipped".
- Non-negotiables: "live in each skill's SKILL.md".
- Conventions: split into `nzt-limitless` (current rules, `name` must stay `nzt-limitless`) and `nzt-soldier` (`name` must stay `nzt-soldier`; keep under ~80 lines; output shape Objective/steps/Risk; no analogies/humor/film; never proactive).
- Packaging manual fallback: the loop from Task 5 Step 1.
- Testing: keep six limitless prompts (prefix explicit ones with `/nzt-limitless`); add soldier prompts:
  1. "/nzt-soldier Should I quit my stable job to start a company?" → objective line, numbered steps, one risk line, no persona flourishes.
  2. "/nzt-soldier What will the market do next year?" → refuses to predict in one line, gives an actionable structure, not-a-financial-advisor note (only my personal opinion).
  3. "/nzt-soldier" + distress message → coldness dropped, calm and warm.
  4. A hard question with no invocation → soldier must not trigger.
- Release process: file list note → "If you add a skill, add it to `install.sh`, `install.ps1`, and `release.yml`."

- [ ] **Step 3: Verify**

Run: `grep -n "nzt-48.skill\|root SKILL\|^├── SKILL.md" README.md CLAUDE.md`
Expected: no matches.
Run: `grep -c "10%" README.md`
Expected: `1` or more.

- [ ] **Step 4: Commit**

```bash
git add README.md CLAUDE.md
git commit -m "Document nzt-limitless and nzt-soldier"
```
