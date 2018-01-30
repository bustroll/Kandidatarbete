function PlotSim()
    global xPosition;
    global yPosition;
    global gridSize;
    
    xLength = size(gridSize,1);
    yLength = size(gridSize,2);
    
    for x = 1:xLength
        for y = 1:yLength
            if gridSize(x,y) > 0                
                scatter(x,y,'filled','b')
                hold on
            end
        end
    end
    scatter(xPosition,yPosition,'filled','r')
    hold on
    axis([0 xLength 0 yLength])
end