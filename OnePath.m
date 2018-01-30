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
    n = 1;
    xOld = xPosition;
    yOld = yPosition;
    currentVelocity = acceleration*timeStep;
    acc = [xPosition,yPosition] + currentVelocity*vector;
   
    %while go == 1 
        while acc(1) > xLength || acc(1) <= 0 || acc(2) > yLength || acc(2) <= 0 
            InitializeTheta();
            vector = CalculateDirectionVector(vector);
            currentVelocity = acceleration*timeStep;
            acc = [xPosition,yPosition] + currentVelocity*vector;
        end
        while acc(1) <= xLength && acc(1) > 0 && acc(2) <= yLength && acc(2) > 0
            if currentVelocity < maxVelocity
                wall = DetectWall(vector);
                if wall == 1 && currentVelocity > 0
                    currentVelocity = currentVelocity + deacceleration*timeStep;
                    acc = currentVelocity*vector;
                else
                    currentVelocity = currentVelocity + acceleration*timeStep;
                    acc = currentVelocity*vector;
                end
            elseif currentVelocity == maxVelocity
                wall = DetectWall(vector);
                if wall == 1 
                    currentVelocity = currentVelocity + deacceleration*timeStep;
                    acc = currentVelocity*vector;
                else
                    
            end
            gridSize(x,y) = gridSize(x,y) + 1;
            xOld = x;
            yOld = y;
            n = n + 1;
            x = round(xPosition + vector(1)*n);
            y = round(yPosition + vector(2)*n);
            
            
        end
    
        onePathLength = CalculatePathLength(xOld, yOld);
        pathLength = pathLength + onePathLength;
        xPosition = xOld;
        yPosition = yOld;
    %end
end