function wall = DetectWall(vector,newPosition)
    global currentVelocity;
    global acceleration;
    global gridSize;
    global timeStep;
    
    xLength = size(gridSize,1);
    yLength = size(gridSize,2);
    wall = 0;
    
    nCurrentVelocity = currentVelocity + acceleration*timeStep;
    nnCurrentVelocity = nCurrentVelocity + acceleration*timeStep;
    nnnCurrentVelocity = nnCurrentVelocity + acceleration*timeStep;
    nnnnCurrentVelocity = nnnCurrentVelocity + acceleration*timeStep;
    nnnnnCurrentVelocity = nnnnCurrentVelocity + acceleration*timeStep;
    newPos = round(newPosition + nnnnnCurrentVelocity*transpose(vector));
    if newPos(1) > xLength || newPos(1) <= 0 || newPos(2) > yLength || newPos(2) <= 0 
        wall = 1;
    end