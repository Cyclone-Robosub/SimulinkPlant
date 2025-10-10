function PWM = commandToPWM(command)
%{
This function uses the command forward, reverse, up, down, etc... to 
send commands corresponding to that maneuver to the right thrusters at 
the specified intensity.

%}
%unpack the command
type = command{1};
intensity = command{2};

switch(type)
    case "+x"
        thruster_mask = intensity*[0 0 0 0 -1 -1 -1 -1]';
        %drive forward
    case "-x"
        thruster_mask = intensity*[0 0 0 0 1 1 1 1]';
        %drive backward
    case "yaw_left"
        thruster_mask = intensity*[0 0 0 0 1 -1 1 -1]';
        %yaw ccw
    case "yaw_right"
        thruster_mask = intensity*[0 0 0 0 -1 1 -1 1]';
        %yaw cw
    case "-z"
        thruster_mask = intensity*[1 1 1 1 0 0 0 0]';
        %go up
    case "+z"
        thruster_mask = intensity*[-1 -1 -1 -1 0 0 0 0]';
        %go down
    case ""
        thruster_mask = zeros(8,1);
    otherwise
        thruster_mask = zeros(8,1);
end

PWM = thrusterMaskToPWM(thruster_mask); %see utils, TBA


end