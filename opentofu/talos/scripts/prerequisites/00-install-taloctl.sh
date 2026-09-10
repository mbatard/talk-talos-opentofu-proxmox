#!/bin/bash

curl -L https://github.com/siderolabs/talos/releases/download/v1.13.8/talosctl-linux-amd64 -o talosctl
install -o root -g root -m 0755 talosctl /usr/local/bin/talosctl
rm -f ./talosctl
