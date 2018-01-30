function robot = InitializeRobot()
    global xPosition;
    global yPosition;
    global theta;
    global maxVelocity;
    global currentVelocity;
    global maxAcceleration;
    global maxDeacceleration;

    InitializePostion();
    InitializeTheta();
    robot = [xPosition yPosition theta maxVelocity currentVelocity maxAcceleration maxDeacceleration];
end