#!/bin/bash
# Listener that forces Open Bar to refresh

BASE="org.gnome.shell.extensions.openbar"
NORMAL="['0.6', '0.102', '0.012']"
VPN="['0.0', '0.2', '0.5']"
SCHEMA_DIR="$HOME/.local/share/gnome-shell/extensions/openbar@neuromorph/schemas/"

last_state="unknown"

while true; do
    if [ -f /tmp/vpn_active ]; then
        current_state="up"
    else
        current_state="down"
    fi

    if [ "$current_state" != "$last_state" ]; then
        if [ "$current_state" == "up" ]; then
            COLOR="$VPN"
        else
            COLOR="$NORMAL"
        fi
        
        # 1. Update the color keys
        gsettings --schemadir "$SCHEMA_DIR" set "$BASE" dark-bgcolor "$COLOR"
        gsettings --schemadir "$SCHEMA_DIR" set "$BASE" dark-bgcolor-wmax "$COLOR"
        gsettings --schemadir "$SCHEMA_DIR" set "$BASE" bgcolor "$COLOR"
        gsettings --schemadir "$SCHEMA_DIR" set "$BASE" bgcolor-wmax "$COLOR"


        # 2. THE REFRESH TRIGGER
        # We toggle them to false first, then true, to ensure a 'change' event is fired
        gsettings --schemadir "$SCHEMA_DIR" set "$BASE" reloadstyle false
        gsettings --schemadir "$SCHEMA_DIR" set "$BASE" trigger-reload false
        sleep 0.2
        gsettings --schemadir "$SCHEMA_DIR" set "$BASE" reloadstyle true
        gsettings --schemadir "$SCHEMA_DIR" set "$BASE" trigger-reload true
        
        last_state="$current_state"
    fi
    sleep 2
done
