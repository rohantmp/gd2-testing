#!/bin/bash
set -eu
DIR=$(dirname "$0")
testdir="/root/test"
ssh_opts="-o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no"
source ${DIR}/exports.bash
if [[ $# -eq 1 ]]
then
        export HOST=$1
elif [[ $# -eq 2 ]]
then
        export HOST=$1
        sci-pass $2 ${HOST} ${ssh_opts}
else
  echo "no host provided"
  exit 1
fi

ssh ${HOST} ${ssh_opts} "mkdir -p ${testdir}"
ssh ${HOST} ${ssh_opts} "yum install -y tmux"
scp ${DIR}/files/.bashrc ${HOST}:/root/
scp ${DIR}/remote_scripts/*.bash ${HOST}:${testdir}/
ssh ${HOST} ${ssh_opts} "tmux new-session -d -s setup; tmux send-keys -t setup 'bash --verbose ${testdir}/setup_gd2_node_master.bash' C-m"
ssh ${HOST} ${ssh_opts}  'tmux ls'
