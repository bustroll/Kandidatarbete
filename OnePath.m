function pathLength = OnePath(vector, pathLength)
    global xPosition;
    global yPosition;
    global maxVelocity;
    global currentVelocity;
    global acceleration;
    global deacceleration;
    global gridSize;
    global timeStep;
    
    xLength = size(gridSize,1);
    yLength = size(gridSize,2);
    a0 = 0;
    oldPosition = [xPosition,yPosition];
    currentVelocity = acceleration*timeStep;
    newPosition = round(oldPosition + currentVelocity*transpose(vector));
   
    while newPosition(1) > xLength || newPosition(1) <= 0 || newPosition(2) > yLength || newPosition(2) <= 0 
        InitializeTheta();
        vector = CalculateDirectionVector(vector);
        newPosition = round(oldPosition + currentVelocity*transpose(vector));
    end
    %gridSize(xPosition,yPosition) = gridSize(xPosition,yPosition)+1;
    while newPosition(1) <= xLength && newPosition(1) > 0 && newPosition(2) <= yLength && newPosition(2) > 0 && currentVelocity > 0
        gridSize(newPosition(1),newPosition(2)) = gridSize(newPosition(1),newPosition(2)) + 1;
        oldPosition = newPosition;
        if currentVelocity < maxVelocity
            wall = DetectWall(vector,newPosition);
            if wall == 1
                currentVelocity = currentVelocity + deacceleration*timeStep;
                newPosition = round(newPosition + currentVelocity*transpose(vector));
            else
                currentVelocity = currentVelocity + acceleration*timeStep;
                newPosition = round(newPosition + currentVelocity*transpose(vector));
            end
        elseif currentVelocity >= maxVelocity
            if currentVelocity > maxVelocity
                currentVelocity = maxVelocity;
            end
            wall = DetectWall(vector,newPosition);
            if wall == 1 
                currentVelocity = currentVelocity + deacceleration*timeStep;
                newPosition = round(newPosition + currentVelocity*transpose(vector));
            else
                currentVelocity = currentVelocity + a0*timeStep;
                newPosition = round(newPosition + currentVelocity*transpose(vector));
            end
        end
    end
    onePathLength = CalculatePathLength(oldPosition(1),oldPosition(2));
    pathLength = pathLength + onePathLength;
    xPosition = oldPosition(1);
    yPosition = oldPosition(2);
end