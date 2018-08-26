#!/bin/bash
set -eu
DIR=$(dirname "$0")
testdir="/root/test"
ssh_opts="-o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no"
source ${DIR}/exports.bash
testdir=${HOME}/test

echo [running as ${USER}]
echo [creating working directory at ${testdir}]

yum install -y tmux etcd
mkdir -p ${testdir}
rsync ${DIR}/files/.bashrc ${HOME}
rsync ${DIR}/remote_scripts/*.bash ${testdir}/
rsync ${DIR}/files/sn_glusterd2.toml ${testdir}/glusterd2.toml
rsync ${DIR}/files/sn_etcd_config ${testdir}/etcd_config
bash --verbose ${testdir}/setup_gd2_node_master.bash


echo [running as ${USER}]
echo [creating working directory at ${testdir}]
