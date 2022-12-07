#!/bin/sh -v
cd /sys/class/pwm/
(echo 0 > pwmchip0/export)
(echo 1000000 > pwmchip0/pwm0/period )
(echo 1 > pwmchip0/pwm0/enable )
if [ -d /sys/class/pwm/pwmchip1 ]; then 
	echo "Dev board"
	(echo 0 > pwmchip1/export)
	(echo 1000000 > pwmchip1/pwm0/period )
	(echo 1 > pwmchip1/pwm0/enable )
	cd /sys/class/gpio/
	(echo '7' > export)
	(echo '8' > export)
	(echo out > gpio7/direction)
	(echo out > gpio8/direction)
else
	echo "Dev board mini"
	(echo 1 > pwmchip0/export)
	(echo 1000000 > pwmchip0/pwm1/period )
	(echo 1 > pwmchip0/pwm1/enable )
	cd /sys/class/gpio/
	(echo '400' > export)
	(echo '424' > export)
	(echo out > gpio400/direction)
	(echo out > gpio424/direction)
fi
if [ -b /dev/sda1 ]; then 
    mount -o rw,users,uid=1000,gid=1000,dmask=007,fmask=117 /dev/sda1 /mnt
fi



