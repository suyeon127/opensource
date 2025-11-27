# risk.py
# 보행자와 차량 사이 거리로 위험도 계산

import math


def assign_risks(detections, frame_shape):
    """
    detections 리스트에 각 보행자(person)에 대해
    'risk' 값을 추가하는 함수.

    risk 값:
      0: 안전
      1: 주의
      2: 위험
    """
    h, w, _ = frame_shape

    persons = []
    vehicles = []

    # 보행자 / 차량 리스트 분리 + 중심좌표 계산
    for i, det in enumerate(detections):
        cls_name = det["class"]
        x1, y1, x2, y2 = det["bbox"]
        cx = (x1 + x2) / 2
        cy = (y1 + y2) / 2

        if cls_name == "person":
            persons.append((i, cx, cy))
        elif cls_name in ["car", "bus", "truck"]:
            vehicles.append((i, cx, cy))

    # 기본 risk = 0
    for det in detections:
        det["risk"] = 0

    # 차량이 하나도 없으면 전부 안전
    if not vehicles:
        return detections

    # 각 보행자에 대해 가장 가까운 차량까지 거리 계산
    for pi, px, py in persons:
        min_d_norm = 999.0

        for vi, vx, vy in vehicles:
            d = math.sqrt((px - vx) ** 2 + (py - vy) ** 2)
            d_norm = d / h  # 프레임 높이로 정규화
            if d_norm < min_d_norm:
                min_d_norm = d_norm

        # 임계값: 필요에 따라 조절 (지금은 조금 넉넉하게 설정)
        if min_d_norm < 0.08:
            detections[pi]["risk"] = 2  # 위험
        elif min_d_norm < 0.18:
            detections[pi]["risk"] = 1  # 주의
        else:
            detections[pi]["risk"] = 0  # 안전

    return detections

