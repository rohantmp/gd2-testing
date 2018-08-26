#!/bin/bash
set -eu
DIR=$(dirname "$0")
testdir="/root/test"
ssh_opts="-o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no"
source ${DIR}/exports.bash
testdir=${HOME}/test

mkdir -p ${testdir}
rsync ${DIR}/files/.bashrc ${HOME}
rsync ${DIR}/remote_scripts/*.bash ${testdir}/
bash --verbose ${testdir}/setup_gd2_node_master.bash
