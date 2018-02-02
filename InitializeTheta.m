function InitializeTheta()
    global theta;
    minTheta = pi/4;
    maxTheta = pi/2;
    newTheta = minTheta + rand*(maxTheta-minTheta);
    while newTheta == theta
        newTheta = minTheta + rand*(maxTheta-minTheta);
    end
    theta = newTheta;
end