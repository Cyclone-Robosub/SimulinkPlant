function new_array = numericMissionFile(table)
%{
This function converts the mission file into a numeric array where the
numbers in the Maneuver column correspond the the key words in the mission
file.

In Simulink it is much easier to pass a numeric array into a model as an
input than a structure with many different data types. This also allows the
functions that handle this mission file to be codegen compatible.
%}

%convert mission file to a text array
array = table2array(table);
new_array = zeros(size(array));

%loop through array and replace maneuver key words with corresponding
%maneuvers
for k = 1:length(array)
    switch array(k,1)
        case "Start"
            maneuver_ID = 1;
        case "Forward"
            maneuver_ID = 2;
        case "RightTurn"
            maneuver_ID = 3;
        case "LeftTurn"
            maneuver_ID = 4;
        case "Reverse"
            maneuver_ID = 5;
        case "Up"
            maneuver_ID = 6;
        case "Down"
            maneuver_ID = 7;
        case "Stop"
            maneuver_ID = 8;
        case "BarrelRole"
            maneuver_ID = 9;
        case "FlatSpin"
            maneuver_ID = 10;
        case "Tumble"
            maneuver_ID = 11;
        otherwise
            maneuver_ID = 0;
    end
    %pack up outputs
    new_array(k,:) = [maneuver_ID,double(array(k,2)),double(array(k,3))];
end


end