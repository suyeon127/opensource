# main.py
# 교차로/횡단보도 영상에서
# 사람/차량 탐지 + 거리 기반 보행자 위험도 시각화 메인 스크립트

import sys
import cv2

from detect import run_detection
from risk import assign_risks
from visualize import draw_detections


def get_video_path():
    """
    커맨드라인 인자로 영상 이름(traffic1, traffic2...)을 받되,
    없으면 기본값으로 videos/traffic1.mp4 사용.
    """
    base = "../videos"
    default_name = "traffic1.mp4"

    if len(sys.argv) >= 2:
        name = sys.argv[1]
        if not name.endswith(".mp4"):
            name += ".mp4"
    else:
        name = default_name

    return f"{base}/{name}"


def main():
    video_path = get_video_path()
    print(f"[정보] 사용할 영상: {video_path}")

    cap = cv2.VideoCapture(video_path)
    if not cap.isOpened():
        print(f"[에러] 비디오를 열 수 없습니다: {video_path}")
        return

    fps = cap.get(cv2.CAP_PROP_FPS)
    w = int(cap.get(cv2.CAP_PROP_FRAME_WIDTH))
    h = int(cap.get(cv2.CAP_PROP_FRAME_HEIGHT))
    print(f"[정보] FPS: {fps}, W x H: {w} x {h}")

    while True:
        ret, frame = cap.read()
        if not ret:
            print("[정보] 비디오 끝.")
            break

        # 1) 탐지
        detections = run_detection(frame, conf_thresh=0.4)

        # 2) 위험도 계산
        detections = assign_risks(detections, frame.shape)

        # 3) 시각화
        frame = draw_detections(frame, detections)

        # 4) 화면 출력
        cv2.imshow("Intersection Risk Alert", frame)

        # q 키를 누르면 종료
        if cv2.waitKey(1) & 0xFF == ord("q"):
            break

    cap.release()
    cv2.destroyAllWindows()


if __name__ == "__main__":
    main()

