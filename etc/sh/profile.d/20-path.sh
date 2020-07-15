# Work around distributions that still keep separate sbin directories:
path append "$(readlink -f /usr/local/sbin)"
path append "$(readlink -f /usr/sbin)"
path append "$(readlink -f /sbin)"

#perl

path prepend "$HOME/perl5/bin"
PERL5LIB="$HOME/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="$HOME/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"$HOME/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=$HOME/perl5"; export PERL_MM_OPT;

#go
GOPATH="$HOME/go"; export GOPATH
path prepend "$GOPATH/bin"

# jshell
path append "/usr/lib/jvm/java-11-openjdk/bin"

# Add user path:
path prepend "$(readlink -f "$HOME/.local/bin")"
path prepend "$(readlink -f "$HOME/.local/lib/python")"
path append "$(readlink -f "$HOME/.local/var/lib/npm/bin")"
path append "$(ruby -e 'puts Gem.user_dir')/bin"

