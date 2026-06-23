function [enable, result_msg] = statusKwdToBool(cmd_status)

%{
This function populates the Results message for sys-arch.

Inputs:
cmd_status [4x1 int8]

Outputs:
enable [1x1 bool]
results_msg [SL_Bus_custom_interfaces_Result]
    .success [1x1 bool]
    .found_object [16x1 uint8]
    .reached_waypoint_without_detection [1x1 bool]

%}

switch char(cmd_status')
    case 'SUCC'
        enable = true;
        result_msg.success = true;
        result_msg.found_object = uint8(char('placeholder_____'))';
        result_msg.reached_waypoint_without_detection = false;
    case 'FAIL'
        enable = true;
        result_msg.success = false;
        result_msg.found_object = uint8(char('placeholder_____'))';
        result_msg.reached_waypoint_without_detection = false;
    case 'RUNN'
        enable = false;
        result_msg.success = false;
        result_msg.found_object = uint8(char('placeholder_____'))';
        result_msg.reached_waypoint_without_detection = false;
    otherwise
        enable = false;
        result_msg.success = false;
        result_msg.found_object = uint8(char('placeholder_____'))';
        result_msg.reached_waypoint_without_detection = false;
end

end