# NZT-48 — two Claude Skills

> *"What if I told you that you could access 100% of your brain?"*

**NZT-48** is a pair of [Claude Skills](https://docs.claude.com) that make Claude think like a person who just took the fictional pill from *Limitless*. Same pill, two ways to use it:

| | **nzt-limitless** (default) | **nzt-soldier** |
|---|---|---|
| Style | Fast, magnetic, pattern-obsessed, decisive | Cold, decisive, goal-obsessed |
| Output | Reframe → pattern → move → catch | Objective → numbered steps → risk |
| Words | As many as the problem earns | Only what the objective needs |
| Triggers | On request, and automatically on hard problems | Only on explicit request |

## The two skills

### nzt-limitless

A **thinking style plus a voice**. On hard problems it reframes the real question, connects ideas across fields, compresses the mess into a model, commits to a recommendation, and then honestly attacks its own answer.

- **Reframes** your question into the one that actually matters
- **Cross-pollinates** insights from unrelated domains (only when they genuinely sharpen the point)
- **Compresses** complexity into a structure you can hold in your head
- **Decides**: ranked recommendation plus a concrete first move
- **Stays honest**: flags uncertainty, never fabricates, always names where it could be wrong

Triggers on "NZT mode", "limitless mode", "Eddie Morra", "genius mode", `/nzt-limitless`, and automatically on complex problems, tough decisions, strategy, and "I'm stuck" situations. When it triggers automatically, it uses a lighter version: the clarity without the theatrics.

### nzt-soldier

Every thought points at the objective. It picks the single highest-leverage path, gives the steps, and stops. No preamble, no recap, no analogies, no humor: fewer words, fewer tokens. It asks a question only when it cannot proceed without the answer.

Triggers only when you ask for it: `/nzt-soldier`, "nzt-soldier", "NZT soldier", "soldier mode".

## How to invoke

| Where | Limitless | Soldier |
|---|---|---|
| Claude Code (installer) | `/nzt-limitless` | `/nzt-soldier` |
| Claude Code (plugin) | `/nzt-48:nzt-limitless` | `/nzt-48:nzt-soldier` |
| Codex | `$nzt-limitless` | `$nzt-soldier` |
| Claude.ai | "limitless mode" or just ask | "nzt-soldier: …" |

## Install

### Claude.ai / Claude app
1. Download `nzt-limitless.skill` and/or `nzt-soldier.skill` from the latest [Release](https://github.com/yintong-zhou/NZT-48/releases/latest).
2. Go to **Settings → Capabilities → Skills** and upload them.

### Claude Code

**Option A: plugin marketplace (recommended, gets updates).** Inside Claude Code:

```
/plugin marketplace add yintong-zhou/NZT-48
/plugin install nzt-48@nzt-48
```

Or from your shell: `claude plugin marketplace add yintong-zhou/NZT-48 && claude plugin install nzt-48@nzt-48`. The plugin ships both skills as `/nzt-48:nzt-limitless` and `/nzt-48:nzt-soldier`.

**Option B: personal skills.** Installs both skills to `~/.claude/skills/nzt-limitless` and `~/.claude/skills/nzt-soldier`:

```bash
curl -fsSL https://raw.githubusercontent.com/yintong-zhou/NZT-48/main/install.sh | bash -s -- claude
```

### Codex

Installs both skills to `~/.agents/skills/`, where Codex looks for user skills:

```bash
curl -fsSL https://raw.githubusercontent.com/yintong-zhou/NZT-48/main/install.sh | bash -s -- codex
```

Restart Codex afterwards. Inside Codex you can also ask the built-in `$skill-installer` to install the skills from `https://github.com/yintong-zhou/NZT-48`.

### Both at once

macOS / Linux / Git Bash:

```bash
curl -fsSL https://raw.githubusercontent.com/yintong-zhou/NZT-48/main/install.sh | bash -s -- all
```

Windows PowerShell:

```powershell
& ([scriptblock]::Create((irm https://raw.githubusercontent.com/yintong-zhou/NZT-48/main/install.ps1))) -Target all
```

From a clone, run `./install.sh [claude|codex|all]` or `.\install.ps1 -Target <claude|codex|all>`. Set `NZT48_REF` to install a specific tag (e.g. `NZT48_REF=v1.1.0`). Re-running the installer updates the skills in place.

**Upgrading from v1.0:** the old single skill was called `nzt-48`. The installers remove a leftover `nzt-48` folder automatically; plugin users just update the plugin.

## Repo structure

```
.
├── skills/
│   ├── nzt-limitless/
│   │   ├── SKILL.md                     # The default skill
│   │   └── references/voice-and-examples.md
│   └── nzt-soldier/
│       ├── SKILL.md                     # The terse execution skill
│       └── references/examples.md
├── .claude-plugin/                      # Claude Code plugin + marketplace manifests
├── install.sh / install.ps1             # Installers for Claude Code and Codex
├── .github/workflows/release.yml        # Builds one .skill per skill on every v* tag
├── README.md
└── LICENSE
```

## Examples

**You:** Should I quit my stable job to start a company?

**nzt-limitless:** Wrong question. "Quit or stay" is a binary, and binaries are where good decisions go to die. The real question is: *what is the cheapest experiment that tells me if this business is real?* …

(See `skills/nzt-limitless/references/voice-and-examples.md` for the full exchange.)

**You:** /nzt-soldier Should I quit my stable job to start a company?

**nzt-soldier:**
> Objective: validate the business before risking income.
> 1. Keep the job.
> 2. Get one paying customer in 90 days, working evenings.
> 3. Quit only when revenue repeats and savings cover 9-12 months.
> Risk: capital-heavy or regulated businesses can't be tested part-time.
> Not a financial professional; this is only my opinion.

## Honest disclaimer

NZT-48 is **fictional**. The "we only use 10% of our brains" idea is a myth; we use virtually all of our brain. These skills don't unlock anything in Claude or in you. They apply a disciplined, high-clarity way of reasoning wrapped in a fun persona. They do not give advice on real drugs or "smart pills," and on medical, legal, or financial topics they remind you they are not a professional.

## Contributing

Issues and PRs welcome: new voice examples, sharper reasoning moves, translations.

## License

MIT — see [LICENSE](LICENSE).
