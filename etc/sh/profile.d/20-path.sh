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

export JAVA_HOME=/usr/lib/jvm/java-11-openjdk
PATH="$PATH:$JAVA_HOME/bin"

if [[  "$(uname)" == "Darwin" ]] ; then
    export SWIFT="/usr/bin/swift"
    PATH="$HOME/bin:$PATH"
else
    #cd ${HOME}/tmp
    #tar -xf /var/cache/pacman/pkg/icu-69.1-1-x86_64.pkg.tar.zst
    export LD_LIBRARY_PATH=${HOME}/tmp/usr/lib
    export SWIFT="/usr/lib/swift/bin/swift"
    PATH="$PATH:/usr/lib/swift/bin"

    PATH="$(readlink -f "$HOME/.local/bin"):$PATH"
    PATH="$(readlink -f "$HOME/.local/lib/python"):$PATH"
    PATH="$PATH:$(readlink -f "$HOME/.local/var/lib/npm/bin")"
    PATH="$PATH:$(ruby -e 'puts Gem.user_dir')/bin"
fi

if [ -d /opt/android-sdk ] ; then
    export ANDROID_SDK_ROOT=/opt/android-sdk
else
    export ANDROID_SDK_ROOT=$HOME/Android/Sdk
fi

export ANDROID_NDK_ROOT=$ANDROID_SDK_ROOT/ndk/21.4.7075529
export NDK_ROOT=$ANDROID_NDK_ROOT
export NDK_HOME=$ANDROID_NDK_ROOT
export PATH="$PATH:$ANDROID_SDK_ROOT/emulator"
export PATH="$PATH:$ANDROID_SDK_ROOT/tools"
export PATH="$PATH:$ANDROID_SDK_ROOT/tools/bin"
export PATH="$PATH:$ANDROID_SDK_ROOT/platform-tools"
export PATH="$PATH:$HOME/.pub-cache/bin"
export PATH="$PATH:/usr/lib/emscripten"
