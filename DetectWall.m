function DetectWall(vector,newPosition)
    global currentVelocity;
    global acceleration;
    global gridSize;
    global timeStep;
    global wall;
    
    xLength = size(gridSize,1);
    yLength = size(gridSize,2);
   
    nCurrentVelocity = currentVelocity + acceleration*timeStep;
    newPos = round(newPosition + nCurrentVelocity*transpose(vector));
    
    nnCurrentVelocity = nCurrentVelocity + acceleration*timeStep;
    newPos = round(newPos + nnCurrentVelocity*transpose(vector));
    
    nnnCurrentVelocity = nnCurrentVelocity + acceleration*timeStep;
    newPos = round(newPos + nnnCurrentVelocity*transpose(vector));
    
    if newPos(1) > xLength || newPos(1) <= 0 || newPos(2) > yLength || newPos(2) <= 0 
        wall = 1;
    end