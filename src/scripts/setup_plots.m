clear plots %need to clear here to prevent end+1 from causing problems

%Plot details defined here.
plots(1) = ClassPlot("cmd","cmd",[4,1],{[5,6,7],[8,9,10],[1,2,4],[3,11]},["Position (m)", "Angle (rad)", "Value", "Time (s)"],"Time (s)",["Position Target", "Attitude Target", "Maneuver Metadata", "Maneuver Timing"],"Command vs Time",{["x","y","z"],["roll","pitch","yaw"],["Mode","Maneuver ID", "Maneuver Intensity"],["Maneuver Duration", "Maneuver Time"]});

plots(end+1) = ClassPlot("pwm_cmd","pwm_cmd",[4,2],{1,2,3,4,5,6,7,8},["pwm (us)","pwm (us)", "pwm (us)", "pwm (us)", "pwm (us)", "pwm (us)", "pwm (us)", "pwm (us)"],"Time (s)", ["Thruster 0","Thruster 1", "Thruster 2", "Thruster 3", "Thruster 4", "Thruster 5", "Thruster 6", "Thruster 7"],"Commanded Thruster PWM",{"","","","","","","",""});

plots(end+1) = ClassPlot("FT_cmd_list","FT_cmd_list",[4,2],{1,2,3,4,5,6,7,8},["Force (N)","Force (N)", "Force (N)", "Force (N)", "Force (N)", "Force (N)", "Force (N)", "Force (N)"],"Time (s)", ["Thruster 0","Thruster 1", "Thruster 2", "Thruster 3", "Thruster 4", "Thruster 5", "Thruster 6", "Thruster 7"],"Commanded Thruster Force",{"","","","","","","",""});

plots(end+1) = ClassPlot("Ri, dRi, ddRi",["Ri","dRi","ddRi"],[3,1],{[1,2,3],[4,5,6],[7,8,9]},["Position (m)", "Velocity (m/s)", "Acceleration (m/s2)"],"Time (s)",["Inertial Position","Inertial Velocity","Inertial Acceleration"],"",{["Rix", "Riy", "Riz"],["dRix", "dRiy", "dRiz"],["ddRix","ddRiy","ddRiz"]});

plots(end+1) = ClassPlot("Rb, dRb, ddRb",["Rb","dRb","ddRb"],[3,1],{[1,2,3],[4,5,6],[7,8,9]},["Position (m)", "Velocity (m/s)", "Acceleration (m/s2)"],"Time (s)",["Body Position","Body Velocity","Body Acceleration"],"",{["Rbx", "Rby", "Rbz"],["dRbx", "dRby", "dRbz"],["ddRbx","ddRby","ddRbz"]});

plots(end+1) = ClassPlot("Fb, Mb",["Fb","Mb"],[2,1],{[1,2,3],[4,5,6]},["Force (N)", "Moment (Nm)"], "Time (s)", ["Body Force","Body Moment"],"",{["Fbx","Fby","Fbz"],["Mbx","Mby","Mbz"]});

plots(end+1) = ClassPlot("Fi, Mi",["Fi","Mi"],[2,1],{[1,2,3],[4,5,6]},["Force (N)", "Moment (Nm)"], "Time (s)", ["Inertial Force","Inertial Moment"],"",{["Fix","Fiy","Fiz"],["Mix","Miy","Miz"]});

plots(end+1) = ClassPlot("FTb, MTb",["FTb","MTb"],[2,1],{[1,2,3],[4,5,6]},["Force (N)", "Moment (Nm)"], "Time (s)", ["Body Thruster Force","Body Thruster Moment"],"",{["FTbx","FTby","FTbz"],["MTbx","MTby","MTbz"]});

plots(end+1) = ClassPlot("FT_list","FT_list",[4,2],{1,2,3,4,5,6,7,8},["F (N)","F (N)", "F (N)", "F (N)", "F (N)", "F (N)", "F (N)", "F (N)"],"T (s)", ["Thruster 0","Thruster 1", "Thruster 2", "Thruster 3", "Thruster 4", "Thruster 5", "Thruster 6", "Thruster 7"],"Thruster Forces",{"","","","","","","",""});

plots(end+1) = ClassPlot("Eul","Eul",[1,1],{[1,2,3]},"Angle (rad)","Time (s)","","Euler Angles",{["roll","pitch","yaw"]});
