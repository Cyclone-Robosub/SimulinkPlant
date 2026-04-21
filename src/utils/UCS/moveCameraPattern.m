function patternLocation = moveCameraPattern(cameraImageLeft, cameraImageRight, simTime, oldPatternLocation)
    %Pattern Boxes are each 2cm across. 20 boxes by 15 boxes. So 40cm x 30cm...
    %sized grid.
    
    coder.extrinsic('imwrite');
    patternLocation = oldPatternLocation;
    timeIncrement = 5;
    largeTimeIncrement = 5*timeIncrement;
    time = simTime - 50;
    if time <= timeIncrement * 45 && time > 0
        if mod(time, timeIncrement) == 0
            imageNameLeft = fullfile(root_path, "SavedImages/CalibrationImages/LeftCamera/CalibrationImage" + floor(time / timeIncrement) + ".png");
            imageNameRight = fullfile(root_path, "SavedImages/CalibrationImages/RightCamera/CalibrationImage" + floor(time / timeIncrement) + ".png");
            imwrite(cameraImageLeft, imageNameLeft);
            imwrite(cameraImageRight, imageNameRight);
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