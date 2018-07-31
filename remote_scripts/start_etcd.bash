#!/bin/bash
export DIR=$(dirname "$0")
source ${DIR}/exports.bash

set -u
tmux new-session -d -s etcd &&
  tmux send-keys -t etcd "etcd --config-file ${ETCD_CONF}" C-m
