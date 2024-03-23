********
Dotfiles
********

:Author: roland.puntaier@gmail.com
:License: https://opensource.org/licenses/GPL-3.0

Uses `XDG <https://wiki.archlinux.org/index.php/XDG_Base_Directory>`__,
reproducing `FHS <http://linux.die.net/man/7/hier>`__ under ``~/.local``.
Non-standard ``XDG_LIB_HOME``, ``XDG_LOG_HOME`` and ``XDG_STATE_HOME`` are for FHS compliance.

:etc:       ``XDG_CONFIG_HOME``, configurations for apps
:share:     ``XDG_DATA_HOME``, data for apps and user scripts
:lib:       ``XDG_LIB_HOME``, user libs
:var/cache: ``XDG_CACHE_HOME``, cache for apps
:var/lib:   ``XDG_STATE_HOME``, non-tracked automatically downloaded libraries for apps
:var/log:   ``XDG_LOG_HOME``, app generated logs
:opt: for not well integrated apps
:bin: user scripts
:home: files symlinked from ``~`` for apps not honoring XDG
:install: installation script according `rollarch`_
:readme.rst: this file

`rollarch`_ fills `/etc/security/pam_env.conf` with XDG variables.

Some files in these dotfiles reference separately managed directories,
because they are actual user data.

``~/.password-store``
``~/.gnupg``
``~/my``
``~/Mail``

.. note:: To free these dotfiles from user-specific things, grep for ``usrstuff``.

Installation
============

Installation is handled by the ``install`` script according `rollarch`_.

The
`install <https://raw.githubusercontent.com/rpuntaie/dotfiles/desktop/install>`__
script has a list of all packages including user packages for python and nodejs or possibly
AUR packages using `yay <https://github.com/Jguer/yay>`__.

A whole ArchLinux system, including these ``dotfiles``, can be installed with `rollarch`_.
If ``AIP2`` is used, a local proxy must be prepared as described in `rollarch`_.


On the ``AIP2`` proxy:

.. code:: sh

    cd ~/mine/rollarch
    sudo -E bash ./build pkg/rpuntaie

Then

.. code:: sh

    curl -OLs https://git.io/installarch
    # replace the defines at least in the first line
    DSK=/dev/sda USR=u PW=p HST=u121 IP2=1.121 ZONE=Vienna DOTS=fjVcp bash installarch
    # log out and in

Alternatively

.. code:: sh

   mkdir mine
   mount -t nfs -o nfsvers=3 192.168.1.108:/home/roland/mine mine
   lsblk
   DSK=/dev/sda SWAP=off USR=u PW=p HST=u121 IP2=1.121 ZONE=Vienna DOTS=mine/dotfiles/install bash mine/rollarch/rollarch

DSK IS FORMATTED. DON'T CHOOSE THE WRONG ONE.

The variables can be sourced from a file.
``PW`` will be asked if omitted.

After changing or adding a file to the ``dotfiles`` one must run

.. code:: sh

   restowdots
   #or ~/dotfiles/install

to update ``~/.local``.

I chose
`gnu stow <https://www.gnu.org/software/stow/manual/stow.html#Invoking-Stow>`__ ``--no-folding``
over directly cloning into ``.local``
to keep the ``dotfiles`` repo clean from files filling up the ``.local`` FHS,
a nuisance when grep'ing.

Help
====

- ``man``, ``info``
- ``wiki-search``: Help for Archlinux at command line.
- ``wikit``: Wikipedia search on command line.

Input
=====

``C- = CTRL-``, ``S- = SHIFT-``, ``M- = ALT-``, ``X- = WIN- = SUPER-`` (mod4Mask on Xmonad)

- ``vim``: ``digraph``, ``keymap``
- ``0setxkbmap`` wraps ``setxkbmap`` and defaults to ``en``.
- ``ibus``: ``C-S-e`` emoji, ``C-S-u`` unicode, ``ibus-setup`` in terminal

On X11 use ``xev`` to show keysym and keycode.
Use ``ralt`` (etc/X11/xinitrc) as compose/ComposeKey/Multi_key for ``etc/X11/XCompose``

On X11, ``showkey`` can't get a file descriptor referring to the console.
``C-M-Fx`` to switch to real virtual terminal (VT).
X11 uses one VT, e.g. F1: Use ``C-M-F1`` to go back to X11.

Cleaning
========

.. code:: sh

  pacman -Rns $(pacman -Qtdq) #orphans
  paccache -ruk0
  paccache -rk1
  ncdu
  rmlint

`rmlint` reduces space by making files share disk blocks with same data
using a `linux feature <http://man7.org/linux/man-pages/man2/ioctl_fideduperange.2.html>`__.
And it produces ``rmlint.sh`` to show you file duplications,
which you may clean up selectively by editing the script.

Editor: Vim
===========

I use ``vim`` as TUI to the system.

Note for Windows: ``bash dotfiles/bin/restowdots`` only sets up vimfiles.

Vim embeds Python and others and it has
``:term``:

- ``[C-w N]`` normal mode
- ``[C-w C-w]`` switch window
- ``[C-w ""]`` paste ``"`` into term

For Python and ``restructuredText`` (RST) I use

- vim plugin `vim_py3_rst <https://github.com/rpuntaie/vim_py3_rst>`__
- python package `rstdoc <https://github.com/rpuntaie/rstdoc>`__

For mappings and plugins see
`myvimrc <https://raw.githubusercontent.com/rpuntaie/dotfiles/desktop/etc/vim/doc/myvimrc.txt>`__.

CLI
===

``zsh`` through vim ``:term`` or ``urxvt``.
``urxvt`` depends on a proper ``/etc/locale.conf``.

For shell scripting I use ``bash`` instead of ``zsh``.
They are not the same.
Therefore I use ``:term bash`` in vim to try solutions.

``urxvt`` settings in ``Xresources``, ``xrdb -load <pth>`` for re-loading.

Shortcuts:

- copy/paste: ``C-M-c/v`` to copy/paste selected or ``C-M-x`` to enter ``urxvt-vim-scrollback``
  Capital ``Y`` to yank into clipboard.
- edit command line with vim: ``ESC-v`` and ``ESC-:``
- search:
  ``C-T`` for **fzf**
  ``C-g[f b t r h]`` `for git <https://gist.github.com/junegunn/8b572b8d4b5eddd8b85e5f4d40f17236>`__

Commands:

- ``v, vvsp, vvhs`` open a file in ``gvim``.
- ``nvr`` open a file in nvr-opened ``nvim``.
- ``z <substring>`` jumps to a file in history

CLI tools:

- ``slock`` to lock screen via CLI
- ``scrot`` to make screen shots via shortcuts ``X-s``, and ``X-u`` for current window.
- ``feh`` for images
- ``ranger`` for files
- ``w3m -dump <url>`` for text from URL
- ``fd`` to search for files
- ``fzf`` fuzzy find files
- ``rg`` (ripgrep) and ``ag`` (the_silver_searcher) to search for text in files
- ``bc`` for ad-hoc CLI calculations, e.g echo 2+2 | bc
- ``ncdu`` like ``du``, but with ncurses
- ``top`` and ``htop`` to view processes

Window Manager: Xmonad
======================

I added little to the `defaults <https://xmonad.org/manpage.html>`__.
See `xmonad.hs <https://github.com/rpuntaie/dotfiles/blob/master/etc/xmonad/xmonad.hs>`__.

``X-s`` screenshot
``X-u`` screenshot allowing seleection
``X-S-p`` passmenu

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

``~/dotfiles/bin/gpgofflinemaster`` works with the separate offline master key.

``~/.gnupg``:
``GNUPGHOME`` is kept at the default location, to be managed separately and offline.
Set it up before ``dotfiles``, as ``restowdots`` will
`use it for ssh <https://wiki.archlinux.org/index.php/GnuPG#SSH_agent>`__.
Else, just ``restowdots`` again.

``~/.password-store``:
``pass`` for password management, managed separately.
``browserpass`` uses it to serve ``browserpass-chromium`` and ``browserpass-firefox``.

``keybase`` for secure chat and file exchange (KBFS).

Systemd User Services
=====================

Local ``mpd.service``, ``keybase.service`` and ``mailsync.timer`` are not enabled by default.
Do e.g.::

  systemctl --user enable --now mpd.service

Email
=====

``install`` downloads `mw <https://github.com/rpuntaie/mailwizard>`__
and uses it to generate email settings in

- ``~/.local/etc/getmail/*``
- ``~/.local/etc/isync/mbsyncrc``
- ``~/.local/etc/msmtp/config``
- ``~/.local/etc/mutt/*``

``mw`` is also used to sync those accounts.
On every sync the ``mw`` account muttrc's are recreated.

To enable automatic syncing::

  systemctl --user enable --now mailsync.timer

else manually in mutt with ``gm`` or on CLI::

  gm  # or mw

A `Maildir <https://wiki2.dovecot.org/MailboxFormat>`__ ``mailbox``
is a directory with `{cur,new,tmp}/<messagefiles>` as text files.
It can be used by programming languages and tools:

- ``isync``'s `mbsync <https://linux.die.net/man/1/mbsync>`__ supports IMAP.
  It syncs between remote and local mailboxes.
  (Alternative to `offlineimap <https://wiki.archlinux.org/index.php/OfflineIMAP>`__,
  which still uses python2)

- `getmail <https://wiki.archlinux.org/index.php/Getmail>`__ supports IMAP and POP.

- ``msmtp`` sends mails, not just for ``mutt``,
  but also for the ``mail`` command (``s-nail`` and ``msmtp-mta`` packages)

- ``notmuch [new]`` indexes (new) mails, then
  ``notmuch address|count|dump|reply|search|show|tag``
  can be `used <https://notmuchmail.org/manpages/>`__.

- ``mutt`` lists messages in already *existing* maildir folders,
  independent of whether created via POP or IMAP.

- `alot <https://www.archlinux.org/packages/community/any/alot/>`__
  shows mails based on tags using ``notmuch`` (``alot taglist``).

- Vim can be used as a MUA
  `via notmuch <https://github.com/notmuch/notmuch/blob/master/vim/notmuch.vim>`__.

- ``mailx``: ``echo 'message body test' | mailx -s "test with mailx" <email>``

- `afew <https://github.com/afewmail/afew>`__ is a python wrapper on ``notmuch`` for tagging and
  `moving <https://github.com/afewmail/afew/blob/master/docs/move_mode.rst>`__ mails.
  Note, that the `query format <https://xapian.org/docs/queryparser.html>`__
  is not generally regular expressions: ``notmuch search <test your search pattern>``.
  Specifically ``to:`` means ``To:`` and ``Cc:`` and accepts only
  `names or email addresses <https://notmuchmail.org/manpages/notmuch-search-terms-7/>`__.

  ``gm`` calls ``getmail/isync``, then ``notmuch``, which calls ``afew`` via the
  ``~/Mail/.notmuch/hooks/post-new`` configuration.

  My `afew config <https://raw.githubusercontent.com/rpuntaie/dotfiles/desktop/etc/afew/config>`__
  folders similar mails into mailboxes with same name accross emails.
  Via `FolderNameFilter` they get the same tag and can be viewed/searched accross emails with ``alot``/``notmuch``.

Since the messages are text, they can be search with ``ag``, ``rg`, ``vimgrep``, ...

Programming
===========

My local arch package `rpuntaie <https://github.com/rpuntaie/rollarch/blob/master/pkg/rpuntaie/PKGBUILD>`__
contains packages for languages I worked with so far

Native:

- C/C++: gcc, clang, cling
- Pascal: fpc

.NET:

- C#: mono dotnet-sdk

JVM:

- Java: jdk-openjdk

Interpreted:

- `Python <https://docs.python.org/3.8/>`__.
  Packages not arch repos: `my_python <https://raw.githubusercontent.com/rpuntaie/dotfiles/desktop/bin/my_python>`__.
- `R <https://www.r-project.org/>`_ (maths)
- `octave <https://hg.savannah.gnu.org/hgweb/octave/file/>`_ (matlab alternative)
- SQL: `sqlite <https://www.sqlite.org/cli.html>`__ `mariadb <https://devhints.io/mysql>`__
- `JavaScript <https://github.com/mbeaudru/modern-js-cheatsheet>`__: `nodejs <https://gist.github.com/LeCoupa/985b82968d8285987dc3>`__
  Packages not in arch repos:
  `my_nodejs <https://raw.githubusercontent.com/rpuntaie/dotfiles/desktop/bin/my_nodejs>`__.

These I fiddled around with or intend to or rather not:

- Native:
  `haskell <https://learnxinyminutes.com/docs/haskell/>`__ (ghc),
  `go <https://gobyexample.com/>`__,
  `rust <https://doc.rust-lang.org/rust-by-example/>`__,
  `apple <https://developer.apple.com/documentation>`__: objc and `swift <https://docs.swift.org/swift-book/LanguageGuide/Functions.html>`__,
  D
- Interpreted: 
  `julia <https://julialang.org/learning/>`__,
  `examples <https://juliabyexample.helpmanual.io/>`__,
  `ruby <https://ruby-doc.org/>`__,
  `lua <https://www.lua.org/manual/5.3/>`__,
  `php <https://www.php.net/manual/en/index.php>`__,
  `ocaml <https://ocaml.org/learn/taste.html>`__
- JVM:
  `clojure <https://kimh.github.io/clojure-by-example/#about>`__,
  `kotlin <https://kotlinlang.org/docs/reference/>`__,
  `groovy <https://groovy-lang.org/documentation.html>`__,
  `scala <https://docs.scala-lang.org/cheatsheets/index.html>`__
- Erlang:
  `elixir <https://elixir-lang.org/crash-course.html>`__

**C++** is very expressive and has

- `standard library <http://www.cplusplus.com/reference/>`__
- `boost <https://www.boost.org/>`__ 
- and can call any C system libraries without glue code
  (`glibc <https://sourceware.org/git/?p=glibc.git>`__, `libusb <https://github.com/libusb/libusb>`__, ...)

but as a compiled language, the *code-test* cycle is cumbersome,
although `cling <https://github.com/root-project/cling>`__ helps:

.. code:: cpp

    #include "myfile.hpp"
    #pragma cling load("myfile.so.9.220.0")

**Python** is interpreted by design and has an amazing standard library.

`Interactive languages <https://en.wikipedia.org/wiki/List_of_programming_languages_by_type#Interactive_mode_languages>`__,
like **Python**,
are a step forward from a `CLI <https://en.wikipedia.org/wiki/Command-line_interface>`__,
because they augment the concept space of processes, files and pipes with
those of threads and data structures and APIs, without the need to compile in between
(`REPL <https://en.wikipedia.org/wiki/Read%E2%80%93eval%E2%80%93print_loop>`__).

Applications
============

Generally I've moved away from GUIs, as they are not easily automated.
Languages can be automated and are more flexible and trackable.
Every application area has its `DSL <https://en.wikipedia.org/wiki/Domain-specific_language>`__.
I prefer an imlementation in a general REPL language, specifically Python, though.

:Typesetting:

  I prefer `light markup <https://en.wikipedia.org/wiki/Lightweight_markup_language>`__,
  specifically `rst <https://en.wikipedia.org/wiki/ReStructuredText>`__,
  for which I made `rstdoc <https://github.com/rpuntaie/rstdoc>`__.

  `html <https://github.com/diegocard/awesome-html5>`__

  `latex <https://github.com/egeerardyn/awesome-LaTeX>`__

  `libreoffice <https://github.com/LibreOffice/core>`__

:Graphics:

  Basically those supported by `rstdoc <https://github.com/rpuntaie/rstdoc>`__:
  `svg <https://learn-the-web.algonquindesign.ca/topics/svg-cheat-sheet/>`__,
  `eps <https://staff.science.uva.nl/a.j.p.heck/Courses/Mastercourse2005/tutorial.pdf>`__,
  `dot <https://www.graphviz.org/doc/info/lang.html>`__,
  `tikz <https://github.com/xiaohanyu/awesome-tikz>`__,
  `plantuml <http://plantuml.com/command-line>`__,
  `matplotlib <https://matplotlib.org/gallery/index.html>`__,
  `pillow <https://pillow.readthedocs.io/en/stable/>`__,
  `imagemagick <https://github.com/ImageMagick/ImageMagick>`__,
  `pyx <https://pyx-project.org/>`__,
  `pygal <http://pygal.org/en/stable/>`__

  `Fontforge <https://github.com/fontforge/fontforge>`__

  `Inkscape <https://gitlab.com/inkscape/inkscape>`__

  `Gimp <https://gitlab.gnome.org/GNOME/gimp>`__

  `Blender <https://github.com/sobotka/blender>`__

:CAD:

  `OpenScad <https://www.openscad.org/cheatsheet/>`__

  Python: 
  `PythonOCC <https://cdn.rawgit.com/tpaviot/pythonocc-core/804f7f3/doc/apidoc/0.18.1/>`__,
  `pyOCCT <https://github.com/LaughlinResearch/pyOCCT>`__

  `librecad <https://github.com/LibreCAD/LibreCAD>`__

:Mathematics:

  `Sagemath <http://doc.sagemath.org/html/en/tutorial/tour_algebra.html>`_

  Python:
  `sympy <https://docs.sympy.org/latest/index.html>`__

:Electronics:

  `ngspice <https://github.com/imr/ngspice>`__
  (`doc <http://ngspice.sourceforge.net/docs/ngspice-manual.pdf>`__)

  Python:
  `pyspice <https://github.com/FabriceSalvaire/PySpice>`__

  `kicad <http://docs.kicad-pcb.org/>`__




.. _`rollarch`: https://github.com/rpuntaie/rollarch
