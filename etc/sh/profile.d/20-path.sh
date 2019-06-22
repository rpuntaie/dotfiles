# Standard locations for searching for executables

# Work around distributions that still keep separate sbin directories:
path append "$(readlink -f /usr/local/sbin)"
path append "$(readlink -f /usr/sbin)"
path append "$(readlink -f /sbin)"

# Add user path:
path prepend "$(readlink -f "$HOME/.local/bin")"

# XXX
export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
