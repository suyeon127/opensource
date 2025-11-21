#!/bin/bash
# Ex3-1.sh
if [ $# -ne 2 ]; then
  echo "사용법: $0 num1 num2"
  exit 1
fi
a=$1
b=$2
echo "a = $a, b = $b"
echo "a + b = $((a + b))"
echo "a - b = $((a - b))"
echo "a * b = $((a * b))"
if [ $b -ne 0 ]; then
  echo "a / b = $((a / b))"
else
  echo "a / b = (0으로 나눌 수 없음)"
fi
