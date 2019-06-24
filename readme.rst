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

Inspired by `ayekat <https://github.com/ayekat/dotfiles>`__ and
`floure <https://gitlab.gnugen.ch/floure/dotfiles>`__.

Installation
============

Installation is handled by the ``install`` script according `rollarch`_.
I chose
`gnu stow <https://www.gnu.org/software/stow/manual/stow.html#Invoking-Stow>`__
``--no-folding`` to keep the ``dotfiles`` repo clean from files filling up the ``.local`` FHS,
a nuisance when grep'ing.

I install these my ``dotfiles`` on an set-up machine via:

.. code:: sh

   curl -Ls https://git.io/fjVcp | bash
   #or if cloned already: ~/dotfiles/install

The 
`install <https://raw.githubusercontent.com/rpuntaie/dotfiles/desktop/install>`__
script also installs packages from AUR using
`yay <https://github.com/Jguer/yay>`__.

I use these ``dotfiles`` together with the ArchLinux installation at
`rollarch <https://github.com/rpuntaie/rollarch>`_.
First prepare a local proxy, as described there,
then:

.. code:: sh

    curl -OLs https://git.io/installarch
    # replace all defines
    DSK=/dev/sda USR=u PW=p HST=up121 ZONE=Vienna IP2=1.121 AIP2=1.108 DOTS=https://git.io/fjVcp bash installarch rpuntaie-meta yay
    # log out and in

Occasionally one can check whether files in ``.local`` should be moved to ``dotfiles``, using

.. code:: sh

    diff -r .local dotfiles

After adding a file to ``dotfiles`` one must do:

.. code:: sh

    cd ~ && stow --no-folding -R -t .local dotfiles

When adding to ``dotfiles/home`` do:

.. code:: sh

    cd ~/dotfiles && stow home

``restowdots`` does both.

Usage
=====

.. note:: Work in progress.

CLI
---

- ``zsh`` as CLI
- ``slock`` to lock screen via CLI
- ``scrot`` to make screen shots via shortcuts ``M-s`` and ``M-u`` for current window.
- ``feh`` for images
- ``ranger`` for files
- ``links`` for text mode browsing
- ``fd`` to search for files
- ``fzf`` fuzzy find files
- ``rg`` (ripgrep) and ``ag`` (the_silver_searcher) to search for text in files
- ``bc`` for ad-hoc CLI calculations, e.g echo 2+2 | bc
- ``ncdu`` like ``du``, but with ncurses
- ``keybase`` and ``gpg`` for private/public key encryption

xmonad
------

I added little to the `defaults <https://xmonad.org/manpage.html>`__.
See `xmonad.hs <https://github.com/rpuntaie/dotfiles/blob/master/etc/xmonad/xmonad.hs>`__.

- no `display manager <https://wiki.archlinux.org/index.php/Display_manager>`__
- ``startx`` defaults to ``xmonad``, but you could do ``WM=qtile startx`` to change WM

dunst
-----

Started via `xinitrc <https://github.com/rpuntaie/dotfiles/blob/master/etc/X11/xinitrc.hs>`__.
Config from `arximboldi <https://github.com/arximboldi/dotfiles/blob/master/xmonad/.config/dunst/dunstrc>`__.
https://bitbucket.org/philexander/tikz
.. TODO
   vim
   ---
   
   I tweaked my vimrc to work with both 
   `vim <https://www.vim.org/>`__
   and 
   `neovim <https://neovim.io/>`__.

