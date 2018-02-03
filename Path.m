function data = Path(vector)
    global theta;
    global currentVelocity;
    global wall;
    global time;
    
    turn = 0;
    procent = 0.0;
    pathLength = 0;
    
    while procent < 0.8
        pathLength = OnePath(vector, pathLength);
        InitializeTheta();
        vector = CalculateDirectionVector(vector);
        procent = CleanArea();
        turn = turn + 1;
        wall = 0;
        %PlotSim();
        disp(['Turn: ', num2str(turn)])
        disp(['Time: ', num2str(time)])
        disp(['Path Length: ', num2str(pathLength)])
        disp(['Clean area: ', num2str(procent)])
    end
    
        data = [turn,time,pathLength,procent];
end