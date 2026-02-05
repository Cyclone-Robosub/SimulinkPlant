function plotAllOutputs(results,varargin)

%unpack optional argument(s)
if nargin > 1
    target_plot_names = varargin{1};
    plot_all_flag = false;
else
    plot_all_flag = true;
end

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
if(~isempty(target_plot_names))
    names = cell(size(target_plot_names));
    for k = 1:length(plots)
        names{k} = plots(k).name;
    end
end

if(plot_all_flag)
    for k = 1:length(plots)
        plot(plots(k),results);
    end
else
    for k = 1:length(names)
        if(ismember(names{k},[target_plot_names{:}]))
            plot(plots(k),results);
        end
    end
end
    
end
