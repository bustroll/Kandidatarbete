function pathLength = OnePath2(vector, pathLength)
    global xPosition;
    global yPosition;
    global gridSize;
    
    xLength = size(gridSize,1);
    yLength = size(gridSize,2);
    n = 1;
    xOldPosition = xPosition;
    yOldPosition = yPosition;
    xNewPosition = round(xPosition + n*vector(1));
    yNewPosition = round(yPosition + n*vector(2));
    while xNewPosition > xLength || xNewPosition <= 0 || yNewPosition > yLength || yNewPosition <= 0 
        InitializeTheta();
        vector = CalculateDirectionVector(vector);
        xNewPosition = round(xOldPosition + n*vector(1));
        yNewPosition = round(yOldPosition + n*vector(2));
    end
    while xNewPosition <= xLength && xNewPosition > 0 && yNewPosition <= yLength && yNewPosition > 0
        gridSize(xNewPosition,yNewPosition) = gridSize(xNewPosition,yNewPosition) + 1;
        xOldPosition = xNewPosition;
        yOldPosition = yNewPosition;
        n = n+1;
        xNewPosition = round(xPosition + n*vector(1));
        yNewPosition = round(yPosition + n*vector(2));
    end
    onePathLength = CalculatePathLength(xOldPosition,yOldPosition);
    pathLength = pathLength + onePathLength;
    xPosition = xOldPosition;
    yPosition = yOldPosition;
end