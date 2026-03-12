# dotfiles

Personal macOS dotfiles for bootstrapping a development environment.

## Structure

| File/Dir | Purpose |
|---|---|
| `install.sh` | Bootstrap script — runs once on a new machine |
| `aliases.zsh` | Shell aliases; sources `.env` at the top |
| `exports.zsh` | PATH and `export` declarations; depends on `.env` being sourced first (alphabetical load order) |
| `.env` | Non-secret environment variables (committed) |
| `secrets.zsh` | Secret env vars — gitignored, never commit |
| `.zshrc` | Main zsh config; symlinked to `~/.zshrc` |
| `.ssh.config` | SSH config; symlinked to `~/.ssh/config` |
| `.ssh.local.config` | Machine-local SSH hosts — gitignored |
| `.gitconfig` | Git config; symlinked to `~/.gitconfig` |
| `Brewfile` | All Homebrew packages and casks |
| `.p10k.zsh` | Powerlevel10k theme config |
| `zsh/secrets.zsh` | Template/example for secrets.zsh |

## How Oh My Zsh loads custom files

`ZSH_CUSTOM` is set to `~/dotfiles`, so Oh My Zsh auto-sources all `*.zsh` files in the repo root alphabetically. Load order matters: `aliases.zsh` (sources `.env`) runs before `exports.zsh` (uses those variables).

## Credential helpers

- **GitHub / Gist**: `gh auth git-credential` via `/opt/homebrew/bin/gh`
- **Azure DevOps**: Git Credential Manager at `/usr/local/bin/git-credential-manager` (installed as a cask — pkg installer places it in `/usr/local/bin` even on Apple Silicon)
- **Everything else**: GCM fallback via global `[credential]` block

## Known open issues (low priority)

- `aliases.zsh:1` — `.env` sourced without an existence check; will error on fresh install before dotfiles are cloned
- `.zshrc:1-2` — Fig integration is dead code (Fig discontinued Dec 2024); safe to remove
- `install.sh:158` — `p10k configure` is interactive and will block any non-interactive run
- `Brewfile` — `1password` GUI app not listed (required for SSH agent in `.ssh.config`); likely installed via App Store
- `Brewfile` — PHP 8.5 is pre-release; intentional for testing but worth a comment
