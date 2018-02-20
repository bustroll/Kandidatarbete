function InitializeTheta()
    global theta;
    minTheta = 45; %pi/4;
    maxTheta = 90; %pi/2;
    newTheta = minTheta + rand*(maxTheta-minTheta);
    while newTheta == theta
        newTheta = minTheta + rand*(maxTheta-minTheta);
    end
    theta = newTheta;
end