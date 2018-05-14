## Measurement
# uses the measurement from sensors and analyze
# it to get the closest object at all sides


#def mea_sort(TRIG_front_1, ECHO_front_1, TRIG_front_2, ECHO_front_2, TRIG_left$#             ECHO_left_1, TRIG_right_1, ECHO_right_1, TRIG_back_1, ECHO_back_1$def mea_sort():
    # Load measurement function for the sensors and the sensor_pins
    from measure_calculate import dist
    import time
    time.sleep(0.4)

    TRIG_front_1= 20
    ECHO_front_1= 21

    TRIG_front_2= 4
    ECHO_front_2= 17

    TRIG_left_1= 27
    ECHO_left_1= 22

    TRIG_right_1= 10
    ECHO_right_1= 9

    TRIG_back_1 = 19
    ECHO_back_1 = 26

    # defining amount of measurments for presicion
    attempt = 0
    total_attempt = 1 # 5 gives 5 measuremetns
    s_front_1=[0]*total_attempt
    s_front_2=[0]*total_attempt
    s_left_1=[0]*total_attempt
    s_right_1=[0]*total_attempt
    s_back_1=[0]*total_attempt


    # make measurments
    while attempt < total_attempt:
        s_front_1[attempt] = dist(TRIG_front_1, ECHO_front_1);
        time.sleep(0.001)
        s_right_1[attempt] = dist(TRIG_right_1, ECHO_right_1);
        time.sleep(0.001)
        s_front_2[attempt] = dist(TRIG_front_2, ECHO_front_2);
        time.sleep(0.001)
        s_left_1[attempt] = dist(TRIG_left_1, ECHO_left_1);
        time.sleep(0.001)
        s_back_1[attempt] = dist(TRIG_back_1, ECHO_back_1);
        time.sleep(0.001)
        attempt=attempt + 1;

    # Sort the values or use mean-function
    s_front_1 = sorted(s_front_1)
    s_front_2 = sorted(s_front_2)
    s_right_1 = sorted(s_right_1)
    s_left_1 = sorted(s_left_1)
    s_back_1 = sorted(s_back_1)


    # count the mean value

    mean_value=0;
    if s_front_1[mean_value]>s_front_2[mean_value]:
        front=s_front_2[mean_value]
    else:
        front=s_front_1[mean_value]

    left=s_left_1[mean_value]
    right=s_right_1[mean_value]
    back=s_back_1[mean_value]
    lista=[0]*6
    lista[0]=front
    lista[1]=left
    lista[2]=right
    lista[3]=back
    lista[4]=s_front_1[mean_value]
    lista[5]=s_front_2[mean_value]
    print(lista)
    return front, left, right, back, s_front_1[mean_value], s_front_2[mean_valu$
