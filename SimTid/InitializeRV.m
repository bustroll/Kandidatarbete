function rVector = InitializeRV()
    global theta;
    rotationMatrix = [cos(theta), -sin(theta); sin(theta),cos(theta)];
    rVector = rotationMatrix*[1;0];
end