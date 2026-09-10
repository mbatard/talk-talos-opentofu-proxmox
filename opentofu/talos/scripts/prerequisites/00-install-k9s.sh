#!/bin/bash

wget https://github.com/derailed/k9s/releases/download/v0.51.0/k9s_linux_amd64.deb -O k9s_linux_amd64.deb
apt install ./k9s_linux_amd64.deb
rm -f ./k9s_linux_amd64.deb
