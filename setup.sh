#!/bin/bash

ETC_PATH="$HOME/.local/etc"
BIN_PATH="$HOME/.local/bin"
OPT_PATH="$HOME/.local/opt"
RUNTIME_PATH="$HOME/.local/run"
LOG_PATH="$HOME/.local/var/log"
DATA_PATH="$HOME/.local/var/lib"
CACHE_PATH="$HOME/.local/var/cache"

bold=$(tput bold)
normal=$(tput sgr0)

prompt_confirm() {
  while true; do
    read -r -n 1 -p "${1} [y/n]: " REPLY
    case $REPLY in
      [yY]) echo ; return 0 ;;
      [nN]) echo ; return 1 ;;
      *)printf " \033[31m %s \n\033[0m" "invalid input"
    esac
  done
}

echo "---------------------------------------"
echo "  ____        _    __ _ _           _  "
echo " |  _ \  ___ | |_ / _(_) | ___  ___| | "
echo " | | | |/ _ \| __| |_| | |/ _ \/ __| | "
echo " | |_| | (_) | |_|  _| | |  __/\__ \_| "
echo " |____/ \___/ \__|_| |_|_|\___||___(_) "
echo "                                       "
echo "---------------------------------------"

if ! [ -x "$(command -v stow)" ]; then
  echo 'Error: stow is not installed.' >&2
  exit 1
fi

echo ""
echo "${bold}Target for 'bin':${normal} ${BIN_PATH}"
echo "${bold}Target for 'etc':${normal} ${ETC_PATH}"
echo ""

echo "${bold}> Setting up directory structure :${normal}"

for path in $ETC_PATH $BIN_PATH $OPT_PATH $DATA_PATH $LOG_PATH $RUNTIME_PATH $CACHE_PATH
do
  if ! [ -d $path ]; then
    if prompt_confirm " - $path do not exists. ${bold}Do you want to create it ?${normal}";
    then
      echo "   * Creating $path..."
      mkdir -p $path
    fi
  else
    echo " - $path already exists..."
  fi
done
echo ""

for tuple in home,$HOME etc,$ETC_PATH bin,$BIN_PATH, data,$DATA_PATH
do
  IFS=',' read src_path target_path <<< "${tuple}"
  echo "${bold}> Symbolic links to be created for '${src_path}':${normal}"
  stow --verbose 1 --simulate --target $target_path $src_path
  if prompt_confirm "${bold}Do yo want to proceed ?${normal}"; then
    stow --verbose 1 --target $target_path $src_path
  fi
  echo ""
done

if ! [ -d $HOME/.xmonad ]; then
  if prompt_confirm "${bold}Do you want to apply xmonad's workaround ?${normal}"; then
    echo "Linking ~/.local/etc/xmonad to ~/.xmonad..."
    ln -s $HOME/.local/etc/xmonad $HOME/.xmonad
  fi
fi

echo "${bold}> Everything was processed. Bye!${normal}"
