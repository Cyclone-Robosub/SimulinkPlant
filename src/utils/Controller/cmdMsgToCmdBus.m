function cmd = cmdMsgToCmdBus(cmd_msg)
%{
This function translates a custom_interfaces/Goal ROS2 message to a cmd_bus
for use in the Low Level Controller Simulink model.

As a helpful tip, you can inspect the fields of a bus created from a ROS2 
message by using:

dd = Simulink.data.dictionary.open('ros2lib.sldd');
dds = dd.getSection('Design Data');
entry = dds.getEntry('<my bus name here>');
busObj = entry.getValue();

Then get a list of field names using
{busObj.Elements.Name}

And a list of field types using
{busObj.Elements.DataType}

And the sizes with
{busObj.Elements.Dimensions}

Input:
cmd_msg [SL_Bus_custom_interfaces_Goal structure]
    .command_id [16x1 uint8]
    .waypoint [1x1 SL_Bus_custom_interfaces_Pose6D]
        .x [1x1 double]
        .y [1x1 double]
        .z [1x1 double]
        .roll [1x1 double]
        .pitch [1x1 double]
        .yaw [1x1 double]
    .waypoint_mask [1x1 SL_Bus_custom_interfaces_WaypointMask]
        .x [1x1 bool]
        .y [1x1 bool]
        .z [1x1 bool]
        .roll [1x1 bool]
        .pitch [1x1 bool]
        .yaw [1x1 bool]
    .tolerance [1x1 SL_Bus_custom_interfaces_Pose6D]
        .x [1x1 double]
        .y [1x1 double]
        .z [1x1 double]
        .roll [1x1 double]
        .pitch [1x1 double]
        .yaw [1x1 double]
    .hold_time [1x1 double]
    .object [16x1 uint8]
    .confidence [1x1 double]
    .trick [16x1 uint8]
    .duration [1x1 duration]

Outputs:
cmd [cmd_bus structure]
    .cmd_id [1x16 int8]
    .wp [6x1 double]
    .wp_mask [6x1 double]
    .wp_tol [6x1 double]
    .hold_time [1x1 double]
    .obj_id [1x16 int8]
    .conf [1x1 double]
    .trick_id [1x16 int8]
    .exec_timeout [1x1 double]
%}

% command_id: uint8 -> int8 (double check dimension)
cmd.cmd_id = int8(cmd_msg.command_id);

% waypoint: Pose6D -> 6x1 double
cmd.wp = [cmd_msg.waypoint.x;
          cmd_msg.waypoint.y;
          cmd_msg.waypoint.z;
          cmd_msg.waypoint.roll;
          cmd_msg.waypoint.pitch;
          cmd_msg.waypoint.yaw];

% waypoint_mask: WaypointMask -> 6x1 double
cmd.wp_mask = double([cmd_msg.waypoint_mask.x;
                      cmd_msg.waypoint_mask.y;
                      cmd_msg.waypoint_mask.z;
                      cmd_msg.waypoint_mask.roll;
                      cmd_msg.waypoint_mask.pitch;
                      cmd_msg.waypoint_mask.yaw]);

% tolerance: Pose6D -> 6x1 double
cmd.wp_tol = [cmd_msg.tolerance.x;
              cmd_msg.tolerance.y;
              cmd_msg.tolerance.z;
              cmd_msg.tolerance.roll;
              cmd_msg.tolerance.pitch;
              cmd_msg.tolerance.yaw];

% hold_time: double passthrough
cmd.hold_time = cmd_msg.hold_time;

% object: uint8 -> int8
cmd.obj_id = int8(cmd_msg.object);

% confidence: double passthrough
cmd.conf = cmd_msg.confidence;

% trick: uint8 -> int8
cmd.trick_id = int8(cmd_msg.trick);

% duration: double passthrough
cmd.exec_timeout = cmd_msg.duration;

end


