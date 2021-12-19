#!/bin/bash

set -xe 

apt-get update -y && apt-get install -y curl git sudo systemd unzip
TEST=1 DEPLOY_ENV='v3003' sudo -E /test/launch.sh
