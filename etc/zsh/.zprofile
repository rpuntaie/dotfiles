###
# GPG-AGENT

export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"

###
# PATH

# Adds directory to the PATH variable, with (hopefully) all necessary checks:
add_to_path() {
    [ -d "$1" ] || return
    [ -z "$PATH" ] && PATH="$1" && return
    IFS_OLD="$IFS"
    IFS=:
    for i in $PATH; do
        [ "$1" = "$i" ] && return
        [ -h "$1" ] && [ "$(readlink -f "$1")" = "$i" ] && return
    done
    PATH="$1:$PATH"
    IFS="$IFS_OLD"
    unset IFS_OLD
}

add_to_path "$HOME/.local/bin"

unset -f add_to_path
export PATH
