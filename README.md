# Fresh Install (Fedora)

Automated setup for a fresh Fedora workstation: base packages, dotfiles, the Veshell desktop environment, and core apps.

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

**Kali (Firefox policy only):**
```bash
ansible-playbook -K fedora.yml --tags kali
```

**Dry-run (skips sudo tasks, no changes made):**
```bash
ansible-playbook fedora.yml --check --skip-tags sudo --tags work
```

## 3. After the playbook

- **Log out and back in**, then select the **Veshell** session at the login screen.

## What each profile installs

All profiles install: system updates, base packages (vim, flatpak, nodejs, npm, git), multimedia codecs, virt-manager, DNF Automatic, dotfiles (.bashrc, .gitconfig), Veshell (enabled from the `@free-explorers` COPR, `veshell-bin`), the PKMS repository cloned to `~/Documents/PKMS` (see [Private repositories](#private-repositories)), and the profile's Firefox policy (see [Firefox policies](#firefox-policies)).

| Profile | Additional installs |
|---------|---------------------|
| `home`  | Discord, YouTube Music, Steam, Protontricks, Anki, Signal, Claude Code, TickTick, SSH key from Bitwarden (Generic Home SSH Key) |
| `work`  | SSH key from Bitwarden (Github Work SSH Key), VPN topbar color changer |
| `kali`  | Firefox policy only — no other role has tasks tagged `kali` |

## SSH keys

SSH keys are fetched automatically from Bitwarden as part of the selected profile. On first run you will be prompted for your Bitwarden **personal API key** (`client_id`, `client_secret`) and **master password**.

| Profile | Bitwarden item fetched |
|---------|------------------------|
| `home`  | Generic Home SSH Key   |
| `work`  | Github Work SSH Key    |

Find your personal API key at: Bitwarden web vault → Account Settings → Security → API Key.

The Bitwarden CLI is pointed at the EU server (`https://vault.bitwarden.eu`) by default. For a US account, override it with `-e ssh_keys_bw_server=https://vault.bitwarden.com`. Item names can be overridden with `-e ssh_keys_home_key_name=...` / `-e ssh_keys_work_key_name=...`.

Keys are named after their Bitwarden item name (lowercased, spaces → underscores) and written to `~/.ssh/` with `0600`/`0644` permissions. A sentinel file `~/.ssh/.provisioned` is created so the prompts are skipped on re-runs.

## Private repositories

The `repos` role clones `git@github.com:OlofHaglund/PKMS.git` (branch `main`) to `~/Documents/PKMS`. It runs after the `ssh_keys` role so a provisioned key is available, and uses the key file written for the active profile (`~/.ssh/generic_home_ssh_key` or `~/.ssh/github_work_ssh_key`). If `~/Documents/PKMS` already exists the clone is skipped, so a checkout with local modifications is left untouched (delete the directory to force a re-clone). Repo settings can be overridden with `-e repos_pkms_url=...`, `-e repos_pkms_branch=...`, or `-e repos_pkms_dest=...`.

## Firefox policies

Three policy templates live in `roles/firefox/files/policies/`: `home.json`, `work.json`, and `kali.json`. The `firefox` role installs only the one for the active profile tag as `/etc/firefox/policies.json` — the file Firefox reads on Linux. Fill in a template as needed and re-run the playbook to redeploy.

## VPN topbar color changer (work profile)

The `system` role deploys a NetworkManager dispatcher (`/etc/NetworkManager/dispatcher.d/99-vpn-color`) that touches/removes `/tmp/vpn_active` when the VPN goes up or down. The `veshell` role installs `~/.local/bin/vpn-color-listener.sh` as a systemd **user** service, which polls that file and rewrites `theme.color` in `~/.config/veshell/settings.json` — Veshell reloads the file on its own, so changing the hex color is the only thing needed to take effect. Colors: `0xFF1C2EB7` (normal), `0xFF003380` (VPN up).