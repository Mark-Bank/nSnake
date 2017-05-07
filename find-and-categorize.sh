#!/usr/local/bin/bash

targets="mysqlclient cppconn"

if [[ $# -gt 0 ]]; then
  targets=$@
fi

for target in ${targets}; do

  printf "\n%s%s%s%s\n" "______ PROCESSING ${target} ______"

  locate ${target} | {
    while read f; do
      if [[ $(readlink ${f}) ]]; then
        echo "${f} --> $(readlink ${f})"
      else
        echo "${f} ... ...is_a_file"
      fi
    done
  }           |\
    column -t |\
    sort -k3  |\
    awk '
      BEGIN { print "" }
      {
        if ( NR > 1 && $3 != prev )
          print "";
        print; prev = $3
      } '

done


#locate mysqlclient | {
#  while read f; do
#    if [[ $(readlink ${f}) ]]; then
#      echo "${f} --> $(readlink ${f})"
#    else
#      echo "${f} ... ...is_a_file"
#    fi
#  done
#}           |\
#  column -t |\
#  sort -k3  |\
#  awk '
#    BEGIN { print "" }
#    {
#      if ( NR > 1 && $3 != prev )
#        print "";
#      print; prev = $3
#    } '
#
