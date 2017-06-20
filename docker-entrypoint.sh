#!/bin/bash
# Source used from container _/composer

isCommand() {
  for cmd in \
    "new" \
    "restore" \
    "run" \
    "publish"
  do
    if [ -z "${cmd#"$1"}" ]; then
      return 0
    fi
  done

  return 1
}

# check if the first argument passed in looks like a flag
if [ "$(printf %c "$1")" = '-' ]; then
  set -- /sbin/tini -- dotnet "$@"
# check if the first argument passed in is dotnet
elif [ "$1" = 'dotnet' ]; then
  set -- /sbin/tini -- "$@"
# check if the first argument passed in matches a known command
elif isCommand "$1"; then
  set -- /sbin/tini -- dotnet "$@"
fi

exec "$@"