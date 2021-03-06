#! /usr/bin/env nix-shell
#! nix-shell -i bash -p python3 ffmpeg

set -ex

if [ -z "$1" ]; then
    exit 1
fi

STAT=$(mktemp)
INFO=$(ffprobe -v error -select_streams v:0 -show_entries stream=width,height,r_frame_rate -of csv=s=x:p=0 "$1")

# FHD 30fps = 3500k
BITS=$(python3 -c "
parts='$INFO'.split('x')
x=int(parts[0])
y=int(parts[1])
fr=eval(parts[2])
print(int(x*y*fr*3500/30/1920/1080),end='')
")k

# 1pass
ffmpeg -y -i "$1" -c:v libx265 -b:v $BITS -pass 1 -passlogfile "${STAT}" -an -f null /dev/null
# 2pass
ffmpeg -i "$1" -c:v libx265 -b:v $BITS -pass 2 -passlogfile "${STAT}" -c:a copy "${1%.*}_new.mkv"

