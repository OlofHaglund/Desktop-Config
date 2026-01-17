# Fresh Install (Fedora)

Automated setup for a fresh Fedora workstation: base packages, dotfiles, GNOME tweaks, and core apps.

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
