#!/usr/bin/env bash
set -euo pipefail

if command -v ansible-playbook >/dev/null 2>&1; then
  echo "Ansible is already installed."
  exit 0
fi

if ! command -v pip3 >/dev/null 2>&1; then
  echo "pip3 is required to install Ansible. Please install python3-pip first." >&2
  exit 1
fi

echo "Installing Ansible via pip3 (ansible-dev-tools)..."
pip3 install --user ansible-dev-tools

if command -v ansible-galaxy >/dev/null 2>&1; then
  if ansible-galaxy collection list | rg -q '^community\.general\b'; then
    echo "Ansible collection community.general is already installed."
  else
    echo "Installing Ansible collection community.general..."
    ansible-galaxy collection install community.general
  fi
else
  echo "ansible-galaxy not found; restart your shell or check pip user bin." >&2
  exit 1
fi
