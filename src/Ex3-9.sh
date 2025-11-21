#!/bin/bash
# Ex3-9.sh
DB="DB.txt"
touch "$DB"
add_member() {
  read -p "이름: " name
  read -p "생일(YYYY-MM-DD) 또는 전화번호: " info
  echo "MEMBER|$name|$info" >> "$DB"
  echo "팀원 추가 완료."
}
add_work() {
  read -p "날짜(YYYY-MM-DD): " date
  read -p "팀원 이름: " name
  read -p "수행 내용: " content
  echo "WORK|$date|$name|$content" >> "$DB"
  echo "수행 내용 기록 완료."
}
search_member() {
  read -p "검색할 이름: " name
  echo "[팀원 검색 결과]"
  grep "^MEMBER|$name|" "$DB" || echo "없음"
}
search_work() {
  read -p "검색할 날짜: " date
  echo "[수행 내용 검색 결과]"
  grep "^WORK|$date|" "$DB" || echo "없음"
}
while true; do
  echo "========"
  echo "1. 팀원 정보 추가"
  echo "2. 팀원과 한 일 기록"
  echo "3. 팀원 검색"
  echo "4. 수행 내용 검색"
  echo "5. 종료"
  echo "========"
  read -p "메뉴 선택: " menu
  case $menu in
    1) add_member ;;
    2) add_work ;;
    3) search_member ;;
    4) search_work ;;
    5) echo "종료"; break ;;
    *) echo "1~5 중 선택!" ;;
  esac
  echo
done
