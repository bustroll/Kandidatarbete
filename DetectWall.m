function wall = DetectWall(vector)
    global currentVelocity;
    global acceleration;
    global timeStep;
    
    wall = 0;
    
    nCurrentVelocity = currentVelocity + acceleration*timeStep;
    nnCurrentVelocity = nCurrentVelocity + acceleration*timeStep;
    nnnCurrentVelocity = nnCurrentVelocity + acceleration*timeStep;
    nnnnCurrentVelocity = nnnCurrentVelocity + acceleration*timeStep;
    nnnnnCurrentVelocity = nnnnCurrentVelocity + acceleration*timeStep;
    n5Acc = nnnnnCurrentVelocity*vector;
    if n5Acc(1) > xLength || n5Acc(1) <= 0 || n5Acc(2) > yLength || n5Acc(2) <= 0 
        wall = 1;
    end