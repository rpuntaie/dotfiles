********
Dotfiles
********

Uses `XDG <https://wiki.archlinux.org/index.php/XDG_Base_Directory>`__,
reproducing `FHS <http://linux.die.net/man/7/hier>`__ under ``~/.local``.
See 
`.pam_environment <https://raw.githubusercontent.com/rpuntaie/dotfiles/desktop/home/.pam_environment>`__.
Non-standard ``XDG_LIB_HOME``, ``XDG_LOG_HOME`` and ``XDG_STATE_HOME`` are for FHS compliance.

:etc:       ``XDG_CONFIG_HOME``, app configurations
:share:     ``XDG_DATA_HOME``, user data needed by app
:lib:       ``XDG_LIB_HOME``, libs for user
:var/cache: ``XDG_CACHE_HOME``, tmp and cache needed by app
:var/lib:   ``XDG_STATE_HOME``, libraries for app not tracked  
:var/log:   ``XDG_LOG_HOME``, app generated logs
:opt: for not well integrated apps, 
      e.g for `altera <https://github.com/ayekat/dotfiles/blob/master/etc/sh/profile.d/40-altera.sh>`__
:bin: user scripts
:home: files symlinked from ``~`` for apps not honoring XDG
:install: installation script according `rollarch`_
:readme.rst: this file

Inspired by and thanks to:
`ayekat <https://github.com/ayekat/dotfiles>`__,
`floure <https://gitlab.gnugen.ch/floure/dotfiles>`__ and others.

Some files in these dotfiles reference separately managed directories:

``~/.password-store``
``~/.gnupg``
``~/my/task``
``~/my/finance``

There are according environment variables in ``.pam_environment``.

Installation
============

Installation is handled by the ``install`` script according `rollarch`_.
I chose
`gnu stow <https://www.gnu.org/software/stow/manual/stow.html#Invoking-Stow>`__ ``--no-folding``
over directly cloning into ``.local`` 
to keep the ``dotfiles`` repo clean from files filling up the ``.local`` FHS,
a nuisance when grep'ing.

I install these my ``dotfiles`` on an set-up machine via:

.. code:: sh

   curl -Ls https://git.io/fjVcp | bash

or, if cloned already:

.. code:: sh

    ~/dotfiles/install

The 
`install <https://raw.githubusercontent.com/rpuntaie/dotfiles/desktop/install>`__
script also installs user packages for python and nodejs or possibly 
AUR packages using `yay <https://github.com/Jguer/yay>`__,
but the latter I have integrate into the ``rpuntaie-meta`` package (end of file),
which I serve via a local archlinux proxy.

A whole ArchLinux system, including these ``dotfiles``, can be installed with `rollarch`_.
If AIP2 is used, a local proxy must be prepared as described there.

.. code:: sh

    curl -OLs https://git.io/installarch
    # replace the defines at least in the first line
    USR=u PW=p HST=u121 IP2=1.121 \
    AIP2=1.108 DSK=/dev/sda KM=us CL=99 \
    LA_NG="de_DE es_ES fr_FR it_IT ru_RU" ZONE=Vienna \
    DOTS=fjVcp bash installarch
    # log out and in

After changing or adding a file to the ``dotfiles`` one must run

.. code:: sh

   restowdots
   #or ~/dotfiles/install

to update ``~/.local``.
The variables can be sourced from a file, of course.

System Description
==================

``wiki-search``: Help for Archlinux at command line.

Cleaning
--------

.. code:: sh

  pacman -Rns $(pacman -Qtdq) #orphans
  paccache -ruk0
  paccache -rk1
  ncdu
  rmlint #produces rmlint.sh


Editor: Vim
-----------

I use ``vim`` as TUI to the system.

Note for Windows: ``bash dotfiles/bin/restowdots`` only sets up vimfiles.

Vim embeds Python and others and it has
``:term``:

- ``[CTRL-w N]`` normal mode
- ``[CTRL-w CTRL-w]`` switch window
- ``[CTRL-w ""]`` paste ``"`` into term

For Python and ``restructuredText`` (RST) I use

- vim plugin `vim_py3_rst <https://github.com/rpuntaie/vim_py3_rst>`__
- python package `rstdoc <https://github.com/rpuntaie/rstdoc>`__

See further mappings and plugins see 
`myvimrc <https://raw.githubusercontent.com/rpuntaie/dotfiles/desktop/etc/vim/doc/myvimrc.txt>`__.

CLI
---

``zsh`` through vim ``:term`` or ``urxvt``.
``urxvt`` depends on a proper ``/etc/locale.conf``.

No need for ``cd``.

Settings in ``Xresources``, ``xrdb -load <pth>`` for re-loading.

Shortcuts: 

- copy/paste: ``C-M-c/v`` or ``C-M-x`` to enter ``urxvt-vim-scrollback``
- search:
  ``CTRL-T`` for **fzf** 
  ``CTRL-g[f b t r h]`` `for git <https://gist.github.com/junegunn/8b572b8d4b5eddd8b85e5f4d40f17236>`__

Commands:

- ``v, vvsp, vvhs`` open a file in ``gvim``.
- ``nvr`` open a file in nvr-opened ``nvim``.
- ``z <substring>`` jumps to a file in history

CLI tools:

- ``slock`` to lock screen via CLI
- ``scrot`` to make screen shots via shortcuts ``M-s``, and ``M-u`` for current window.
- ``feh`` for images
- ``ranger`` for files
- ``links -dump <url>`` for text from URL
- ``fd`` to search for files
- ``fzf`` fuzzy find files
- ``rg`` (ripgrep) and ``ag`` (the_silver_searcher) to search for text in files
- ``bc`` for ad-hoc CLI calculations, e.g echo 2+2 | bc
- ``ncdu`` like ``du``, but with ncurses

Window Manager: xmonad
----------------------

I added little to the `defaults <https://xmonad.org/manpage.html>`__.
See `xmonad.hs <https://github.com/rpuntaie/dotfiles/blob/master/etc/xmonad/xmonad.hs>`__.

``M-s`` screenshot
``M-u`` screenshot allowing seleection
``M-S-p`` passmenu

- no `display manager <https://wiki.archlinux.org/index.php/Display_manager>`__
- ``startx`` defaults to ``xmonad``, but you could do ``WM=qtile startx`` to change WM

**dunst** is started via `xinitrc <https://github.com/rpuntaie/dotfiles/blob/master/etc/X11/xinitrc.hs>`__.

Security
========

``gpg`` for private/public key encryption::

   gpg2 --full-gen-key
   gpg2 --list-keys --with-colons
   gpg2 --edit-key <email>
   passwd
   save
   gpg2 --armor --output my-secret-key.asc --export-secret-keys <email>
   gpg2 --delete-secret-key <email>
   gpg2 --armor --output my-secret-key.asc --export-secret-subkeys <email>
   gpg2 --import my-secret-subkeys.asc
   gpg2 --recv-keys
   gpg2 --sign-key <keyid>
   gpg2 --send-key <keyid>

   gpg2 --encrypt <file>
   gpg2 --encrypt <file> --recipient <receiver>
   gpg2 --decrypt <file>.gpg

   gpg2 --sign <file>
   gpg2 --sign --encrypt <file> -r <receiver>
   gpg2 --detached-sign <file>
   gpg2 --verify <file>.asc

``~/dotfiles/bin/gpg-offline-master`` works with the separate offline master key.


``~/.gnupg``:
``GNUPGHOME`` is kept at the default location, to be managed separately and offline.
Set it up before ``dotfiles``, as ``restowdots`` will 
`use it for ssh <https://wiki.archlinux.org/index.php/GnuPG#SSH_agent>`__.
Else, just ``restowdots`` again.

``~/.password-store``:
``pass`` for password management, managed separately.
``browserpass`` uses it to serve ``browserpass-chromium`` and ``browserpass-firefox``.

``keybase`` for secure chat and file exchange (KBFS).

Programming
===========

Python
------

`rollarch`_/pkg/rpuntaie installs Arch python packages.
Additionally `my_python <https://raw.githubusercontent.com/rpuntaie/dotfiles/desktop/bin/my_python>`__.

C/C++
-----

nodejs
------

`my_nodejs <https://raw.githubusercontent.com/rpuntaie/dotfiles/desktop/bin/my_nodejs>`__.

R
---

`rollarch`_/pkg/rpuntaie includes `R <https://www.r-project.org/>`_.

Octave
------

`rollarch`_/pkg/rpuntaie includes `octave <https://hg.savannah.gnu.org/hgweb/octave/file/>`_.

