if type nix &> /dev/null ; then
    if [ -e /etc/profile.d/nix.sh ]; then
        source /etc/profile.d/nix.sh
    fi
    if [ -e /etc/profile.d/nix-daemon.sh ]; then
        source /etc/profile.d/nix-daemon.sh
    fi
fi
