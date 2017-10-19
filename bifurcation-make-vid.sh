#!/bin/bash
# make video from png sequence in vid directory

fr=${1:-25}     # framerate

[[ -e chaosvid.mp4 ]] && mv -f chaosvid.mp4 chaosvid.old.mp4

# count the number of frames
for ((j=0; j<100000; j++)); do
  printf -v n "%04d" $j
  [[ ! -e "vid/chaos$n.png" ]] && break
done
echo $j images

ffmpeg -framerate "$fr" -i vid/chaos%04d.png -pix_fmt yuv420p chaosvid.mp4

