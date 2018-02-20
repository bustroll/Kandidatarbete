function stopTime = StopDist()
    global currentVelocity;
    global deacceleration;
    reactionTime = 0;
    
    stopTime = currentVelocity*reactionTime + ((currentVelocity^2)/(2*deacceleration));
end