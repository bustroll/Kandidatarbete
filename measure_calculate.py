## Measurement program give it which pins as is the Trigger and ECHO
## then get the distance from that sensor (only 1 sensor at all times)

def dist( TRIG, ECHO ):
    import RPi.GPIO as GPIO
    import time
    GPIO.setmode(GPIO.BCM)
    GPIO.setup(TRIG,GPIO.OUT)
    GPIO.setup(ECHO,GPIO.IN)

    #print("Distance Measurement In Progress")
    # Sending out the trigger pulse

    while GPIO.input(ECHO)==1:
        # Wait for old measurment
        jff=time.time()

    GPIO.output(TRIG, True)
    time.sleep(0.00001)
    GPIO.output(TRIG, False)


    while GPIO.input(ECHO)==0:
        pulse_start = time.time()

    while GPIO.input(ECHO)==1:
        pulse_end = time.time()
        #if pulse_end-pulse_start > 0.0233:
        #    #print("far away")
        #    break

    pulse_duration = pulse_end - pulse_start

    distance = pulse_duration * 17150

    distance = round(distance, 2)

    #print("Distance:",distance,"cm")

    return distance;
