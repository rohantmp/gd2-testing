#!/bin/bash
#WIP

export DIR=$(dirname "$0")
source ${DIR}/exports.bash

set -eu

function read_conf(){
  echo $(cat ${GD2_CONF}|grep $1|sed -n -re 's/^([a-z]+)\s*=\s*"(.*)"/\2/p')
}

LSD=$(read_conf ${localstatedir})

echo "LSD: ${LSD}"
export confirm="y"
echo "Remove? y/n: [y]"
read confirm
if [[ $confirm = "y" ]]
then
	rm -rf ${LSD}
fi
