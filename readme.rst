********
Dotfiles
********

Uses `XGD <https://wiki.archlinux.org/index.php/XDG_Base_Directory>`__,
reproducing `FHS <http://linux.die.net/man/7/hier>`__ under ``~/.local``.
See 
`.pam_environment <https://raw.githubusercontent.com/rpuntaie/dotfiles/desktop/home/.pam_environment>`__.
Non-standard `XDG_LIB_HOME`, `XDG_LOG_HOME` and `XDG_STATE_HOME` are for FHS compliance.

Inspired by `ayekat <https://github.com/ayekat/dotfiles>`__ and
`floure <https://gitlab.gnugen.ch/floure/dotfiles>`__.
I chose
`gnu stow <https://www.gnu.org/software/stow/manual/stow.html#Invoking-Stow>`__
``--no-folding`` to keep the ``dotfiles`` repo clean from files filling up the ``.local`` FHS.

Installation
============

I install these my dotfiles on an installed machine:

.. code:: sh

   curl -Ls https://git.io/fjVcp | bash
   #or with cloned already: ~/dotfiles/install

The install script also installs packages from AUR using
`yay <https://github.com/Jguer/yay>`__.

I use these dotfiles together with the ArchLinux installation at
`rollarch <https://github.com/rpuntaie/rollarch>`__.
First prepare a local proxy, as described there,
then:

.. code:: sh

    curl -OLs https://git.io/installarch
    # replace all defines
    DSK=/dev/sda USR=u PW=p HST=up121 ZONE=Vienna IP2=1.121 AIP2=1.108 DOTS=https://git.io/fjVcp bash installarch rpuntaie-meta yay
    # log out and in

Tools
=====

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

.. TODO
   vim
   ---
   
   I tweaked my vimrc to work with both 
   `vim <https://www.vim.org/>`__
   and 
   `neovim <https://neovim.io/>`__.


Tree
====

::

   ~/.local
   ├── bin
   │   #... scripts
   ├── etc
   │   #... configs
   ├── home
   │   #... files symlinked from ~
   ├── install #script
   ├── readme.rst
   ├── lib
   │   ├── python
   │   │   └── startup.py
   │   └── tmux
   │       └── tmux-view
   ├── opt
   │   # ... not well integrated apps
   |   # ... e.g https://github.com/ayekat/dotfiles/blob/master/etc/sh/profile.d/40-altera.sh
   ├── share
