# Desktop Config

Work in progress

## Bootstrap

Run this before the playbook to ensure Ansible is available:

```bash
./pre-ansible.sh
```

## Tests

Run check-mode without sudo-tagged tasks for any playbook you change (example shown):

```bash
ansible-playbook fedora.yml --check --skip-tags "sudo"
```
