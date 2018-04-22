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
  if [ $(cat $STORE | wc -l) -eq 0 ]; then
    echo "There is no saved directory. Exiting."
    exit 1
  fi

  wd=$(tail -n 1 $STORE)
  cd $wd; sed -i '$ d' $STORE
  echo "Restored $wd."
}

print_usage() {
  echo "Usage: $(basename $0) [-r|-s]"
}

main() {
  case "$1" in
    "-s")
      save_working_directory
      ;;

    "-r")
      restore_working_directory
      ;;

    *)
      print_usage
      ;;

  esac
}

main $@
