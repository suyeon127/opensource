#!/bin/bash
# Ex3-8.sh
BASE=$(pwd)
DBDIR="$BASE/DB"
TRAINDIR="$BASE/train"
echo "=== Ex3-8 ==="
if [ ! -d "$DBDIR" ]; then
  mkdir "$DBDIR"
  echo "DB 폴더 생성."
else
  echo "DB 폴더 이미 존재."
fi
cd "$DBDIR"
for i in {1..5}; do
  echo "data file $i" > "data$i.txt"
done
echo "5개 파일 생성 완료."
tar -czf DB_files.tar.gz data*.txt
echo "압축 파일 생성: DB_files.tar.gz"
cd "$BASE"
mkdir -p "$TRAINDIR"
cd "$TRAINDIR"
rm -f data*.txt
for f in "$DBDIR"/data*.txt; do
  ln -s "$f" .
done
echo "train 폴더 링크 완료."
ls -l
