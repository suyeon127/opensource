# visualize.py
# 탐지 + 위험도 결과를 영상 위에 그리는 모듈

import cv2

# 클래스별 기본 색
CLASS_COLORS = {
    "person": (0, 255, 0),     # 초록
    "car": (255, 0, 0),        # 파랑
    "bus": (0, 255, 255),      # 노랑
    "truck": (255, 0, 255),    # 보라
}


def draw_detections(frame, detections):
    """
    탐지 + 위험도 결과를 받아서 frame 위에 박스와 라벨, 요약 정보를 그림.
    """
    high_risk_count = 0

    for det in detections:
        x1, y1, x2, y2 = det["bbox"]
        cls_name = det["class"]
        conf = det["score"]
        risk = det.get("risk", 0)  # default 0

        # 기본 색: 클래스별 색
        color = CLASS_COLORS.get(cls_name, (0, 255, 0))

        # 보행자이면 위험도에 따라 색 덮어쓰기
        if cls_name == "person":
            if risk == 2:
                color = (0, 0, 255)      # 빨강 (위험)
                high_risk_count += 1
            elif risk == 1:
                color = (0, 255, 255)    # 노랑 (주의)
            else:
                color = (0, 255, 0)      # 초록 (안전)

        # 박스
        cv2.rectangle(frame, (x1, y1), (x2, y2), color, 2)

        # 라벨 텍스트 (예: "person 0.85 R2")
        label = f"{cls_name} {conf:.2f}"
        if cls_name == "person":
            label += f" R{risk}"

        (tw, th), baseline = cv2.getTextSize(
            label, cv2.FONT_HERSHEY_SIMPLEX, 0.5, 1
        )
        cv2.rectangle(
            frame,
            (x1, y1 - th - baseline),
            (x1 + tw, y1),
            color,
            -1,
        )
        cv2.putText(
            frame,
            label,
            (x1, y1 - baseline),
            cv2.FONT_HERSHEY_SIMPLEX,
            0.5,
            (0, 0, 0),
            1,
            cv2.LINE_AA,
        )

    # 화면 위쪽에 요약 정보 표시
    info_text = f"High-risk persons (R=2): {high_risk_count}"
    cv2.putText(
        frame,
        info_text,
        (10, 30),
        cv2.FONT_HERSHEY_SIMPLEX,
        0.8,
        (0, 0, 255),
        2,
        cv2.LINE_AA,
    )

    return frame

