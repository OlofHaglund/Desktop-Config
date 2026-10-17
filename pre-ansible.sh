#!/usr/bin/env bash
set -euo pipefail

if command -v ansible-playbook >/dev/null 2>&1; then
  echo "Ansible is already installed."
  exit 0
fi

if ! command -v pip3 >/dev/null 2>&1; then
  echo "Installing python3-pip..."
  if command -v dnf >/dev/null 2>&1; then
    sudo dnf install -y python3-pip
  elif command -v apt-get >/dev/null 2>&1; then
    sudo apt-get update
    sudo apt-get install -y python3-pip
  else
    echo "No supported package manager found (dnf/apt-get). Please install python3-pip manually." >&2
    exit 1
  fi
fi

echo "Installing Ansible via pip3 (ansible-dev-tools)..."
pip3 install --user ansible-dev-tools

if command -v ansible-galaxy >/dev/null 2>&1; then
  if ansible-galaxy collection list | grep -E '^community\.general\b' >/dev/null; then
    echo "Ansible collection community.general is already installed."
  else
    echo "Installing Ansible collection community.general..."
    ansible-galaxy collection install community.general
  fi
else
  echo "ansible-galaxy not found; restart your shell or check pip user bin." >&2
  exit 1
fi
