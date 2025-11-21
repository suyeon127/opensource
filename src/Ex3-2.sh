#!/bin/bash
# Ex3-2.sh
echo "=== Ex3-2: Y = 1/2 x^2 계산 ==="
echo "x 값을 2개 이상 입력하세요. 종료하려면 q"
count=0
while true; do
  read -p "x 입력: " x
  if [ "$x" = "q" ]; then
    break
  fi
  y=$(echo "0.5 * $x * $x" | bc -l)
  echo "x = $x -> y = $y"
  count=$((count + 1))
done
if [ $count -lt 2 ]; then
  echo "경고: 2개 이상 입력해야 과제 조건 만족!"
fi
