#!/bin/bash -eu
# https://github.com/Chinachu/Chinachu/wiki/Configuration-recordedCommand

DST_DIR="/usr/local/chinachu/video"
LOG_DIR="/usr/local/chinachu/video/logs"

arg="${1-}"

if [ -z "$arg" ]; then
	echo "Usage: recordedCommand.sh source/video/path.m2ts"
	exit 1
fi

base=$(basename -s .m2ts "$arg")
src="$arg"
dst="$DST_DIR/$base.mp4"
mkdir -p "$LOG_DIR"

ffmpeg -n -hwaccel vaapi -hwaccel_output_format vaapi \
	-i "$src" -filter:v "format=nv12|vaapi,deinterlace_vaapi" -c:v h264_vaapi -preset medium -crf 23 \
	-c:a copy -bsf:a aac_adtstoasc \
	"$dst" > "$LOG_DIR/$base.log" 2>&1

exit
