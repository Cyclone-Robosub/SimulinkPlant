function plotCommand(command)
%{
command = [this_control_mode,this_maneuver_id,...
            this_maneuver_duration,this_maneuver_intensity,state_target,...
            this_maneuver_time];
%}

t = command.Time; %Nx1
command = squeeze(command.Data)'; %Nx11
command = enforceTallSkinny(command);
mode = command(:,1);
ID = command(:,2);
dur = command(:,3);
int = command(:,4);
mt = command(:,11);

if(isValidPlotData(t,command,[length(t),11]))
    figure('Name','Command','NumberTitle','off')

    
    subplot(2,2,1)
    plot(t,mode,'Color','b')
    xlabel("Time (s)")
    title("Controller Mode")
    ylim([-0.2,max(mode)+0.2])

    subplot(2,2,2)
    plot(t,ID,'Color','r')
    xlabel("Time (s)")
    title("Maneuver ID")
    ylim([-0.5,max(ID)+0.5])

    subplot(2,2,3)
    plot(t,dur)
    hold on
    plot(t,mt)
    title("Maneuver Timing")
    xlabel("Time (s)")
    ylabel("Time (s)")
    legend("Current Maneuver Duration","Maneuver Local Time")
    ylim([-1,max(dur)+1]);

    subplot(2,2,4)
    plot(t,int)
    title("Maneuver Intensity")
    xlabel("Time (s)")
    ylabel("Intensity")
    ylim([min(int)-0.1,max(int)+0.1])
else
    warning("Invalid dataset detected in plotCommand. Plotting was aborted.")
end

end