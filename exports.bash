function sci-pass {
        help="usage: sci-pass <password> <ssh-copy-id args>"
        if [[ ${1} = "help" || ${1} = "--help"|| ${1} = "-h" ]]
        then
                echo ${help}
                return 0
        fi
        if [[ ${#} -eq 2 && ${1} = "-e" ]]
        then
                sshpass -e ssh-copy-id ${@:2}
                exit $?
        fi
        sshpass -p $1 ssh-copy-id ${@:2}

}
