###
# GPG-AGENT

export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"

###
# Elixir, Erlang

if [[ -f $XDG_DATA_HOME/kerl/erlang/activate ]]; then
  . $XDG_DATA_HOME/kerl/erlang/activate
fi

if [[ -f $XDG_DATA_HOME/kiex/elixirs/.default ]]; then
  source $XDG_DATA_HOME/kiex/elixirs/.default
fi

###
# Ruby

export GEM_PATH="$XDG_DATA_HOME/gem:/usr/share:/usr/local/share/gems"

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
add_to_path "$HOME/.local/opt/desktop-utilities/bin"
add_to_path "$HOME/.cargo/bin"
add_to_path "$HOME/.local/opt/processing-3.3.7/bin"
add_to_path "$XDG_DATA_HOME/gem/bin"

unset -f add_to_path
export PATH
