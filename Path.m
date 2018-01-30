function Path(vector)
    global theta;
    
    turn = 0;
    procent = 0.0;
    pathLength = 0;
    
    while procent < 0.8
        pathLength = OnePath(vector, pathLength);
        InitializeTheta();
        vector = CalculateDirectionVector(vector);
        procent = CleanArea();
        turn = turn + 1;
        PlotSim();
        disp(['Turn: ', num2str(turn)])
        disp(['Theta: ', num2str(theta)])
        disp(['Path Length: ', num2str(pathLength)])
        disp(['Clean area: ', num2str(procent)])
    end
end