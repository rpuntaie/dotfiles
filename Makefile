all:
	@echo "make install: run directory_structure, links and xmonad_xdg_workaround"
	@echo "make directory_structure: create a FHS-like structure under ~/.local"
	@echo "make links: use stow to install configuration and scripts"
	@echo "make xmonad_xdg_workaround: link xmonad configuration folder to ~/.xmonad and recompile"
	@echo "make pamenv_selinux_fix: fix selinux context for ~/.pam_environment"

install: directory_structure links xmonad_xdg_workaround

directory_structure:
	mkdir -p $(HOME)/.local/etc
	mkdir -p $(HOME)/.local/bin
	mkdir -p $(HOME)/.local/opt
	mkdir -p $(HOME)/.local/run
	mkdir -p $(HOME)/.local/var/log
	mkdir -p $(HOME)/.local/var/lib
	mkdir -p $(HOME)/.local/var/cache

links:
	stow --verbose --target $(HOME) home
	stow --verbose --target $(HOME)/.local/etc etc
	stow --verbose --target $(HOME)/.local/bin bin
	stow --verbose --target $(HOME)/.local/var/lib data

# Xmonad do not respect xdg yet
xmonad_xdg_workaround:
	ln -sf $(HOME)/.local/etc/xmonad $(HOME)/.xmonad
	xmonad --recompile

pam_env_selinux_fix:
	./pam_env_selinux_fix.sh

uninstall:
	stow -D home
	stow -D etc
	stow -D bin
	stow -D data
	rm -rf $(HOME)/.local/etc
	rm -rf $(HOME)/.local/bin
	rm -rf $(HOME)/.local/opt
	rm -rf $(HOME)/.local/run
	rm -rf $(HOME)/.local/var/log
	rm -rf $(HOME)/.local/var/lib
	rm -rf $(HOME)/.local/var/cache
	rm -rf $(HOME)/.xmonad
