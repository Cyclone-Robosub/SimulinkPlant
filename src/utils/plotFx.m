function plotFx(data,name)
%{
This is the wildcard function called by plotAllOutputs to create graphs of
any force plots. Here data is the structure output from a to-workspace
block into the results structure, NOT the complete results structure. 

To augment this function with additional options, simply add elements to
the lists defined below.
%}

%unpack the data and enforce the orientation of the dataset
t = data.Time;
F = squeeze(data.Data); %squeeze removes the extraneous dimension simulink sometimes adds

%{
Make sure the data matrix is oriented as an Nx3 matrix. This makes it
harder to break the function when the user does something silly like pass
in a dataset with the wrong orientation.
%}
F = enforceTallSkinny(F);

% lookup for variable names and plot titles
lookup = {
    'Fb'        'Body Force'
    'Fi'        'Inertial Force'
    'Fb_buoy'   'Body Force from Buoyancy'
    'Fb_g'      'Body Force from Gravity'
    'Fb_drag'   'Body Force from Drag'
    'Fi_g'      'Inertial Force from Gravity'
    'Fb_cmd_PID' 'PID Commanded Body Force'
    'Fb_cmd_hyb' 'Hybrid Commanded Body Force'
    'Fb_cmd_FF'  'Feed Forward Commanded Body Force'
    'Fb_cmd' 'Commanded Body Force'
};

% find the index in the lookup table
index = strcmp(lookup(:,1), name);

% if the index is found, identify the title, otherwise just use the name
if any(index)
    plot_title = lookup{index,2};
else
    plot_title = name;
end

% make sure the plot data isn't malformed then plot
if(isValidPlotData(t,F,[length(t),3]))
    %setup
    figure('Name',name,'NumberTitle','off')
    
    %plots
    hold on %make sure all plots appear on the same graph
    plot(t,F(:,1))
    plot(t,F(:,2))
    plot(t,F(:,3))
    hold off %prevent axis from being added up by later functions

    %labels
    title(plot_title)
    legend(["Fx", "Fy", "Fz"])
    xlabel("Time (s)")
    ylabel("Force (N)")

    % automatically set the limits to sensible bounds
    xlim([min(t),max(t)])
    ylim([min(F(:))-1,max(F(:))+1])

    % misc formatting
    grid on
    
else
    warning("Invalid dataset detected in the wildcard plot function %s for name %s. This plot was skipped.",...
        mfilename,name)
end







%
end