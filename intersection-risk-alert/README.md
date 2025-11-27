# Intersection Risk Alert (교차로 근접 위험 알림 시스템)

## 1. 프로젝트 개요

이 프로젝트는 교차로/횡단보도 영상을 입력으로 받아,
보행자와 차량 사이의 거리를 계산하여 프레임 단위 근접 위험도를 
시각화하는 시스템입니다.

- 사람(person), 차량(car, bus, truck)을 YOLO로 탐지
- 보행자와 가장 가까운 차량 사이의 거리를 계산
- 거리 기반으로 보행자 위험도:
  - R0: 안전(초록)
  - R1: 주의(노랑)
  - R2: 위험(빨강)
- 화면 상단에 `High-risk persons (R=2): N` 형태로 위험 보행자 수 요약 표시

## 2. 사용 기술

- Python
- OpenCV (`opencv-python`)
- [Ultralytics YOLOv8](https://docs.ultralytics.com/) (사전 학습된 
`yolov8n.pt` 모델)

## 3. 폴더 구조

```bash
intersection-risk-alert/
├─ src/
│   ├─ main.py        # 전체 실행 스크립트
│   ├─ detect.py      # YOLO 기반 객체 탐지
│   ├─ risk.py        # 보행자-차량 거리 기반 위험도 계산
│   └─ visualize.py   # 탐지/위험도 결과 시각화
├─ videos/
│   ├─ traffic1.mp4
│   ├─ traffic2.mp4
│   ├─ traffic3.mp4
│   └─ traffic4.mp4
└─ requirements.txt

