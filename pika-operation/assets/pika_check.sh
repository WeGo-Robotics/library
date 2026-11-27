#!/usr/bin/env bash
# AgileX PIKA 설치 점검 (설치·운용 설명서 2장 2.1~2.5)
# 실행: bash ~/pika_check.sh
ok() { echo "  [통과] $1"; }
ng() { echo "  [확인 필요] $1"; BAD="$BAD $2"; }
has() { command -v "$1" >/dev/null 2>&1; }
pkg() { dpkg-query -W -f='${Status}' "$1" 2>/dev/null | grep -q 'ok inst'; }
BAD=""

echo "[준비] ROS 2 Humble"
[ -f /opt/ros/humble/setup.bash ] && ok "ROS 2 Humble 설치됨" || ng "ROS 2 Humble 없음" 0

echo "[2.1] 기본 도구"
for c in git curl cmake g++ unzip; do
  has $c && ok "$c" || ng "$c 없음" 1
done

echo "[2.2] Pika 소프트웨어"
for d in PikaAnyArm data_msgs data_tools; do
  [ -n "$(ls -A ~/pika_ros/src/$d 2>/dev/null)" ] \
    && ok "src/$d" || ng "src/$d 비어 있음" 2
done
[ -d ~/pika_ros/install/pika_locator ] && ok "install 풀림" \
  || ng "install 없음" 2
n=$(grep -c '^source ~/pika_ros/install/setup.bash' ~/.bashrc 2>/dev/null)
n=${n:-0}
[ "$n" = 1 ] && ok ".bashrc Pika 줄 1개" || ng ".bashrc Pika 줄 ${n}개" 2

echo "[2.3] RealSense 라이브러리"
ldconfig -p | grep -q 'librealsense2.so.2.55 ' \
  && ok "librealsense2.so.2.55" || ng "librealsense 없음" 3
has rs-enumerate-devices && ok "rs-enumerate-devices" \
  || ng "rs-enumerate-devices 없음" 3
[ -d ~/librealsense-2.55.1 ] && ok "~/librealsense-2.55.1" \
  || ng "홈 폴더에 librealsense-2.55.1 없음" 3
x=$(find ~/pika_ros -maxdepth 3 -name package.xml \
  -path '*librealsense*' 2>/dev/null)
[ -z "$x" ] && ok "~/pika_ros 안에 librealsense 없음" \
  || ng "~/pika_ros 안에 librealsense가 있음 (2.5 안 될 때)" 5

echo "[2.4] 패키지 · 장치 권한"
m=""
for p in libjsoncpp-dev libpcap-dev python3-pcl freeglut3-dev \
  liblapacke-dev libopenblas-dev libatlas-base-dev libgtk-3-dev \
  libglfw3-dev libopenvr-dev ros-humble-diagnostic-updater \
  ros-humble-pcl-conversions cutecom python3-colcon-common-extensions; do
  pkg $p || m="$m $p"
done
[ -z "$m" ] && ok "패키지" || ng "빠진 패키지:$m" 4
has gcc-13 && ok "gcc-13" || ng "gcc-13 없음" 4
python3 -c "import pyAgxArm, cv2" 2>/dev/null && ok "pyAgxArm · cv2" \
  || ng "pyAgxArm 또는 opencv 없음" 4
for r in 81-vive.rules 99-realsense-libusb.rules; do
  [ -f /etc/udev/rules.d/$r ] && ok "$r" || ng "$r 없음" 4
done

echo "[2.5] 빌드"
source /opt/ros/humble/setup.bash 2>/dev/null
source ~/pika_ros/install/setup.bash 2>/dev/null
L=$(ros2 pkg list 2>/dev/null)
for p in sensor_tools pika_locator pika_remote_agx_arm realsense2_camera; do
  echo "$L" | grep -qx $p && ok "$p" || ng "$p 없음" 5
done
cd ~/pika_ros/install 2>/dev/null && for f in \
  realsense2_camera/lib/librealsense2_camera.so \
  pika_locator/lib/pika_locator/pika_single_locator_node \
  sensor_tools/lib/sensor_tools/serial_gripper_imu; do
  n=$(ldd $f 2>/dev/null | grep -c 'not found')
  [ -f $f ] && [ "$n" = 0 ] && ok "${f##*/}" || ng "${f##*/} 문제" 5
done

echo
if [ -z "$BAD" ]; then
  echo "결과: 모두 통과"
else
  first=$(echo $BAD | tr ' ' '\n' | sort -n | head -1)
  if [ "$first" = 0 ]; then
    echo "결과: ROS 2 Humble이 설치되어 있지 않습니다. ROS 2 Humble을 먼저 설치합니다."
  else
    echo "결과: 확인 필요 항목이 있습니다. 2.${first}부터 봅니다."
  fi
fi
