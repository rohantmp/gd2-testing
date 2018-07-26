export DIR=$(dirname "$0")
source ${DIR}/exports.bash

set -eu
tmux new-session -d -s etcd
tmux send-keys -t etcd "rm -f /usr/local/var/run/glusterd2/glusterd2.socket" C-m
tmux send-keys -t etcd "etcd --config-file ${ETCD_CONF}" C-m
