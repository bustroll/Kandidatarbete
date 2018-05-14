## head program



## set the pin inputs
import RPi.GPIO as GPIO     # enables the usage of pins on raspberry PI
import time     # enables time measuments
import random   # gives the ability to generate random numbers
GPIO.setmode(GPIO.BCM)

# Sensor front 1
TRIG_front_1= 20
ECHO_front_1= 21
GPIO.setup(TRIG_front_1,GPIO.OUT)
GPIO.setup(ECHO_front_1,GPIO.IN)
GPIO.output(TRIG_front_1, False)

# Sensor front-2
TRIG_front_2= 4
ECHO_front_2= 17
GPIO.setup(TRIG_front_2,GPIO.OUT)
GPIO.setup(ECHO_front_2,GPIO.IN)
GPIO.output(TRIG_front_2, False)

# Sensor Left
TRIG_left_1= 27
ECHO_left_1= 22
GPIO.setup(TRIG_left_1,GPIO.OUT)
GPIO.setup(ECHO_left_1,GPIO.IN)
GPIO.output(TRIG_left_1, False)

# Sensor Right
TRIG_right_1= 10
ECHO_right_1= 9
GPIO.setup(TRIG_right_1,GPIO.OUT)
GPIO.setup(ECHO_right_1,GPIO.IN)
GPIO.output(TRIG_right_1, False)

# Sensor Back
TRIG_back_1 = 19
ECHO_back_1 = 26
GPIO.setup(TRIG_back_1,GPIO.OUT)
GPIO.setup(ECHO_back_1,GPIO.IN)
GPIO.output(TRIG_back_1, False)

# last calibration (wait for sensors to settle after startup)
print ("Waiting For Sensor To Settle")
time.sleep(2)

## import measurements
from measure_sort import mea_sort





status="green"  # tells if it is allowed to drive or not
behavior="forward"  # tells what behavior to do
# diffrent behaviors
# forward
# turn
# go_away
# wall_follow
# spiral
# stuck
# 
robot="start setup" # The iformation sent to the robot so it moves
turn_distance_s=55    # Allowed distance to object + 5 for sensor error
turn_distance=50
too_close=30        # Distance for an object to be too close (and robot should back away)
rot_angle=1     # The time it takes for the robot to rotate 1 degree



# mea_sort() gives back (front, left, right, back, s_front_1, s_front_2)
front=0
left=1
right=2
back=3
s_front_1=4
s_front_2=5

## check too close code (for easier programming)
def check_too_close(behavior, measure):
    if measure[0] < too_close:
        behavior="go_away"
    elif measure[1] < too_close:
        behavior="go_away"
    elif measure[2] < too_close:
        behavior="go_away"
    elif measure[3] < too_close:
        behavior="go_away"
    return behavior


while status=="green":
    if behavior=="forward": # logic for going forward
        measure=mea_sort()
        if measure[front] > turn_distance:
            robot="w"
            print(robot)
        elif too_close < measure[front]:
            behavior="go_away"
        else:
            behavior="turn"
        while behavior=="forward":
            measure=mea_sort()
            if measure[front] < turn_distance:
                behavior="turn"
        robot="s"
        print(robot)

        
        
    if behavior=="turn":    # logic when turning
        measure=mea_sort()
        behavior=check_too_close(behavior, measure)
        if behavior=="turn":
            if s_front_1 > s_front_2:
                robot="a"
                print(robot)
            else:
                robot="d"
                print(robot)

            angle=random(20,180)
            time_rot_start=time.time()
            time_rot_end=time_rot_start+rot_angle*angle
            while time_rot_start < time_rot_end:
                    measure=mea_sort()
                    behavior=check_too_close(behavior, measure)
                    if behavior=="go_away":
                        break
                    time_rot_start=time.time()

            if measure[front] > turn_distance:
                robot="s"
                print(robot)
                behavior="forward"
            else:
                while measure[front] < turn_distance_s:
                    measure=mea_sort()
                    time_diff=time.time()-time_rot_start
                    if time_diff>20:
                        behavior="stuck"
                        break
                if behavior=="stuck":
                    robot="s"
                    print(robot)
                else:
                    robot="s"
                    print(robot)
                    behavior="forward"
        
        
    if behavior=="wall_follow":
        from_start_angle=0  # Calculates total rotational angle
        from_start_distance=time.time()

        while behavior=="wall_follow":
            if measure[front] < turn_distance_s:
                time_s_turn=time.time()
                robot="a"
                print(robot)
                while measure[front] < turn_distance_s:
                    measure=mea_sort()
                    if time.time()-time_s_turn > 10:
                        behavior="stuck"
                        break
                robot="s"
                print(robot)
                time_rot=time.time()-time_s_turn
                from_start_angle=from_start_angle+time_rot/rot_angle

            if measure[right] > turn_distance-10:
                if measure[right] < turn_distance+20:
                    robot="w"
                    print(robot)
                    wall="ok"
                    while wall=="ok":
                        measure=mea_dist()
                        behavior=check_too_close(behavior, measure)
                        if measure[front] < turn_distance:
                            wall="front"
                        elif behavior=="go_away":
                            wall="warning"
                        elif measure[right] < turn_distance-10:
                            wall="close"
                        elif measure[right] > turn_distance+20:
                            wall="far"
                        elif time.time()-from_start_distance > 60:
                            wall="stop"
                            behavior="turn"
                    robot="s"
                    print(robot)

            if measure[right] < turn_distance-10:
                robot="a"
                print(robot)
                time_s_turn=time.time()

                
                while measure_old[right]-measure[right]:
                    measure_old=mea_dist()
                    behavior=check_too_close(behavior, measure_old)
                    if behavior=="go_away":
                        break
                    time.sleep(0.1)
                    measure=mea_dist()
                time.sleep(0.2)
                robot="s"
                print(robot)
                time_rot=time.time()-time_s_turn
                from_start_angle=from_start_angle + time_rot/rot_angle

                
            elif measure[right] > turn_distance+20:
                robot="d"
                print(robot)
                time_s_turn=time.time()
                
                while measure_old[right]-measure[right]:
                    measure_old=mea_dist()
                    behavior=check_too_close(behavior, measure_old)
                    if behavior=="go_away":
                        break
                    time.sleep(0.07)
                    measure=mea_dist()
                time.sleep(0.1)
                robot="s"
                print(robot)
                time_rot=time.time()-time_s_turn
                from_start_angle=from_start_angle - time_rot/rot_angle

            if from_start_angle > 360:
                behavior="stuck"
            elif from_start_angle < 360:
                behavior="stuck"

            if time.time()-from_start_distance > 30:
                behavior="turn"
                
                
    if behavior=="spiral":
        print(robot)


    if behavior=="stuck":
        print(robot)

    if behavior=="go_away":
        print(robot)
        
    



















































## Shut off
GPIO.cleanup()
