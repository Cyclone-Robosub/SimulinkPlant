function plotAllOutputsDraft(results,varargin)
%{
This function plots everything in the results structure. If the plots
variable is left empty, this function plots everything. Otherwise, only the
fields specified in plots are plotted. Some plot functions here are
overloaded so the code can be reused. Wildcard functions are used to plot
these signals.

This function also plots any variables detected in the results structure
that do not already have a plot function associated with them. This is
useful for debugging, but if you need access to a variable regularly that
isn't included in this list, just make a plot function for it.

The name of the field must match the name in plots exactly. This means you
MUST make sure all to-workspace blocks are properly configured with a name
that matches a plot function or wildcard and the sample time set to
dt_data.

Changelog: 
- Created 10/21/25 KJH
- Created draft version of plotAllOutputs with wildcard overloading for
better scalability and cleaner implimentation. 12/01/25 KJH
%}

%disable latex interpretations (they get confused by underscores)
set(groot,'defaultTextInterpreter','none')


%detects if the user specified specific plots or if we should do everything
if(isempty(varargin))
    plot_all_flag = 1;
    plots = {};
else
    plot_all_flag = 0;
    plots = varargin{1};
end

%gets the names of all the fields from the results structure
fields = results.who;

%{ 
This list will be used to make sure that plotUnknownSignals doesn't plot
anything that already has a plot function. 
%}
recognized_fields = [];

%{
Loop through all the field names and attempt to assign them to a wildcard
function.
%}

for k = 1:length(fields)
    dataset = results.(fields{k});
    name = fields{k};

    %check if this is a force vector
    if startsWith(name,"Fb") || startsWith(name,"Fi")
        plotFx(dataset,name);
    
    %check if this is a moment vector
    elseif startsWith(name,"Mb") || startsWith(name,"Mi")
        plotMx(dataset,name);
    
    %check if this is a position vector
    elseif startsWith(name,"Rb") || startsWith(name,"Ri")
        plotRx(dataset,name);

    %check if this is a velocity vector
    elseif startsWith(name,"dRb")  || startsWith(name,"dRi")
        plotdRx(dataset,name);
    
    %check if this is an acceleration vector
    elseif startsWith(name,"ddRb")  || startsWith(name,"ddRi")
        plotddRx(dataset,name);
    
    %check if this is an FT_list
    elseif startsWith(name,"FT_")
        plotFT_x(dataset,name);
    
    %check if this is a pwm list
    elseif startsWith(name,"pwm")
        plotpwm_x(dataset,name);
    
    %check if this is an euler angle set
    elseif startsWith(name,"Eul")
        plotEul_x(dataset,name);

    elseif startsWith(name,"q")
        plotq_x(dataset,name);
    
    %check if this is an angular velocity
    elseif startsWith(name,"w")
        plotw_x(dataset,name);
    
    %check if this is a rotation matrix
    elseif startsWith(name,"C")
        plotCxx(dataset);
    
    end %if

end %for

%{
Additional plot functions that are not part of wildcards go here. When
creating a new plot, make sure it isn't better suited as part of an
existing wildcard.

These are typically weird variables that wouldn't make sense in any other
wildcard category. If you are finding a lot of these functions look
similar, consider making your own wildcard function to house them. 
%}
if (ismember('current_maneuver_index',fields) && (ismember('current_maneuver_index',plots) || plot_all_flag))
    recognized_fields = [recognized_fields, 'current_maneuver_index'];
    current_maneuver_index = results.current_maneuver_index;
    plotcurrent_maneuver_index(current_maneuver_index);
end

if (ismember('this_maneuver_index',fields) && (ismember('this_maneuver_index',plots) || plot_all_flag))
    recognized_fields = [recognized_fields, 'this_maneuver_index'];
    this_maneuver_index = results.this_maneuver_index;
    pltothis_maneuver_index(this_maneuver_index);
end

if (ismember('cmd',fields) && (ismember('cmd',plots) || plot_all_flag))
    recognized_fields = [recognized_fields, 'cmd'];
    cmd = results.cmd;
    pltocmd(cmd);
end


if (ismember('flags',fields) && (ismember('flags',plots) || plot_all_flag))
    recognized_fields = [recognized_fields, 'flags'];
    flags = results.flags;
    pltoflags(flags);
end

if (ismember('maneuver_data_FF',fields) && (ismember('maneuver_data_FF',plots) || plot_all_flag))
    recognized_fields = [recognized_fields, 'maneuver_data_FF'];
    maneuver_data_FF = results.maneuver_data_FF;
    pltomaneuver_data_FF(maneuver_data_FF);
end




% %loop through unrecognized fields and plot using plotUnknownSignal.
if(plot_all_flag)
    for k = 1:length(fields)
       if(~contains(recognized_fields,fields{k}) && ~isequal('tout',fields{k}))
           %if the field is not recognized, plot it
           timeseries = results.(fields{k});
           plotUnknownSignal(timeseries,fields{k});
       end
    end
end
end