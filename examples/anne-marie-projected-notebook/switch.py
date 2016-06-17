import RPi.GPIO as GPIO
import time
import os
import psutil
import subprocess

# Get framebuffer resolution
proc = subprocess.Popen(["fbset | grep 'mode '"], stdout=subprocess.PIPE, shell=True)
(out, err) = proc.communicate()
i = out.index('"') + 1
out = out[i:]
i = out.index('"')
out = out[:i]
i = out.index('x')
xres = out[:i]
yres = out[i + 1:]

# Create the --win argument string
winArg = '--win 0,0,' + xres + ',' + yres

# Set up GPIO
GPIO.setmode(GPIO.BCM)
GPIO.setup(18, GPIO.IN, pull_up_down=GPIO.PUD_UP)
buttonPressed = False

while True:
    input_state = GPIO.input(18)
    if input_state == False:
        if buttonPressed == False:
            print('Button Pressed')
            sysCmd = '/usr/bin/omxplayer --loop --no-osd ' + winArg + ' /boot/video.mp4 &'
            print(sysCmd)
            os.system(sysCmd)
        buttonPressed = True
    else:
        for p in psutil.process_iter():
           if p.name() == "omxplayer":
               print('killing process "omxplayer"')
               os.system('killall omxplayer')
           if p.name() == "omxplayer.bin":
               print('killing process "omxplayer.bin"')
               os.system('killall omxplayer.bin')
	#playerProcess = os.system('ps -e | grep "omxplayer"')
        #print(type(playerProcess))
        #if type(playerProcess) is str:
        #    print('Player process found, attempting to kill.')
        #    print('Killing process with name "omxplayer".')
        #    os.system('killall omxplayer')
        #    print('Killing process with name "omxplayer.bin"')
        #    os.system('killall omxplayer.bin')
        buttonPressed = False
    time.sleep(0.2)
