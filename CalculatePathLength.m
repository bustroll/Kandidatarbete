function hypotenuse = CalculatePathLength(xOldPosition, yOldPosition)
    global xPosition;
    global yPosition;
    global time;
    
    xLength = xPosition - xOldPosition;
    yLength = yPosition - yOldPosition;
    hypotenuse = (hypot(xLength, yLength))/10;
    time = time + (hypotenuse/1.4);
end