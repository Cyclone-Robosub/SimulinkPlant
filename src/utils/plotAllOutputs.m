function plotAllOutputs(results,varargin)

%unpack optional argument(s)
if nargin > 1
    target_plot_names = varargin{1};
    plot_all_flag = false;
else
    plot_all_flag = true;
end

% Add new plots here
%force and moment data
plots(1) = ClassPlot("Fb Mb",["Fb","Mb"],[2,1],{[1,2,3];[4,5,6]},["Force (N)","Moment (N*m)"],"Time (s)",["Total Force","Total Moment"],"Total Forces on the Robot in Body Coordinates",{["Fx","Fy","Fz"],["Mx","My","Mz"]});
plots(2) = ClassPlot("Fi Mi",["Fi","Mi"],[2,1],{[1,2,3];[4,5,6]},["Force (N)","Moment (N*m)"],"Time (s)",["Total Force","Total Moment"],"Total Forces on the Robot in Inertial Coordinates",{["Fx","Fy","Fz"],["Mx","My","Mz"]});
plots(3) = ClassPlot("Fb_buoy Mb_buoy",["Fb_buoy","Mb_buoy"],[2,1],{[1,2,3];[4,5,6]},["Force (N)","Moment (N*m)"],"Time (s)",["Buoyant Force","Buoyant Moment"],"Buoyant Forces on the Robot in Body Coordinates",{["Fx","Fy","Fz"],["Mx","My","Mz"]});
plots(4) = ClassPlot("Fi_buoy Mi_buoy",["Fi_buoy","Mi_buoy"],[2,1],{[1,2,3];[4,5,6]},["Force (N)","Moment (N*m)"],"Time (s)",["Buoyant Force","Buoyant Moment"],"Buoyant Forces on the Robot in Inertial Coordinates",{["Fx","Fy","Fz"],["Mx","My","Mz"]});
plots(5) = ClassPlot("Fb_drag Mb_drag",["Fb_drag","Mb_drag"],[2,1],{[1,2,3];[4,5,6]},["Force (N)","Moment (N*m)"],"Time (s)",["Drag Force","Drag Moment"],"Drag Forces on the Robot in Body Coordinates",{["Fx","Fy","Fz"],["Mx","My","Mz"]});
plots(6) = ClassPlot("Fi_drag Mi_drag",["Fi_drag","Mi_drag"],[2,1],{[1,2,3];[4,5,6]},["Force (N)","Moment (N*m)"],"Time (s)",["Drag Force","Drag Moment"],"Drag Forces on the Robot in Inertial Coordinates",{["Fx","Fy","Fz"],["Mx","My","Mz"]});
plots(7) = ClassPlot("Fb_g Mb_g",["Fb_g","Mb_g"],[2,1],{[1,2,3];[4,5,6]},["Force (N)","Moment (N*m)"],"Time (s)",["Gravitational Force","Gravitational Moment"],"Gravitational Forces on the Robot in Body Coordinates",{["Fx","Fy","Fz"],["Mx","My","Mz"]});
plots(8) = ClassPlot("Fi_g Mi_g",["Fi_g","Mi_g"],[2,1],{[1,2,3];[4,5,6]},["Force (N)","Moment (N*m)"],"Time (s)",["Gravitational Force","Gravitational Moment"],"Gravitational Forces on the Robot in Inertial Coordinates",{["Fx","Fy","Fz"],["Mx","My","Mz"]});
plots(9) = ClassPlot("Fb_T Mb_T",["Fb_T","Mb_T"],[2,1],{[1,2,3];[4,5,6]},["Force (N)","Moment (N*m)"],"Time (s)",["Thruster Force","Thruster Moment"],"Thruster Forces on the Robot in Body Coordinates",{["Fx","Fy","Fz"],["Mx","My","Mz"]});
plots(10) = ClassPlot("Fi_T Mi_T",["Fi_T","Mi_T"],[2,1],{[1,2,3];[4,5,6]},["Force (N)","Moment (N*m)"],"Time (s)",["Thruster Force","Thruster Moment"],"Thruster Forces on the Robot in Inertial Coordinates",{["Fx","Fy","Fz"],["Mx","My","Mz"]});

%individual thruster data
plots(11) = ClassPlot("pwm",["pwm"],[4, 2],{[1],[2],[3],[4],[5],[6],[7],[8]},["pwm (us)","pwm (us)","pwm (us)","pwm (us)","pwm (us)","pwm (us)","pwm (us)","pwm (us)"],"Time (s)",["Thruster 0","Thruster 1","Thruster 2","Thruster 3","Thruster 4","Thruster 5","Thruster 6","Thruster 7"],"Thruster PWM",["","","","","","","",""]);
plots(12) = ClassPlot("pwm_cmd",["pwm_cmd"],[4, 2],{[1],[2],[3],[4],[5],[6],[7],[8]},["pwm (us)","pwm (us)","pwm (us)","pwm (us)","pwm (us)","pwm (us)","pwm (us)","pwm (us)"],"Time (s)",["Thruster 0","Thruster 1","Thruster 2","Thruster 3","Thruster 4","Thruster 5","Thruster 6","Thruster 7"],"Commanded Thruster PWM",["","","","","","","",""]);
plots(13) = ClassPlot("FT_list",["FT_list"],[4, 2],{[1],[2],[3],[4],[5],[6],[7],[8]},["Force (N)","Force (N)","Force (N)","Force (N)","Force (N)","Force (N)","Force (N)","Force (N)"],"Time (s)",["Thruster 0","Thruster 1","Thruster 2","Thruster 3","Thruster 4","Thruster 5","Thruster 6","Thruster 7"],"Thruster Forces",["","","","","","","",""]);
plots(14) = ClassPlot("FT_cmd_list",["FT_cmd_list"],[4, 2],{[1],[2],[3],[4],[5],[6],[7],[8]},["Force (N)","Force (N)","Force (N)","Force (N)","Force (N)","Force (N)","Force (N)","Force (N)"],"Time (s)",["Thruster 0","Thruster 1","Thruster 2","Thruster 3","Thruster 4","Thruster 5","Thruster 6","Thruster 7"],"Commanded Thruster Forces",["","","","","","","",""]);

%positions

%attitudes

%velocities

%load all the plots with data from results
for k = 1:length(plots)
    plots(k).loadData(results);
end

if(plot_all_flag)
    for k = 1:length(plots)
        plot(plots(k));
    end
else
    for k = 1:length(plots)
        if ismember(plots(k).name,target_plot_names)
            plot(plots(k));
        end
    end
end
end