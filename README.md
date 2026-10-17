# Fresh Install (Fedora)

Automated setup for a fresh Fedora workstation: base packages, dotfiles, GNOME tweaks, and core apps.

## Prerequisites

- Fresh Fedora installation with a user account
- This repository cloned locally
- Internet access

## 1. Bootstrap

Run this before the playbook to install Ansible and its dependencies:

```bash
./pre-ansible.sh
```

## 2. Run the playbook

Profiles are selected with `--tags`. Use `home` or `work` depending on the machine.
`-K` prompts for your sudo password (required for system-level tasks).

**Home machine:**
```bash
ansible-playbook -K fedora.yml --tags home
```

**Work machine:**
```bash
ansible-playbook -K fedora.yml --tags work
```

**Dry-run (skips sudo tasks, no changes made):**
```bash
ansible-playbook fedora.yml --check --skip-tags sudo --tags work
```

## 3. After the playbook

- **Log out and back in** for GNOME extensions to activate (Open Bar, etc.)

## What each profile installs

All profiles install: system updates, base packages (vim, flatpak, nodejs, npm), multimedia codecs, virt-manager, DNF Automatic, dotfiles (.bashrc, .gitconfig), and common GNOME settings (dark mode, 24h clock, Firefox autostart).

| Profile | Additional installs |
|---------|---------------------|
| `home`  | Discord, YouTube Music, Steam, Protontricks, Anki, Signal, Claude Code, TickTick, SSH keys from Bitwarden |
| `work`  | Open Bar GNOME extension (styled topbar), VPN topbar color changer |

## SSH keys — home machine only

SSH keys are fetched automatically from Bitwarden as part of `--tags home`. On first run you will be prompted for your Bitwarden **personal API key** (`client_id`, `client_secret`) and **master password**.

Find your personal API key at: Bitwarden web vault → Account Settings → Security → API Key.

Keys are named after their Bitwarden item name (lowercased, spaces → underscores) and written to `~/.ssh/` with `0600`/`0644` permissions. A sentinel file `~/.ssh/.provisioned` is created so the prompts are skipped on re-runs.