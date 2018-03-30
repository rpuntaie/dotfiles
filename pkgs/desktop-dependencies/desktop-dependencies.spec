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
Requires: zsh vim git gnupg2 tmux stow

%description base
%{summary}.

%files base

# graphical subpackage
%package graphical
Summary: X server and graphical tools
Requires: xorg-x11-server-Xorg xorg-x11-xinit xorg-x11-drv-evdev
Requires: xorg-x11-drv-libinput
Requires: xmonad dunst dmenu

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
Requires: mpd mpv ncmpcpp zathura

%description media
%{summary}.

%files media

# misc subpackage
%package misc
Summary: Miscellaneous dependencies that don't fit in other packages
Requires: acpid

%description misc
%{summary}.

%files misc

%changelog
* Fri Mar 30 2018 Timothée Floure <fnux@fnux.ch> - 0.1-1
- Let there be package
