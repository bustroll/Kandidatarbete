function ResetGlobalVar()
    global xPosition;
    xPosition = -1;
    global yPosition;
    yPosition = -1;
    global theta;
    theta = 0;
    global maxVelocity;
    maxVelocity = 1.39;
    global currentVelocity;
    currentVelocity = 0;
    global acceleration;
    acceleration = 0.4;
    global deacceleration;
    deacceleration = -0.4;
    global gridSize;
    gridSize = zeros(234,137); %i decimeter
    global wall;
    wall = 0;
    global timeStep;
    timeStep = 1;
    global time;
    time = 0;
end