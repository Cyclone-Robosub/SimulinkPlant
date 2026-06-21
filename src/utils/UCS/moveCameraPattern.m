function patternLocation = moveCameraPattern(simTime, oldPatternLocation)
    %Pattern Boxes are each 5cm across. 10 boxes by 7 boxes. So 40cm x 30cm...
    %sized grid.
    
    patternLocation = oldPatternLocation;
    timeIncrement = 120;
    largeTimeIncrement = 5*timeIncrement;
    time = simTime - timeIncrement*5;
    if time <= timeIncrement * 45 && time > 0
        if mod(time, timeIncrement) == 0
            if mod(time, largeTimeIncrement) == 0
                patternLocation(6) = 0;
                patternLocation(5) = 90;
                if patternLocation(2) == 60
                    patternLocation(2) = -60;
                    patternLocation(3) = patternLocation(3) - 20;
                else
                    patternLocation(2) = patternLocation(2) + 60;
                end
            elseif mod(time, largeTimeIncrement) == 1 * timeIncrement
                patternLocation(6) = 25;
                patternLocation(5) = 90;
            elseif mod(time, largeTimeIncrement) == 2 * timeIncrement
                patternLocation(6) = -25;
                patternLocation(5) = 90;
            elseif mod(time, largeTimeIncrement) == 3 * timeIncrement
                patternLocation(6) = 0;
                patternLocation(5) = 65;
            elseif mod(time, largeTimeIncrement) == 4 * timeIncrement
                patternLocation(6) = 0;
                patternLocation(5) = 115;
            end
        end
    end
end