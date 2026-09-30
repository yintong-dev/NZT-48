# Installing NZT-48

Both skills (`nzt-limitless`, `nzt-soldier`) install together. Pick your agent below.

| Agent | Recommended method | Invoke |
|---|---|---|
| [Claude Code](#claude-code) | Plugin marketplace | `/nzt-48:nzt-limitless`, `/nzt-48:nzt-soldier` |
| [Claude.ai](#claudeai--claude-app) | Upload `.skill` files | "limitless mode", "nzt-soldier: …" |
| [Codex](#codex) | Plugin marketplace | `$nzt-limitless`, `$nzt-soldier` |
| [Cursor](#cursor) | Plugin (import repo) | skills load automatically |
| [Kimi Code](#kimi-code) | `/plugins install` | skills load automatically |
| [OpenCode](#opencode) | Installer script | `skill` tool |

## Claude Code

**Plugin (gets updates).** Inside Claude Code:

```
/plugin marketplace add yintong-dev/NZT-48
/plugin install nzt-48@nzt-48
```

Or from your shell:

```bash
claude plugin marketplace add yintong-dev/NZT-48 && claude plugin install nzt-48@nzt-48
```

**Personal skills** (`/nzt-limitless`, `/nzt-soldier`, no prefix). Copies both skills to `~/.claude/skills/`:

```bash
curl -fsSL https://raw.githubusercontent.com/yintong-dev/NZT-48/main/install.sh | bash -s -- claude
```

## Claude.ai / Claude app

1. Download `nzt-limitless.skill` and/or `nzt-soldier.skill` from the [latest release](https://github.com/yintong-dev/NZT-48/releases/latest).
2. Open **Settings → Capabilities → Skills** and upload them.

## Codex

**Plugin (gets updates):**

```bash
codex plugin marketplace add yintong-dev/NZT-48
codex plugin add nzt-48@nzt-48
```

Or inside Codex, open `/plugins` and install **NZT-48** from the `nzt-48` marketplace. Update later with `codex plugin marketplace upgrade`.

**Personal skills.** Copies both skills to `~/.agents/skills/`:

```bash
curl -fsSL https://raw.githubusercontent.com/yintong-dev/NZT-48/main/install.sh | bash -s -- codex
```

## Cursor

The repo is a Cursor plugin (`.cursor-plugin/plugin.json`). In Cursor, go to **Dashboard → Plugins & MCPs → Add Marketplace → Import from Repo** and paste `https://github.com/yintong-dev/NZT-48`, then install **nzt-48** from **Customize**.

## Kimi Code

Inside Kimi Code:

```text
/plugins install https://github.com/yintong-dev/NZT-48
```

Pin a version with `/plugins install https://github.com/yintong-dev/NZT-48/releases/tag/v1.1.0`. Start a new session with `/new` afterwards.

Without the plugin, the installer copies the skills to `~/.kimi-code/skills/`:

```bash
curl -fsSL https://raw.githubusercontent.com/yintong-dev/NZT-48/main/install.sh | bash -s -- kimi
```

## OpenCode

OpenCode discovers skills natively. Copy them to `~/.config/opencode/skills/`:

```bash
curl -fsSL https://raw.githubusercontent.com/yintong-dev/NZT-48/main/install.sh | bash -s -- opencode
```

Then ask OpenCode to "use the skill tool to load nzt-limitless".

> [!NOTE]
> OpenCode also reads `~/.claude/skills/` and `~/.agents/skills/`, and Kimi Code also reads `~/.agents/skills/`. If you already ran the `claude` or `codex` installer, you may not need another copy.

## Everything at once

Installs the skills for Claude Code, Codex, OpenCode, and Kimi Code.

macOS / Linux / Git Bash:

```bash
curl -fsSL https://raw.githubusercontent.com/yintong-dev/NZT-48/main/install.sh | bash -s -- all
```

Windows PowerShell:

```powershell
& ([scriptblock]::Create((irm https://raw.githubusercontent.com/yintong-dev/NZT-48/main/install.ps1))) -Target all
```

From a clone: `./install.sh [claude|codex|opencode|kimi|all]` or `.\install.ps1 -Target <claude|codex|opencode|kimi|all>`.

> [!TIP]
> Re-run the installer to update. Set `NZT48_REF` to pin a version, e.g. `NZT48_REF=v1.1.0`. Override any target folder with `CLAUDE_SKILLS_DIR`, `CODEX_SKILLS_DIR`, `OPENCODE_SKILLS_DIR`, or `KIMI_SKILLS_DIR`.

> [!NOTE]
> **Upgrading from v1.0?** The single `nzt-48` skill is now `nzt-limitless`, and the plugin command `/nzt-48:nzt-48` is now `/nzt-48:nzt-limitless`. The installers remove the old `nzt-48` folder for you.
