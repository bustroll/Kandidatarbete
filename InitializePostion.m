function InitializePostion()
    global xPosition;
    global yPosition;
    global gridSize;
    
    xPosition = randi(size(gridSize,1));
    yPosition = randi(size(gridSize,2));
end