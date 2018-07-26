export DIR=$(dirname "$0")
source ${DIR}/exports.bash

set -eu
tmux new-session -d -s gd2
tmux send-keys -t gd2 "rm -f /usr/local/var/run/glusterd2/glusterd2.socket" C-m
tmux send-keys -t gd2 "glusterd2 --config ${GD2_CONF}" C-m
