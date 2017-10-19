#!/bin/bash
# add reversed sequence of images

# count the number of frames
for ((j=0; j<100000; j++)); do
  printf -v n "%04d" $j
  [[ ! -e "vid/chaos$n.png" ]] && break
done
echo $j original images

# add frame pause
p=$((j / 10 + 1))
printf -v s "vid/chaos%04d.png" $((j-1))
for ((k=j; k<j+p; k++)); do
  printf -v d "vid/chaos%04d.png" $k
  cp $s $d
done
echo "added a $p frame pause, frames $j to $((k-1))"

# add reverse sequence
for ((m=k; m<k+j; m++)); do
  printf -v s "vid/chaos%04d.png" $((j+j+p-m-1))
  printf -v d "vid/chaos%04d.png" $m
  cp $s $d
done
echo "added a reverse sequence, frames $k to $((m-1))"

# add final frame pause
printf -v s "vid/chaos%04d.png" $((m-1))
for ((k=m; k<m+p; k++)); do
  printf -v d "vid/chaos%04d.png" $k
  cp $s $d
done
echo "added a $p frame pause, frames $m to $((k-1))"
