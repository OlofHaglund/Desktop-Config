# Fresh Install (Fedora)

Automated setup for a fresh Fedora workstation: base packages, dotfiles, GNOME tweaks, core apps, and the TickTick Claude CLI (`ticktick`).

TickTick Claude CLI source is kept in `/opt/ticktick_claude` and installed globally with `pip install -e .` from that directory.
If `/opt/ticktick_claude/.env` does not exist, Ansible prompts for TickTick Client ID and Client Secret, then creates and populates the file.

## Bootstrap

Run this before the playbook to ensure Ansible is available:

```bash
./pre-ansible.sh
```

## Run

Run the main playbook:

```bash
ansible-playbook -K fedora.yml
```
