#!/bin/bash
export DIR=$(dirname "$0")
source ${DIR}/exports.bash

tmux send-keys -t gd2 C-c
