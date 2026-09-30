<div align="center">

# NZT-48

**Two Claude Skills built on the fictional pill from *Limitless*.**<br>
One thinks at 100%. The other executes at 100%.

[![Release](https://img.shields.io/github/v/release/yintong-dev/NZT-48?style=flat-square)](https://github.com/yintong-dev/NZT-48/releases/latest)
[![License: MIT](https://img.shields.io/github/license/yintong-dev/NZT-48?style=flat-square)](LICENSE)
![Claude Code](https://img.shields.io/badge/Claude_Code-plugin-d97757?style=flat-square)
![Claude.ai](https://img.shields.io/badge/Claude.ai-skill-d97757?style=flat-square)
![Codex](https://img.shields.io/badge/Codex-skill-111111?style=flat-square)

[Overview](#overview) · [Quick start](#quick-start) · [Install](#install) · [Examples](#examples) · [How it works](#how-it-works)

</div>

---

## Overview

NZT-48 turns Claude into a sharper collaborator for hard problems. It is a disciplined way of reasoning with a persona on top, not a gimmick. Pick the one that fits the moment:

| | 🧠 **nzt-limitless** · *default* | 🎯 **nzt-soldier** |
|---|---|---|
| **Personality** | Fast, magnetic, pattern-obsessed | Cold, decisive, goal-obsessed |
| **Answer shape** | Reframe → pattern → move → catch | Objective → numbered steps → risk |
| **Length** | As long as the problem earns | Only what the objective needs |
| **Activates** | On request *and* automatically on hard problems | Only when you ask for it |
| **Best for** | Strategy, tangled decisions, "I'm stuck" | Getting something done, saving tokens |

Both skills share the same rules: they never invent facts, they say where they might be wrong, and they drop the act when you need a human answer.

## Quick start

**Claude Code** (recommended):

```
/plugin marketplace add yintong-dev/NZT-48
/plugin install nzt-48@nzt-48
```

Then just ask a hard question, or call a skill directly:

| Where | Limitless | Soldier |
|---|---|---|
| Claude Code · plugin | `/nzt-48:nzt-limitless` | `/nzt-48:nzt-soldier` |
| Claude Code · installer | `/nzt-limitless` | `/nzt-soldier` |
| Codex | `$nzt-limitless` | `$nzt-soldier` |
| Claude.ai | "limitless mode", or just ask | "nzt-soldier: …" |

## Install

<details open>
<summary><b>Claude Code</b></summary>

**Plugin (gets updates).** Inside Claude Code:

```
/plugin marketplace add yintong-dev/NZT-48
/plugin install nzt-48@nzt-48
```

Or from your shell:

```bash
claude plugin marketplace add yintong-dev/NZT-48 && claude plugin install nzt-48@nzt-48
```

**Personal skills.** Copies both skills to `~/.claude/skills/`:

```bash
curl -fsSL https://raw.githubusercontent.com/yintong-dev/NZT-48/main/install.sh | bash -s -- claude
```

</details>

<details>
<summary><b>Codex</b></summary>

Copies both skills to `~/.agents/skills/`, where Codex looks for user skills:

```bash
curl -fsSL https://raw.githubusercontent.com/yintong-dev/NZT-48/main/install.sh | bash -s -- codex
```

Restart Codex afterwards. You can also ask Codex's built-in `$skill-installer` to install them from `https://github.com/yintong-dev/NZT-48`.

</details>

<details>
<summary><b>Claude.ai / Claude app</b></summary>

1. Download `nzt-limitless.skill` and/or `nzt-soldier.skill` from the [latest release](https://github.com/yintong-dev/NZT-48/releases/latest).
2. Open **Settings → Capabilities → Skills** and upload them.

</details>

<details>
<summary><b>Claude Code + Codex at once</b></summary>

macOS / Linux / Git Bash:

```bash
curl -fsSL https://raw.githubusercontent.com/yintong-dev/NZT-48/main/install.sh | bash -s -- all
```

Windows PowerShell:

```powershell
& ([scriptblock]::Create((irm https://raw.githubusercontent.com/yintong-dev/NZT-48/main/install.ps1))) -Target all
```

From a clone: `./install.sh [claude|codex|all]` or `.\install.ps1 -Target <claude|codex|all>`.

</details>

> [!TIP]
> Re-run the installer to update. Set `NZT48_REF` to pin a version, e.g. `NZT48_REF=v1.1.0`.

> [!NOTE]
> **Upgrading from v1.0?** The single `nzt-48` skill is now `nzt-limitless`, and the plugin command `/nzt-48:nzt-48` is now `/nzt-48:nzt-limitless`. The installers remove the old `nzt-48` folder for you.

## Examples

Same question, two skills:

> **You:** Should I quit my stable job to start a company?

<table>
<tr>
<th width="50%">🧠 nzt-limitless</th>
<th width="50%">🎯 nzt-soldier</th>
</tr>
<tr>
<td valign="top">

Wrong question. "Quit or stay" is a binary, and binaries are where good decisions go to die. The real question is: *what is the cheapest experiment that tells me if this business is real?*

Think of a pilot testing a wing: you don't fly the plane to see if it stalls, you use a wind tunnel first…

</td>
<td valign="top">

Objective: validate the business before risking income.
1. Keep the job.
2. Get one paying customer in 90 days, working evenings.
3. Quit only when revenue repeats and savings cover 9-12 months.

Risk: capital-heavy or regulated businesses can't be tested part-time.<br>
Not a financial professional; this is only my opinion.

</td>
</tr>
</table>

More examples live in [`voice-and-examples.md`](skills/nzt-limitless/references/voice-and-examples.md) and [`examples.md`](skills/nzt-soldier/references/examples.md).

## How it works

**nzt-limitless** runs six moves on every substantive problem and shows you the result, not the machinery: reframe the question, scan the whole board, borrow a pattern from another field (only if it sharpens the point), compress it into a model, decide, then attack its own answer. When it activates on its own, it keeps the clarity and skips the theatrics.

**nzt-soldier** runs a mission loop: identify the objective, pick the single highest-leverage path, give the steps, stop. It asks a question only when it is blocked; otherwise it states its assumption in one line and moves on.

**Both** follow five non-negotiables: no fabrication, calibrated confidence, NZT stays fiction, humans first when you're struggling, and a clear "not a professional" note on medical, legal, and financial topics.

<details>
<summary><b>Repository layout</b></summary>

```
skills/
├── nzt-limitless/
│   ├── SKILL.md
│   └── references/voice-and-examples.md
└── nzt-soldier/
    ├── SKILL.md
    └── references/examples.md
.claude-plugin/              # Claude Code plugin + marketplace manifests
install.sh / install.ps1     # Installers for Claude Code and Codex
.github/workflows/release.yml  # Builds one .skill per skill on every v* tag
```

</details>

> [!IMPORTANT]
> NZT-48 is **fictional**, and the "we only use 10% of our brains" idea is a myth: we use virtually all of it. These skills don't unlock anything in Claude or in you. They don't give advice on real drugs or "smart pills", and on medical, legal, or financial topics they remind you they are not a professional.
