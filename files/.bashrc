# .bashrc

# User specific aliases and functions

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

export iceblue="\[\033[0;38;5;45m\]"
export coldblue="\[\033[0;38;5;33m\]"
export white="\[\033[0;38;5;7m\]"

PS1="\h:$iceblue\$PWD $coldblue\$(date \"+%H:%M\"):$white "

export GOPATH=$HOME/golang
export PATH=$PATH:$GOPATH/bin:/usr/local/go/bin
