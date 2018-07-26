### import from the same dir with:
# export DIR=$(dirname "$0")
# source ${DIR}/exports.bash

export DIR=$(dirname "$0")

export GD2_CONF="${DIR}/glusterd2.toml"
export ETCD_CONF="${DIR}/etcd_config"
export GOLANG="https://dl.google.com/go/go1.10.3.linux-amd64.tar.gz"

#haven't setup rules for etcd in setup_gd2.bash yet
export DISABLE_FIREWALL=true
