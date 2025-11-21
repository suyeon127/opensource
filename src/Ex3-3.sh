#!/bin/bash
# Ex3-3.sh
scores=()
echo "=== Ex3-3: 점수 -> 등급(A/B) 변환 ==="
echo "점수 입력(0~100), 종료: q"
while true; do
  read -p "점수 입력: " s
  if [ "$s" = "q" ]; then break; fi
  if [ $s -lt 0 ] || [ $s -gt 100 ]; then
    echo "0~100 범위만 입력!"
    continue
  fi
  scores+=($s)
done
n=${#scores[@]}
if [ $n -lt 2 ]; then
  echo "과목 2개 이상 입력해야 합니다."
  exit 1
fi
sum=0
echo "----- 각 과목 등급 -----"
for s in "${scores[@]}"; do
  if [ $s -ge 90 ]; then grade="A"; else grade="B"; fi
  echo "점수 $s -> 등급 $grade"
  sum=$((sum + s))
done
avg=$((sum / n))
echo "-----------------------"
echo "평균 점수: $avg"
if [ $avg -ge 90 ]; then avg_grade="A"; else avg_grade="B"; fi
echo "평균 등급: $avg_grade"
