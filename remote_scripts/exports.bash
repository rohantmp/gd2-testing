#!/bin/bash
### import from the same dir with:
# export DIR=$(dirname "$0")
# source ${DIR}/exports.bash
export DIR=$(dirname "$0")

export GD2_CONF="${DIR}/glusterd2.toml"
export ETCD_CONF="${DIR}/etcd_config"
export GOLANG_SRC="https://dl.google.com/go/go1.10.3.linux-amd64.tar.gz"

export DISABLE_FIREWALL=false
export OVIRT_GUEST=true
export INSTALL_COCKPIT=true
