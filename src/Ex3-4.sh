#!/bin/bash
# Ex3-4.sh
scores=()
to_gpa() {
  local s=$1
  if [ $s -ge 90 ]; then echo 4.0
  elif [ $s -ge 80 ]; then echo 3.0
  elif [ $s -ge 70 ]; then echo 2.0
  elif [ $s -ge 60 ]; then echo 1.0
  else echo 0.0
  fi
}
while true; do
  echo "================"
  echo "1. 과목 성적 추가"
  echo "2. 입력된 모든 점수 보기"
  echo "3. 평균 점수 확인"
  echo "4. 평균 등급 (GPA) 변환"
  echo "5. 종료"
  echo "================"
  read -p "메뉴 선택: " menu
  case $menu in
    1)
      read -p "추가할 점수(0~100): " s
      if [ $s -lt 0 ] || [ $s -gt 100 ]; then
        echo "범위 오류!"
      else
        scores+=($s)
        echo "추가 완료."
      fi
      ;;
    2)
      if [ ${#scores[@]} -eq 0 ]; then
        echo "점수 없음"
      else
        echo "점수 목록: ${scores[@]}"
      fi
      ;;
    3)
      if [ ${#scores[@]} -eq 0 ]; then
        echo "점수 없음"
      else
        sum=0
        for s in "${scores[@]}"; do sum=$((sum + s)); done
        avg=$((sum / ${#scores[@]}))
        echo "평균 점수: $avg"
      fi
      ;;
    4)
      if [ ${#scores[@]} -eq 0 ]; then
        echo "점수 없음"
      else
        sum=0
        for s in "${scores[@]}"; do sum=$((sum + s)); done
        avg=$((sum / ${#scores[@]}))
        gpa=$(to_gpa $avg)
        echo "평균 점수: $avg -> GPA: $gpa"
      fi
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
