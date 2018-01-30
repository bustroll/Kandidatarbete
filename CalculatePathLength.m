function hypotenuse = CalculatePathLength(xOldPosition, yOldPosition)
    global xPosition;
    global yPosition;
    
    xLength = xPosition - xOldPosition;
    yLength = yPosition - yOldPosition;
    hypotenuse = hypot(xLength, yLength);
end