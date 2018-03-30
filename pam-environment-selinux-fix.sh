#!/bin/sh

path=$HOME/.dotfiles/home/.pam_environment

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

check_command() {
  if ! [ -x "$(command -v $1)" ]; then
    echo "Error: $1 is not installed." >&2
    exit 1
  fi
}

check_command sudo
check_command semanage
check_command restorecon

if prompt_confirm "Apply selinux context fix for $path ?"; then
  sudo semanage fcontext -a -t local_login_home_t $path
  sudo restorecon -v $path
  echo "Done!"
else
  echo "Abort."
fi
