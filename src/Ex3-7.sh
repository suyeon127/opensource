#!/bin/bash
# Ex3-7.sh
while true; do
  echo "================"
  echo "1. 사용자 정보"
  echo "2. GPU 또는 CPU 사용률"
  echo "3. 메모리 사용량"
  echo "4. 디스크 사용량"
  echo "5. 종료"
  echo "================"
  read -p "메뉴 선택: " menu
  case $menu in
    1)
      echo "[사용자 정보]"
      whoami
      id
      uptime
      ;;
    2)
      echo "[GPU/CPU 사용률]"
      if command -v nvidia-smi >/dev/null 2>&1; then
        nvidia-smi
      else
        top -bn1 | head -20
      fi
      ;;
    3)
      echo "[메모리 사용량]"
      free -h
      ;;
    4)
      echo "[디스크 사용량]"
      df -h
      ;;
    5)
      echo "종료합니다."
      break
      ;;
    *)
      echo "1~5 중 선택!"
      ;;
  esac
  echo
done
