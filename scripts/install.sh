#!/bin/bash
set -e
set -x

curl https://raw.githubusercontent.com/wasienv/wasienv/master/install.sh | sh
wasienv install-sdk unstable
npm install
