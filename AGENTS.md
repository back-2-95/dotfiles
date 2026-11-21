# dotfiles

Personal macOS dotfiles for bootstrapping a development environment.

## Structure

| File/Dir | Purpose |
|---|---|
| `install.sh` | Bootstrap script: installs CLT + Homebrew + mise, clones repo, links `~/.config/mise`, runs `mise bootstrap` |
| `aliases.zsh` | Shell aliases; sources `.env` at the top |
| `exports.zsh` | PATH and `export` declarations; depends on `.env` being sourced first (alphabetical load order) |
| `.env` | Non-secret environment variables (committed) |
| `secrets.zsh` | Secret env vars — gitignored, never commit |
| `.zshrc` | Main zsh config; symlinked to `~/.zshrc` |
| `.ssh.config` | SSH config; symlinked to `~/.ssh/config` |
| `.ssh.local.config` | Machine-local SSH hosts — gitignored |
| `.gitconfig` | Git config; symlinked to `~/.gitconfig` |
| `Brewfile.php` | PHP 8.4/8.5/8.6 + PHP 8.4 extensions via real Homebrew (shivammathur/php, shivammathur/extensions), run by a `post-packages` hook in `mise/config.toml`; 8.5 is linked as `php`, switch with `mise php 8.4` |
| `dtop/config.yaml` | dtop config; symlinked to `~/.config/dtop/config.yaml` |
| `mise/config.toml` | Global (personal) mise config — `~/.config/mise` links to `mise/`. Holds `[tools]` plus the machine setup for `mise bootstrap`: `[bootstrap.packages]` (Homebrew formulae/casks, replaces the Brewfile), `[bootstrap.repos]` (Oh My Zsh, p10k), `[dotfiles]` (symlinks). Project `mise.toml` files (e.g. employer repos) override per tool |
| `.p10k.zsh` | Powerlevel10k theme config |
| `zsh/secrets.zsh` | Template/example for secrets.zsh |
| `.github/workflows/install.yml` | CI: runs `install.sh` twice on a macOS runner (casks skipped), verifies symlinks, `mise bootstrap status --missing` and zsh startup |
| `scripts/versions.sh` | Versions of the main software (reads mise config + Brewfile.php); `mise run versions` locally, markdown job summary in CI |
| `scripts/test-vm.sh` | Local test of `install.sh` in a fresh Tart macOS VM with GUI (`up` / `install` / `remote` / `ssh` / `reset`) |

## How Oh My Zsh loads custom files

`ZSH_CUSTOM` is set to `~/dotfiles`, so Oh My Zsh auto-sources all `*.zsh` files in the repo root alphabetically. Load order matters: `aliases.zsh` (sources `.env`) runs before `exports.zsh` (uses those variables).

## Credential helpers

- **GitHub / Gist**: `gh auth git-credential` via `/opt/homebrew/bin/gh`
- **Azure DevOps**: Git Credential Manager at `/usr/local/bin/git-credential-manager` (installed as a cask — pkg installer places it in `/usr/local/bin` even on Apple Silicon)
- **Everything else**: GCM fallback via global `[credential]` block

## Known open issues (low priority)

