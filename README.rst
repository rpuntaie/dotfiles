**Customization of my Archlinux system**

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
:README.rst: this file

`rollarch`_ fills `/etc/security/pam_env.conf` with XDG variables.

Full system installation with `rollarch`_:

.. code:: sh

    curl -OLs https://git.io/installarch
    # !replace the defines!
    DSK=/dev/sda USR=u PW=p HST=u121 IP2=1.121 ZONE=Vienna DOTS=fjVcp bash installarch
    # log out and in

Alternatively

.. code:: sh

   mkdir mine
   mount -t nfs -o nfsvers=3 192.168.1.108:/home/roland/mine mine
   lsblk
   DSK=/dev/sda SWAP=off USR=u PW=p HST=u121 IP2=1.121 ZONE=Vienna DOTS=mine/dotfiles/install bash mine/rollarch/rollarch

To update ``~/.local`` after changes:

.. code:: sh

   restowdots

.. _`rollarch`: https://github.com/rpuntaie/rollarch

