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
