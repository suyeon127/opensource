#!/bin/bash
# Ex3-6.sh
if [ $# -lt 2 ]; then
  echo "사용법: $0 arg1 arg2 [arg3 ...]"
  exit 1
fi
echo "셸에서 실행파일 시작"
./args_app.py "$@"
echo "셸에서 실행파일 종료"
