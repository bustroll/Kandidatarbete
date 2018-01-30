function InitializeTheta()
    global theta;
    minTheta = 45;
    maxTheta = 90;
    newTheta = minTheta + rand*(maxTheta-minTheta);
    while newTheta == theta
        newTheta = minTheta + rand*(maxTheta-minTheta);
    end
    theta = newTheta;
end