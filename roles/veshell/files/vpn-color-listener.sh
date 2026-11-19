#!/bin/bash
# Listener that keeps the Veshell theme color in sync with VPN status.
#
# Polls /tmp/vpn_active (created/removed by the NetworkManager
# dispatcher /etc/NetworkManager/dispatcher.d/99-vpn-color) and rewrites
# theme.color in ~/.config/veshell/settings.json. Veshell picks up the
# changed file on its own — no reload trigger needed.

SETTINGS="$HOME/.config/veshell/settings.json"
NORMAL="0xFF1C2EB7"
VPN="0xFF003380"

last_state="unknown"

while true; do
    if [ -f /tmp/vpn_active ]; then
        current_state="up"
    else
        current_state="down"
    fi

    # Catch up once settings.json exists (veshell creates it on first run)
    if [ "$current_state" != "$last_state" ] && [ -f "$SETTINGS" ]; then
        if [ "$current_state" == "up" ]; then
            COLOR="$VPN"
        else
            COLOR="$NORMAL"
        fi

        tmp="$(mktemp)"
        if jq --arg c "$COLOR" '.theme.color = $c' "$SETTINGS" > "$tmp" 2>/dev/null; then
            mv "$tmp" "$SETTINGS"
        else
            rm -f "$tmp"
        fi

        last_state="$current_state"
    fi
    sleep 2
done
