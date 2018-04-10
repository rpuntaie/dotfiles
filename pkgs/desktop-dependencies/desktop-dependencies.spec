Name: desktop-dependencies
Version: 0.1
Release: 1%{?dist}
Summary: Dependencies for fnux's desktop environment

License: None

BuildArch: noarch
Requires: desktop-dependencies-base
Requires: desktop-dependencies-graphical
Requires: desktop-dependencies-devel
Requires: desktop-dependencies-media
Requires: desktop-dependencies-misc

%description
%{summary}.

%files

# base subpackage
%package base
Summary: Basic tools
Requires: zsh vim git gnupg2 tmux stow lvm2 htop iotop rfkill
Requires: ruby sqlite pass udisks2 perl-Switch perl-Proc-Daemon

%description base
%{summary}.

%files base

# graphical subpackage
%package graphical
Summary: X server and graphical tools
Requires: xorg-x11-server-Xorg xorg-x11-xinit xorg-x11-drv-evdev
Requires: xorg-x11-drv-libinput
Requires: xmonad ghc-regex-base-devel ghc-regex-posix-devel xmobar
Requires: rxvt-unicode-256color dejavu-sans-mono-fonts
Requires: dunst dmenu nitrogen i3lock redshift ranger
Requires: lxappearance adwaita-qt adwaita-gtk2-theme
Requires: pulseaudio pavucontrol arandr
Requires: pinentry-gtk brightnessctl xss-lock

%description graphical
%{summary}.

%files graphical

# devel subpackage
%package devel
Summary: Development tools
Requires: vim-X11 tig
Requires: fedpkg rpm-build spectool

%description devel
%{summary}.

%files devel

# media subpackage
%package media
Summary: Media tools
Requires: mpd mpv ncmpcpp zathura qutebrowser transmission-gtk
Requires: hexchat telegram-desktop eom feh w3m-img

%description media
%{summary}.

%files media

# misc subpackage
%package misc
Summary: Miscellaneous dependencies that don't fit in other packages
Requires: acpid offlineimap notmuch msmtp

%description misc
%{summary}.

%files misc

%changelog
* Fri Mar 30 2018 Timothée Floure <fnux@fnux.ch> - 0.1-1
- Let there be package
