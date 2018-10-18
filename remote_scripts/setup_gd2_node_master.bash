#!/bin/bash
export DIR=$(dirname "$0")
source ${DIR}/exports.bash
source ~/.bashrc

#GOPATH is set in files/.bashrc
# make sure to source it
set -eu

if [[ ! -d $GOPATH/bin ]]
then
  mkdir -p $GOPATH/bin
fi
mkdir -p /usr/local/var/lib/glusterd2

yum update -y
yum install -y tmux wget git gcc rpcbind epel-release

#enable glusterfs nightly repos
curl -o /etc/yum.repos.d/glusterfs-nighthly-master.repo http://artifacts.ci.centos.org/gluster/nightly/master.repo
yum install -y glusterfs-server glusterfs-fuse glusterfs-api


wget -O golang.tar.gz ${GOLANG_SRC}
tar -C /usr/local -xzf golang.tar.gz

go get -d github.com/gluster/glusterd2 || true # because go get -d has non-zero exit
cd ${GOPATH}/src/github.com/gluster/glusterd2
./scripts/install-reqs.sh
make
make install

#fully disable firewall
if [[ $DISABLE_FIREWALL ]]
then
  setenforce 0
  iptables -F
  systemctl disable --now firewalld
else
  #glusterd2
  firewall-cmd --add-port=24007-24009/tcp
  firewall-cmd --add-port=2380/tcp

  #etcd
  firewall-cmd --add-port=2379/tcp
  #cockpit
  firewall-cmd --add-port=9090/tcp

  firewall-cmd --runtime-to-permanent
fi

if [[ $OVIRT_GUEST ]]
then
  sudo yum install -y centos-release-ovirt42
  sudo yum install -y ovirt-guest-agent-common
  sudo systemctl enable --now ovirt-guest-agent.service
fi

if [[ $INSTALL_COCKPIT ]]
then
  sudo yum install -y cockpit
  sudo systemctl enable cockpit
  sudo systemctl enable cockpit.socket
  sudo systemctl start cockpit
fi


if [[ $INSTALL_GLUSTER_ANSIBLE ]]
then
  curl -o /etc/yum.repos.d/gluster-ansible.repo https://copr.fedorainfracloud.org/coprs/sac/gluster-ansible/repo/epel-7/sac-gluster-ansible-epel-7.repo
  yum install -y 	gluster-ansible python-gluster-mgmt-client 
fi
