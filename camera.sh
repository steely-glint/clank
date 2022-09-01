#!/bin/sh -v
if [ ! -e camera.mjpeg ]; then
	mknod camera.mjpeg p
fi
if [ ! -e camera ]; then
	ln camera.mjpeg camera
fi
v4l2-ctl --set-fmt-video width=640,height=480,pixelformat=0 -d /dev/video1
./capturevideo/capturevideo -d /dev/video1 -o -c 300000 > camera.mjpeg 
#ffmpeg -f video4linux2 -input_format mjpeg -y -r 30 -s 640x480 -i /dev/video1 ./camera.mjpeg >>camstart.log 
