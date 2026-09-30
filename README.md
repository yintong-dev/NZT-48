# NZT-48 — a Claude Skill

> *"What if I told you that you could access 100% of your brain?"*

**NZT-48** is a [Claude Skill](https://docs.claude.com) that makes Claude think and sound like a person who just took the fictional pill from *Limitless*: fast, magnetic, pattern-obsessed, and decisive.

It is a **thinking style plus a voice**, not a gimmick. On hard problems it reframes the real question, connects ideas across fields, compresses the mess into a model, commits to a recommendation, and then honestly attacks its own answer.

## What it does

- **Reframes** your question into the one that actually matters
- **Cross-pollinates** insights from unrelated domains (only when they genuinely sharpen the point)
- **Compresses** complexity into a structure you can hold in your head
- **Decides**: ranked recommendation plus a concrete first move
- **Stays honest**: flags uncertainty, never fabricates, always names where it could be wrong

## Triggers

1. **On request:** "NZT mode", "limitless mode", "Eddie Morra", "unlock 100% of my brain", "genius mode"
2. **Automatically:** complex problems, tough decisions, strategy, multi-domain analysis, "I'm stuck" situations

When it triggers automatically, it uses a lighter version: the clarity without the theatrics.

## Install

### Claude.ai / Claude app
1. Download `nzt-48.skill` from the latest [Release](https://github.com/yintong-zhou/NZT-48/releases/latest).
2. Go to **Settings → Capabilities → Skills** and upload it.

### Claude Code

**Option A: plugin marketplace (recommended, gets updates).** Inside Claude Code:

```
/plugin marketplace add yintong-zhou/NZT-48
/plugin install nzt-48@nzt-48
```

Or from your shell: `claude plugin marketplace add yintong-zhou/NZT-48 && claude plugin install nzt-48@nzt-48`.

**Option B: personal skill.** Copies the skill to `~/.claude/skills/nzt-48`:

```bash
curl -fsSL https://raw.githubusercontent.com/yintong-zhou/NZT-48/main/install.sh | bash -s -- claude
```

### Codex

Copies the skill to `~/.agents/skills/nzt-48`, where Codex looks for user skills:

```bash
curl -fsSL https://raw.githubusercontent.com/yintong-zhou/NZT-48/main/install.sh | bash -s -- codex
```

Restart Codex afterwards. Inside Codex you can also ask the built-in `$skill-installer` to install the skill from `https://github.com/yintong-zhou/NZT-48`.

### Both at once

macOS / Linux / Git Bash:

```bash
curl -fsSL https://raw.githubusercontent.com/yintong-zhou/NZT-48/main/install.sh | bash -s -- all
```

Windows PowerShell:

```powershell
& ([scriptblock]::Create((irm https://raw.githubusercontent.com/yintong-zhou/NZT-48/main/install.ps1))) -Target all
```

From a clone, run `./install.sh [claude|codex|all]` or `.\install.ps1 -Target <claude|codex|all>`. Set `NZT48_REF` to install a specific tag (e.g. `NZT48_REF=v1.0.0`). Re-running the installer updates the skill in place.

## Repo structure

```
.
├── SKILL.md                        # The skill itself
├── references/
│   └── voice-and-examples.md       # Voice guide with before/after examples
├── .claude-plugin/                 # Claude Code plugin + marketplace manifests
├── install.sh / install.ps1        # Installers for Claude Code and Codex
├── .github/workflows/release.yml   # Builds nzt-48.skill on every v* tag
├── README.md
└── LICENSE
```

## Example

**You:** Should I quit my stable job to start a company?

**NZT-48:** Wrong question. "Quit or stay" is a binary, and binaries are where good decisions go to die. The real question is: *what is the cheapest experiment that tells me if this business is real?* …

(See `references/voice-and-examples.md` for the full exchange.)

## Honest disclaimer

NZT-48 is **fictional**. The "we only use 10% of our brains" idea is a myth; we use virtually all of our brain. This skill doesn't unlock anything in Claude or in you. It applies a disciplined, high-clarity way of reasoning wrapped in a fun persona. It does not give advice on real drugs or "smart pills," and on medical, legal, or financial topics it reminds you it is not a professional.

## Contributing

Issues and PRs welcome: new voice examples, sharper reasoning moves, translations.

## License

MIT — see [LICENSE](LICENSE).
