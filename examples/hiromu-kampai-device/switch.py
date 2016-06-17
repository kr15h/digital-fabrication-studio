import RPi.GPIO as GPIO
import time
import os
from os import listdir
from os.path import isfile, join
import random

onlyfiles = [f for f in listdir("/home/pi/hiromu/sounds") if isfile(join("/home/pi/hiromu/sounds", f))]
print(onlyfiles)
print(onlyfiles[1])
print(len(onlyfiles))

GPIO.setmode(GPIO.BCM)

GPIO.setup(18, GPIO.IN, pull_up_down=GPIO.PUD_UP)

buttonPressed = False

while True:
    input_state = GPIO.input(18)
    if input_state == False:
        if buttonPressed == False:
            print('Button Pressed')
            rand = random.randrange(0, len(onlyfiles) - 1, 1)
            print(onlyfiles[rand])
            soundDir = '/home/pi/hiromu/sounds/'
            command = 'mpg321 "' + soundDir + onlyfiles[rand] + '" &'
            os.system(command)
        buttonPressed = True
        time.sleep(0.2)
    else:
        buttonPressed = False
