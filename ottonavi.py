#!/usr/bin/env python
## head program
#


## set the pin inputs
#import RPi.GPIO as GPIO     # enables the usage of pins on raspberry PI
import time     # enables time measuments
import random   # gives the ability to generate random numbers
import rospy    # gets rospy. added by jojz
#GPIO.setmode(GPIO.BCM)

# Sensor front 1
#TRIG_front_1= 20
#ECHO_front_1= 21
#GPIO.setup(TRIG_front_1,GPIO.OUT)
#GPIO.setup(ECHO_front_1,GPIO.IN)
#GPIO.output(TRIG_front_1, False)

# Sensor front-2
#TRIG_front_2= 4
#ECHO_front_2= 17
#GPIO.setup(TRIG_front_2,GPIO.OUT)
#GPIO.setup(ECHO_front_2,GPIO.IN)
#GPIO.output(TRIG_front_2, False)

# Sensor Left
#TRIG_left_1= 27
#ECHO_left_1= 22
#GPIO.setup(TRIG_left_1,GPIO.OUT)
#GPIO.setup(ECHO_left_1,GPIO.IN)
#GPIO.output(TRIG_left_1, False)

# Sensor Right
#TRIG_right_1= 10
#ECHO_right_1= 9
#GPIO.setup(TRIG_right_1,GPIO.OUT)
#GPIO.setup(ECHO_right_1,GPIO.IN)
#GPIO.output(TRIG_right_1, False)

# Sensor Back
#TRIG_back_1 = 19
#ECHO_back_1 = 26
#GPIO.setup(TRIG_back_1,GPIO.OUT)
#GPIO.setup(ECHO_back_1,GPIO.IN)
#GPIO.output(TRIG_back_1, False)

## import measurements
from measure_sort import mea_sort
from std_msgs.msg import String #added by jojz
from std_msgs.msg import UInt8 #added by jojz


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
turn_distance_s=45    # Allowed distance to object + 5 for sensor error
turn_distance=45
too_close=28        # Distance for an object to be too close (and robot should $
rot_angle=1/48.6     # The time it takes for the robot to rotate 1 degree



# mea_sort() gives back (front, left, right, back, s_front_1, s_front_2)
front=0
left=1
right=2
back=3
s_front_1=4
s_front_2=5
pub = rospy.Publisher('chatter', String, queue_size=10)
rospy.init_node('talker', anonymous=True)

def bananklase():
        pub1 = rospy.Publisher('chatter', String, queue_size=10)
        pub1.publish('g')


## check too close code (for easier programming)
def check_too_close(behavior, measure):
    if measure[0] < too_close:
        behavior="go_away"
        print(behavior)
    elif measure[1] < too_close:
        behavior="go_away"
        print(behavior)
    elif measure[2] < too_close:
        behavior="go_away"
        print(behavior)
    elif measure[3] < too_close:
        behavior="go_away"
        print(behavior)
    elif behavior == "go_away":
        robot="s"
        pub.publish(robot)
        print(robot)
        behavior="forward"
    return behavior

pub.publish('b')
pub.publish('b')
pub.publish('b')
pub.publish('b')
pub.publish('b')
pub.publish('b')
pub.publish('b')
pub.publish('b')




while status=="green" and not rospy.is_shutdown():
    rospy.on_shutdown(bananklase)
    if behavior=="forward": # logic for going forward
        print(behavior)
        measure=mea_sort()
        print(behavior)
        if measure[front] > turn_distance and behavior=="forward":
            robot="w"
            pub.publish(robot)
            print(robot)
        elif too_close < measure[front] and behavior=="forward":
            behavior="go_away"
            print(behavior)
        elif behavior=="forward":
            behavior="turn"
            print(behavior)
        while behavior=="forward":
            measure=mea_sort()
            behavior=check_too_close(behavior, measure)
            if measure[front] < turn_distance:
                behavior="turn"
        robot="s"
        pub.publish(robot)
        print(robot)


    if behavior=="turn":    # logic when turning
        print(behavior)
        measure=mea_sort()
        robot="x"
        pub.publish(robot)
        print(robot)
        time.sleep(0.4)
        robot="s"
        pub.publish(robot)
        print(robot)
        behavior=check_too_close(behavior, measure)
        if behavior=="turn":
            if measure[s_front_1] > measure[s_front_2]:
                robot="a"
                pub.publish(robot)
                print(robot)
            else:
                robot="d"
                pub.publish(robot)
                print(robot)

            angle=random.randint(20,180)
            time_rot_start=time.time()
            time_rot_end=time_rot_start+rot_angle*angle
            while time_rot_start < time_rot_end:
                    measure=mea_sort()
                    behavior=check_too_close(behavior, measure)
                    if behavior=="go_away":
                        break
                    time_rot_start=time.time()
            #print("sleep test")
            #time.sleep(angle*rot_angle)
            if measure[front] > turn_distance:
                robot="s"
                pub.publish(robot)
                print(robot)
                behavior="forward"
            else:
                print("sleep test 2")
                while measure[front] < turn_distance_s:
                    measure=mea_sort()
                    time_diff=time.time()-time_rot_start
                    if time_diff>20:
                        behavior="stuck"
                        break
                if behavior=="stuck":
                    robot="s"
                    pub.publish(robot)
                    print(robot)
                else:
                    robot="s"
                    pub.publish(robot)
                    print(robot)
                    behavior="forward"


    if behavior=="wall_follow":
        print(behavior)
        from_start_angle=0  # Calculates total rotational angle
        from_start_distance=time.time()

        while behavior=="wall_follow":
            if measure[front] < turn_distance_s:
                time_s_turn=time.time()
                robot="a"
                pub.publish(robot)
                print(robot)
                while measure[front] < turn_distance_s:
                    measure=mea_sort()
                    if time.time()-time_s_turn > 10:
                        behavior="stuck"
                        break
                robot="s"
                pub.publish(robot)
                print(robot)
                time_rot=time.time()-time_s_turn
                from_start_angle=from_start_angle+time_rot/rot_angle

            if measure[right] > turn_distance-10:
                if measure[right] < turn_distance+20:
                    robot="w"
                    pub.publish(robot)
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
                    pub.publish(robot)
                    print(robot)

            if measure[right] < turn_distance-10:
                robot="a"
                pub.publish(robot)
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
                pub.publish(robot)
                print(robot)
                time_rot=time.time()-time_s_turn
                from_start_angle=from_start_angle + time_rot/rot_angle


            elif measure[right] > turn_distance+20:
                robot="d"
                pub.publish(robot)
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
                pub.publish(robot)
                print(robot)
                time_rot=time.time()-time_s_turn
                from_start_angle=from_start_angle - time_rot/rot_angle

            if from_start_angle > 360:
                behavior="stuck"
            elif from_start_angle < 360:
                behavior="stuck"

            if time.time()-from_start_distance > 30:
                behavior="turn"


    if behavior=="stuck":
        print(behavior)
        robot="s"
        pub.publish(robot)
        print(robot)
        status = "red"
    if behavior=="go_away":
        print(behavior)
        measure=mea_sort()
        behavior=check_too_close(behavior, measure)
        print(measure)
    if behavior=="go_away":
        if measure[front] > too_close:
            if  measure[left] < too_close and measure[right] >too_close:
                robot= "d"
                pub.publish(robot)
                print(robot)
                time.sleep(30*rot_angle)
            elif  measure[right] < too_close and measure[left] > too_close:
                robot= "a"
                pub.publish(robot)
                print(robot)
                time.sleep(30*rot_angle)
            elif measure[left] < too_close and measure[right] < too_close:
                robot = "x"
                pub.publish(robot)
                print(robot)
            else:
                robot = "w"
                pub.publish(robot)
                print(robot)
        if measure[front] < too_close:
            if measure[back] < too_close and measure[right] > too_close and mea$                robot =  "a"
                pub.publish(robot)
                print(robot)
                time.sleep(90*rot_angle)
            elif measure[right] < too_close and measure[left] > too_close:
                robot =  "a"
                pub.publish(robot)
                print(robot)
                time.sleep(90*rot_angle)
            elif measure[left] < too_close and measure[right] > too_close:
                robot = "d"
                pub.publish(robot)
                print(robot)
                time.sleep(90*rot_angle)
            elif measure[left]<too_close  and measure[right]<too_close and meas$                robot = "x"
                pub.publish(robot)
                print(robot)
            elif measure[left]<too_close  and measure[right]<too_close and meas$                robot = "6"
                pub.publish(robot)
                print(robot)
                time.sleep(5)
                behaviour = "stuck"
            elif measure[left]>too_close  and measure[right]>too_close and meas$                robot = "x"
                pub.publish(robot)
                print(robot)


## Shut off
GPIO.cleanup()
pub.publish('g')

if __name__ == '__main__':
    try:
        talker()
    except rospy.ROSInterruptException:
        pass


