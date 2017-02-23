echo "#######################################"
echo "This script is designed for ArchLinux !"
echo "#######################################"

# Install yaourt
cd /tmp
git clone https://aur.archlinux.org/package-query.git
cd package-query
makepkg -si
cd ..
git clone https://aur.archlinux.org/yaourt.git
cd yaourt
makepkg -si
cd

# Setup shell-related stuff
sudo pacman -S zsh vim lftp ruby

# Setup Graphical stuff
sudo pacman -S bspwm sxhkd dunst xorg-server xorg-utils xorg-xmodset xorg-xev xorg-init
yaourt -S tint3

# deploy config
./install
