#!/bin/sh
cd /home/mendel/clank
if [ ! -d snaps ]; then 
	mkdir snaps
fi
nohup java -Xmx256m -cp  pipe-java-client-1.2.5-SNAPSHOT.jar pe.pi.webcam.Clank > pipe.out
