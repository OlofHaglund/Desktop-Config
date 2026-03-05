# Fresh-install

## Project Summary

Notes, scripts, and Ansible automation for setting up a fresh machine install.

## Default Role

Use the Developer role for setup automation, scripts, and configuration tasks.

## Working Guidelines

- Keep changes small and reversible.
- Prefer scripts and documented steps over manual edits.
- Avoid storing secrets in this project.
- Update this file when setup workflows or expectations change.
- Keep `README.md` aligned with actual setup steps.

## Validation

- After each Ansible playbook change, run `ansible-lint`.
- For changed playbooks, run check-mode without sudo-tagged tasks:

```bash
ansible-playbook <playbook>.yml --check --skip-tags "sudo"
```
