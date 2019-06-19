********
Dotfiles
********

Uses `XGD <https://wiki.archlinux.org/index.php/XDG_Base_Directory>`__.

Installation
============

I use these dotfiles together with this ArchLinux installation

First prepare a local proxy as described in `rollarch <https://github.com/rpuntaie/rollarch>`__.

Then:

.. code:: sh

    curl -OLs https://git.io/installarch
    # replace all defines
    DSK=/dev/sda USR=u PW=p HST=up121 ZONE=Vienna IP2=1.121 AIP2=1.108 bash DOTS=https://git.io/fjVcp installarch rpuntaie-meta yay
    # log out and in

``install`` uses  `stow <https://www.gnu.org/software/stow/>`__ to simlink into ``dotfiles``.
Therefore keep ``dotfiles``, also to adapt and push when needed.

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
Config from `arximboldi <https://github.com/arximboldi/dotfiles/blob/master/xmonad/.config/dunst/dunstrc`__.

.. TODO
   vim
   ---
   
   I tweaked my vimrc to work with both 
   `vim <https://www.vim.org/>`__
   and 
   `neovim <https://neovim.io/>`__.



