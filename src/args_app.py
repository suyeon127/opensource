#!/usr/bin/env python3
import sys
print("=== Program Start ===")
print("입력 인자 개수:", len(sys.argv)-1)
for i, arg in enumerate(sys.argv[1:], 1):
    print(f"arg{i} = {arg}")
print("=== Program End ===")
