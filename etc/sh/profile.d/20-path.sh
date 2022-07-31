PATH="$PATH:$(readlink -f /usr/local/sbin)"
PATH="$PATH:$(readlink -f /usr/sbin)"
PATH="$PATH:$(readlink -f /sbin)"

PATH="$PATH:$HOME/perl5/bin"
PERL5LIB="$HOME/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="$HOME/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"$HOME/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=$HOME/perl5"; export PERL_MM_OPT;

GOPATH="$HOME/go"; export GOPATH
PATH="$PATH:$GOPATH/bin"

PATH="$PATH:/usr/lib/jvm/java-11-openjdk/bin"

PATH="$(readlink -f "$HOME/.local/bin"):$PATH"
PATH="$(readlink -f "$HOME/.local/lib/python"):$PATH"
PATH="$PATH:$(readlink -f "$HOME/.local/var/lib/npm/bin")"
PATH="$PATH:$(ruby -e 'puts Gem.user_dir')/bin"

#cd ${HOME}/tmp
#tar -xf /var/cache/pacman/pkg/icu-69.1-1-x86_64.pkg.tar.zst
export LD_LIBRARY_PATH=${HOME}/tmp/usr/lib
export SWIFT="/usr/lib/swift/bin/swift"
PATH="$PATH:/usr/lib/swift/bin"

export ANDROID_SDK_ROOT=$HOME/Android/Sdk
export ANDROID_NDK_ROOT=$HOME/Android/Sdk/ndk/21.4.7075529
export NDK_ROOT=$HOME/Android/Sdk/ndk/21.4.7075529
export NDK_HOME=$HOME/Android/Sdk/ndk/21.4.7075529
export PATH="$PATH:$ANDROID_SDK_ROOT/emulator"
export PATH="$PATH:$ANDROID_SDK_ROOT/tools"
export PATH="$PATH:$ANDROID_SDK_ROOT/tools/bin"
export PATH="$PATH:$ANDROID_SDK_ROOT/platform-tools"

export IDF_PATH=$HOME/msrc/esp-idf

