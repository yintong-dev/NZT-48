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
1. Download `nzt-48.skill` from the [Releases](../../releases) page (or zip the `nzt-48/` folder).
2. Go to **Settings → Capabilities → Skills** and upload it.

### Claude Code
```bash
git clone https://github.com/<your-username>/nzt-48.git
cp -r nzt-48 ~/.claude/skills/nzt-48
```

## Repo structure

```
nzt-48/
├── SKILL.md                        # The skill itself
├── references/
│   └── voice-and-examples.md       # Voice guide with before/after examples
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
