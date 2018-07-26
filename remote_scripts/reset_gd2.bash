#WIP
source exports.bash

set -eu

function read_conf(){
  echo $(cat ${GD2_CONF}|grep $1|sed -n -re 's/^([a-z]+)\s*=\s*"(.*)"/\2/p')
}

LSD=$(read_conf ${localstatedir})

echo "LSD: ${LSD}"
echo "Remove? y/n: [y]"
read
