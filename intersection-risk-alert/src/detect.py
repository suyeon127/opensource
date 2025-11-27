# detect.py
# YOLO를 이용해서 한 프레임에서 사람/차량을 탐지하는 모듈

from ultralytics import YOLO

# COCO 클래스 중 관심 있는 것만 사용
TARGET_CLASSES = {"person", "car", "bus", "truck"}

# YOLO 모델 전역으로 로드 (처음에 한 번만)
model = YOLO("yolov8n.pt")  # 처음 실행 시 자동 다운로드


def run_detection(frame, conf_thresh=0.4):
    """
    한 프레임에서 person/car/bus/truck 만 탐지해서
    리스트로 반환하는 함수.

    반환 형식:
    [
        {
            "bbox": (x1, y1, x2, y2),
            "class": "person",
            "score": 0.87,
        },
        ...
    ]
    """
    results = model(frame, conf=conf_thresh, verbose=False)
    result = results[0]

    detections = []

    for box in result.boxes:
        cls_id = int(box.cls[0].item())
        cls_name = result.names[cls_id]
        conf = float(box.conf[0].item())

        if cls_name not in TARGET_CLASSES:
            continue

        x1, y1, x2, y2 = box.xyxy[0]
        x1, y1, x2, y2 = map(int, [x1, y1, x2, y2])

        detections.append(
            {
                "bbox": (x1, y1, x2, y2),
                "class": cls_name,
                "score": conf,
            }
        )

    return detections

