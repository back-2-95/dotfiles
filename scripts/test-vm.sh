#!/bin/sh
#
# Test install.sh in a fresh macOS VM with a GUI window, using Tart.
#   brew install cirruslabs/cli/tart   (optional: brew install sshpass)
#
# Usage:
#   scripts/test-vm.sh up       Create (if needed) and boot the VM with a GUI window
#   scripts/test-vm.sh install  Copy this working tree into the VM and run install.sh
#   scripts/test-vm.sh remote   Run the real thing: clone from GitHub inside the VM
#   scripts/test-vm.sh ssh      Open a shell in the VM
#   scripts/test-vm.sh reset    Delete the VM so the next "up" is a clean machine
#
# The vanilla image has no Homebrew/CLT; login is admin / admin.
# Override the image with DOTFILES_VM_IMAGE (e.g. macos-sequoia-vanilla).

set -e

VM=${DOTFILES_VM_NAME:-dotfiles-test}
IMAGE=${DOTFILES_VM_IMAGE:-ghcr.io/cirruslabs/macos-tahoe-vanilla:latest}
REPO=$(cd "$(dirname "$0")/.." && pwd)

command -v tart >/dev/null || { echo "Install Tart: brew install cirruslabs/cli/tart"; exit 1; }

vm_ip() { tart ip "$VM" --wait 120; }

vm_ssh() {
  set -- -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -o LogLevel=ERROR "admin@$(vm_ip)" "$@"
  if command -v sshpass >/dev/null; then sshpass -p admin ssh "$@"; else ssh "$@"; fi
}

vm_running() { tart list | awk -v vm="$VM" '$2 == vm && $NF == "running"' | grep -q .; }

case "$1" in
  up)
    tart list | awk '{print $2}' | grep -qx "$VM" || tart clone "$IMAGE" "$VM"
    if vm_running; then echo "$VM already running"; exit 0; fi
    nohup tart run "$VM" >/dev/null 2>&1 &
    echo "Booting $VM ... IP: $(vm_ip)"
    ;;
  install)
    vm_running || { echo "Run: $0 up"; exit 1; }
    # Tracked + untracked-but-not-ignored files only, includes uncommitted changes
    (cd "$REPO" && git ls-files -co --exclude-standard | tar -czf - -T -) | vm_ssh '
      rm -rf ~/dotfiles && mkdir -p ~/dotfiles && tar -xzf - -C ~/dotfiles'
    vm_ssh -t 'cd ~/dotfiles && NONINTERACTIVE=1 ./install.sh'
    ;;
  remote)
    vm_running || { echo "Run: $0 up"; exit 1; }
    vm_ssh -t 'NONINTERACTIVE=1 /bin/sh -c "$(curl -fsSL https://raw.githubusercontent.com/back-2-95/dotfiles/main/install.sh)"'
    ;;
  ssh)
    vm_ssh -t
    ;;
  reset)
    tart stop "$VM" 2>/dev/null || true
    tart delete "$VM"
    ;;
  *)
    sed -n '3,15p' "$0"; exit 1
    ;;
esac
