clear plots %need to clear here to prevent end+1 from causing problems

%Plot details defined here.
plots{1} = TimePlot("pwm_cmd","pwm_cmd",[4,2],{1,2,3,4,5,6,7,8},["pwm (us)","pwm (us)", "pwm (us)", "pwm (us)", "pwm (us)", "pwm (us)", "pwm (us)", "pwm (us)"],"Time (s)", ["Thruster 0","Thruster 1", "Thruster 2", "Thruster 3", "Thruster 4", "Thruster 5", "Thruster 6", "Thruster 7"],"Commanded Thruster PWM",{"","","","","","","",""});

plots{end+1} = TimePlot("FT_cmd_list","FT_cmd_list",[4,2],{1,2,3,4,5,6,7,8},["Force (N)","Force (N)", "Force (N)", "Force (N)", "Force (N)", "Force (N)", "Force (N)", "Force (N)"],"Time (s)", ["Thruster 0","Thruster 1", "Thruster 2", "Thruster 3", "Thruster 4", "Thruster 5", "Thruster 6", "Thruster 7"],"Commanded Thruster Force",{"","","","","","","",""});

plots{end+1} = TimePlot("Ri, dRi, ddRi",["Ri","dRi","ddRi"],[3,1],{[1,2,3],[4,5,6],[7,8,9]},["Position (m)", "Velocity (m/s)", "Acceleration (m/s2)"],"Time (s)",["Inertial Position","Inertial Velocity","Inertial Acceleration"],"",{["Rix", "Riy", "Riz"],["dRix", "dRiy", "dRiz"],["ddRix","ddRiy","ddRiz"]});

plots{end+1} = TimePlot("Rb, dRb, ddRb",["Rb","dRb","ddRb"],[3,1],{[1,2,3],[4,5,6],[7,8,9]},["Position (m)", "Velocity (m/s)", "Acceleration (m/s2)"],"Time (s)",["Body Position","Body Velocity","Body Acceleration"],"",{["Rbx", "Rby", "Rbz"],["dRbx", "dRby", "dRbz"],["ddRbx","ddRby","ddRbz"]});

plots{end+1} = TimePlot("Fb, Mb",["Fb","Mb"],[2,1],{[1,2,3],[4,5,6]},["Force (N)", "Moment (Nm)"], "Time (s)", ["Body Force","Body Moment"],"",{["Fbx","Fby","Fbz"],["Mbx","Mby","Mbz"]});

plots{end+1} = TimePlot("Fi, Mi",["Fi","Mi"],[2,1],{[1,2,3],[4,5,6]},["Force (N)", "Moment (Nm)"], "Time (s)", ["Inertial Force","Inertial Moment"],"",{["Fix","Fiy","Fiz"],["Mix","Miy","Miz"]});

plots{end+1} = TimePlot("FTb, MTb",["FTb","MTb"],[2,1],{[1,2,3],[4,5,6]},["Force (N)", "Moment (Nm)"], "Time (s)", ["Body Thruster Force","Body Thruster Moment"],"",{["FTbx","FTby","FTbz"],["MTbx","MTby","MTbz"]});

plots{end+1} = TimePlot("FT_list","FT_list",[4,2],{1,2,3,4,5,6,7,8},["F (N)","F (N)", "F (N)", "F (N)", "F (N)", "F (N)", "F (N)", "F (N)"],"T (s)", ["Thruster 0","Thruster 1", "Thruster 2", "Thruster 3", "Thruster 4", "Thruster 5", "Thruster 6", "Thruster 7"],"Thruster Forces",{"","","","","","","",""});

plots{end+1} = TimePlot("Eul","Eul",[1,1],{[1,2,3]},"Angle (rad)","Time (s)","","Euler Angles",{["roll","pitch","yaw"]});

plots{end+1} = TimePlot("q","q",[1,2],{[1,2,3],[4]},["Epsilon","Eta"],"Time (s)",["Vector","Scalar"],"Quaternion",{["q1","q2","q3"],["q4"]});

plots{end+1} = TimePlot("FB_force_moment_cmd",["Fb_FB_cmd", "Mb_FB_cmd"],[2,1],{[1,2,3],[4,5,6]},["Force (N)","Moment (Nm)"], "Time (s)", ["Force Command", "Moment Command"],"FB Controller Commanded Force and Moment",{["Fbx", "Fby", "Fbz"], ["Mbx", "Mby", "Mbz"]});

plots{end+1} = TimePlot("FB_FT_cmd_lists",["FT_cmd_list_FB","FT_cmd_list_pos","FT_cmd_list_att"],[4,2],{[1,9,17],[2,10,18],[3,11,19],[4,12,20],[5,13,21],[6,14,22],[7,15,23],[8,16,24]},["Force (N)","Force (N)", "Force (N)", "Force (N)", "Force (N)", "Force (N)", "Force (N)", "Force (N)"],"Time (s)", ["Thruster 0","Thruster 1", "Thruster 2", "Thruster 3", "Thruster 4", "Thruster 5", "Thruster 6", "Thruster 7"],"Commanded Thruster Force by FB Controller",{["Total","Pos","Att"],"","","","","","",""});

plots{end+1} = TimePlot("X",["Rb", "dRb", "Eul", "wb"],[2,2],{[1,2,3],[7,8,9],[4,5,6],[10,11,12]},["Position (m)","Angle (rad)","Velocity (m/s)","Angular Velocity (rad/s)"],"Time (s)",["Body Frame Position", "Euler Angles","Body Frame Velocity","Angular Velocity"],"Simulated States",{["Rix", "Riy", "Riz"],["Roll", "Pitch", "Yaw"],["dRbx", "dRby", "dRbz"],["wbx","wby","wbz"]});

plots{end+1} = TimePlot("cmd_status",["mission_idx", "cmd_status", "hold_timer", "cmd_hold_time", "action_id"],[4 1],{[1],[2],[3,4],[5]},["Index", "Status", "Time (s)","ID"],"Time (s)",["Index in Mission File","Status (1 = Success, 2 = Fail, 3 = Running)","Hold Timer","Action ID (1 = Turn, 2 = Drive, 3 = Settle)"],"Active Command Info",{"","",["Timer","Target Hold Time"],""});

plots{end+1} = TimePlot("Eul_u",["Eul","Eul_u"],[3,1],{[1,4],[2,5],[3,6]},["Angle (rad)", "Angle (rad)", "Angle (rad)"],"Time (s)",["Roll", "Pitch", "Yaw"],"Euler Angle Value and Target",{["Roll", "Roll_u"], ["Pitch", "Pitch_u"], ["Yaw", "Yaw_u"]});

plots{end+1} = TimePlot("idle_wp","idle_wp",[2,1],{[1,2,3],[4,5,6]},["Position (m)", "Angle (rad)"],"Time (s)",["Position Target", "Angle Target"],"Intermediate Waypoint",{["xi", "yi", "zi"],["roll", "pitch", "yaw"]});

plots{end+1} = StatePlot("X_est", ["X_est"],["Rb", "dRb", "Eul", "wb"], [2,2], {[1,2,3],[7,8,9],[4,5,6],[10,11,12]},["Position (m)","Angle (rad)","Velocity (m/s)","Angular Velocity (rad/s)"],"Time (s)",["Body Frame Position", "Euler Angles","Body Frame Velocity","Angular Velocity"],"Estimated States",{["Rix", "Riy", "Riz"],["Roll", "Pitch", "Yaw"],["dRbx", "dRby", "dRbz"],["wbx","wby","wbz"]});

plots{end+1} = TimePlot("CE_X_u", ["CE_X_u","CE_Eul_u"],[2,2],{[1,2,3],[14,15,16],[8,9,10],[11,12,13]},["Position (m)", "Angle (rad)", "Velocity (m/s)", "Angular Velocity (rad/s)"],"Time (s)",["Inertial Position", "Euler Angles", "Inertial Velocity", "Angular Velocity"],"State Target from Command Executer",{["Rix_u", "Riy_u", "Riz_u"],["Roll_u", "Pitch_u", "Yaw_u"],["dRix_u", "dRiy_u", "dRiz_u"],["wbx_u", "wby_u", "wbz_u"]});