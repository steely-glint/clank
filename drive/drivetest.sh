#!/bin/sh -v
pwml=/sys/class/pwm/pwmchip0/pwm0/duty_cycle
if [ -d /sys/class/pwm/pwmchip1 ]; then
	pwmr=/sys/class/pwm/pwmchip1/pwm0/duty_cycle
	gpiol=/sys/class/gpio/gpio7/value
	gpior=/sys/class/gpio/gpio8/value
else
	pwmr=/sys/class/pwm/pwmchip0/pwm1/duty_cycle
	gpiol=/sys/class/gpio/gpio400/value
	gpior=/sys/class/gpio/gpio424/value
fi
(cd ..; ./mendelcam --model models/litrace.tflite --labels models/steer.txt) | ./drive ${pwml} ${pwmr} ${gpiol} ${gpior}
