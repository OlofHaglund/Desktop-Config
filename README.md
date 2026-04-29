# Fresh Install (Fedora)

Automated setup for a fresh Fedora workstation: base packages, dotfiles, GNOME tweaks, and core apps.

TickTick source is kept in `/opt/ticktick_claude`. It uses TickTick's MCP server — no CLI install or credentials needed. On first use, run `/mcp` in Claude Code to complete OAuth authorization.

## Bootstrap

Run this before the playbook to ensure Ansible is available:

```bash
./pre-ansible.sh
```

## Run

Playbooks are tagged by machine profile. Use `--tags home` or `--tags work` to target the correct profile.

**Home machine:**
```bash
ansible-playbook -K fedora.yml --tags home
```

**Work machine:**
```bash
ansible-playbook -K fedora.yml --tags work
```

**Dry-run (no sudo tasks):**
```bash
ansible-playbook fedora.yml --check --skip-tags sudo --tags home
```

### Profile differences

| Tag | Includes |
|-----|----------|
| `home` | All common tasks + Discord, YouTube Music, Steam, Protontricks, Anki, Signal, Claude Code, TickTick |
| `work` | All common tasks + Open Bar GNOME extension, VPN topbar color changer |

## SSH keys (home machine)

The `ssh_keys` role runs automatically as part of `ansible-playbook -K fedora.yml --tags home`. On first run it prompts for your Bitwarden **personal API key** (`client_id` and `client_secret`) and your **master password**, then fetches all SSH Key items from the vault and writes them to `~/.ssh/`.

The personal API key is found at: Bitwarden web vault → Account Settings → Security → API Key.

Keys are named after their Bitwarden item name (lowercased, spaces replaced with underscores) and written with `0600`/`0644` permissions. A sentinel file `~/.ssh/.provisioned` is created on success so the prompts are skipped on subsequent runs.
