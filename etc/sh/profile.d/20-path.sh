# Standard locations for searching for executables

# Work around distributions that still keep separate sbin directories:
path append "$(readlink -f /usr/local/sbin)"
path append "$(readlink -f /usr/sbin)"
path append "$(readlink -f /sbin)"

# Add user path:
path prepend "$(readlink -f "$HOME/.local/bin")"
path prepend "$(readlink -f "$HOME/.local/lib/python")"
path append "$(readlink -f "$HOME/.local/var/lib/npm/bin")"
path append "$(ruby -e 'puts Gem.user_dir')/bin"

