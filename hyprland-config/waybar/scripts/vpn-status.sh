#!/usr/bin/env bash

if ip link show proton0 >/dev/null 2>&1; then
    server=$(curl -s https://ipinfo.io/country)
    echo "VPN: connected $server  "
else
    echo "VPN: disconnected  "
fi