function plotAllOutputs(results)
fields = results.who;

    %check if the given fields exist and call the appropriate plot function
    if ismember('PWM',fields)
        PWM = results.PWM;
        plotPWM(PWM);
    end

    if ismember('command',fields)
        command = results.command;
        plotCommand(command);
    end
end