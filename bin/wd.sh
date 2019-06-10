#!/bin/sh

STORE=$XDG_DATA_HOME/working_directory

save_working_directory() {
  if [ ! -f $FILE ]; then
    touch $STORE
  fi

  echo $(pwd) >> $STORE
  echo "Saved $(pwd)."
}

restore_working_directory() {
  wd=$(tail -n 1 $STORE)

  if [[ -n $wd ]]; then
	cd $wd
	if [[ -n $1 ]]; then
	  sed -i '$ d' $STORE
	  echo "Removed $wd."
	fi
  fi
}

main() {
  case "$1" in
    "-s")
      save_working_directory
      ;;

    "-r")
      restore_working_directory 1
      ;;

    *)
      restore_working_directory
      ;;

  esac
}

main $@
