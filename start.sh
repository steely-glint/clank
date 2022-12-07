#!/bin/sh
cd /home/mendel/clank
if [ -d /mnt/snaps ]; then 
        nohup java -Xmx256m -cp  pipe-java-client-1.2.6-SNAPSHOT.jar pe.pi.webcam.Clank 2>&1  > pipe.out &
else
	cd drive
	while [ ! -e /dev/video1 ]; do
		echo "Waiting for camera to wake up";
		sleep 1;
	done
        sleep 1;
	nohup ./drivetest.sh 2>&1 > /dev/null  &
	echo "Started drive" 
fi
