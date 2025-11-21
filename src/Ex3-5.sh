#!/bin/bash
# Ex3-5.sh
run_cmd() {
  local cmd=$1
  shift
  local opts="$@"
  echo "실행: $cmd $opts"
  eval "$cmd $opts"
}
run_cmd ls "$@"
