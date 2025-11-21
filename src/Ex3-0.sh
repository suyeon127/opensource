#!/bin/bash
# Ex3-0.sh
BASHRC="$HOME/.bashrc"
VARLINE='export MYENV="Hello Shell"'

echo "=== Ex3-0: 환경변수 등록/유지/해제 실습 ==="

echo "[1] .bashrc 등록 여부 확인"
if ! grep -q 'export MYENV="Hello Shell"' "$BASHRC"; then
  echo "$VARLINE" >> "$BASHRC"
  echo "-> .bashrc에 MYENV 추가 완료"
else
  echo "-> 이미 .bashrc에 MYENV 있음"
fi

echo
echo "[2] 현재 쉘에서 source로 반영"
source "$BASHRC"
echo "현재 MYENV 값: $MYENV"

echo
echo "[3] 새 쉘에서도 유지되는지 확인"
bash -lc 'echo "서브쉘 MYENV 값: $MYENV"'

echo
echo "[4] 환경변수 해제(unset)"
unset MYENV
echo "unset 후 MYENV 값: $MYENV"

echo
echo "[5] 서브쉘에서 다시 확인(해제하면 유지 X)"
bash -lc 'unset MYENV; echo "서브쉘 unset 후 MYENV 값: $MYENV"'
