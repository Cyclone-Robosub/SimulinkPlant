function plotAllOutputs(results)
fields = results.who;
recognized_fields = [];
    %check if the given fields exist and call the appropriate plot function
    if ismember('PWM',fields)
        recognized_fields = [recognized_fields, 'PWM'];
        PWM = results.PWM;
        plotPWM(PWM);
    end

    if ismember('command',fields)
        recognized_fields = [recognized_fields, 'command'];
        command = results.command;
        plotCommand(command);
    end

    if ismember('Ri',fields)
        recognized_fields = [recognized_fields, 'Ri'];
        Ri = results.Ri;
        plotRi(Ri);
    end

    if ismember('Vi',fields)
        recognized_fields = [recognized_fields, 'Vi'];
        Vi = results.Vi;
        plotVi(Vi);
    end

    if ismember('Eul',fields)
        recognized_fields = [recognized_fields, 'Eul'];
        Eul = results.Eul;
        plotEul(Eul);
    end

    if ismember('Wb',fields)
        recognized_fields = [recognized_fields, 'Wb'];
        Wb = results.Wb;
        plotWb(Wb);
    end

    if ismember('FT_list',fields)
        recognized_fields = [recognized_fields, 'FT_list'];
        FT_list = results.FT_list;
        plotFT_list(FT_list);
    end

     if ismember('FTb',fields)
         recognized_fields = [recognized_fields, 'FTb'];
        FTb = results.FTb;
        plotFTb(FTb);
     end

     if ismember('MTb',fields)
        recognized_fields = [recognized_fields, 'MTb'];
        MTb = results.MTb;
        plotMTb(MTb);
     end

     if ismember('fT_cmd_list',fields)
         recognized_fields = [recognized_fields, 'fT_cmd_list'];
         fT_cmd_list = results.fT_cmd_list;
         plotfT_cmd_list(fT_cmd_list);
     end

     if ismember('pwm_cmd_list',fields)
         recognized_fields = [recognized_fields, 'pwm_cmd_list'];
         pwm_cmd_list = results.pwm_cmd_list;
         plotpwm_cmd_list(pwm_cmd_list);
     end

     % %loop through unrecognized fields and plot using plotUnknownSignal.
     for k = 1:length(fields)
        if(~contains(recognized_fields,fields{k}) && ~isequal('tout',fields{k}))
            %if the field is not recognized, plot it
            timeseries = results.(fields{k});
            plotUnknownSignal(timeseries,fields{k});
        end
     end
end