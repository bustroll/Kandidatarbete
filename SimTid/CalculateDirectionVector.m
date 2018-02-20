function [vector] = CalculateDirectionVector(vector)
    global theta;

    rotationMatrix = [cos(theta), -sin(theta); sin(theta),cos(theta)];
    vector = rotationMatrix*vector;
end