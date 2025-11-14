function plotAllOutputs(results,varargin)
%{
This function plots everything in the results structure. If the plots
variable is left empty, this function plots everything. Otherwise, only the
fields specified in plots are plotted. 

This function also plots any variables detected in the results structure
that do not already have a plot function associated with them.

The name of the field must match the name in plots exactly. 
%}

%disable latex interpretations (they get confused by underscores)
set(groot,'defaultTextInterpreter','none')

if(isempty(varargin))
    plot_all_flag = 1;
    plots = {};
else
    plot_all_flag = 0;
    plots = varargin{1};
end

fields = results.who;
recognized_fields = [];
    %check if the given fields exist and call the appropriate plot function
    if (ismember('PWM',fields) && (ismember('PWM',plots) || plot_all_flag))
        recognized_fields = [recognized_fields, 'PWM'];
        PWM = results.PWM;
        plotPWM(PWM);
    end
    %check if the given fields exist and call the appropriate plot function
    if (ismember('Fb_cmd_PID',fields) && (ismember('Fb_cmd_PID',plots) || plot_all_flag))
        recognized_fields = [recognized_fields, 'Fb_cmd_PID'];
        Fb_cmd_PID = results.Fb_cmd_PID;
        plotFb_cmd_PID(Fb_cmd_PID);
    end
    if (ismember('Mb_cmd_PID',fields) && (ismember('Mb_cmd_PID',plots) || plot_all_flag))
        recognized_fields = [recognized_fields, 'Mb_cmd_PID'];
        Mb_cmd_PID = results.Mb_cmd_PID;
        plotMb_cmd_PID(Mb_cmd_PID);
    end

     if (ismember('Fb_correction',fields) && (ismember('Fb_correction',plots) || plot_all_flag))
        recognized_fields = [recognized_fields, 'Fb_correction'];
        Fb_correction = results.Fb_correction;
        plotFb_correction(Fb_correction);
    end

    if (ismember('command',fields) && (ismember('command',plots) || plot_all_flag))
        recognized_fields = [recognized_fields, 'command'];
        command = results.command;
        plotCommand(command);
    end

    if (ismember('Ri',fields) && (ismember('Ri',plots) || plot_all_flag))
        recognized_fields = [recognized_fields, 'Ri'];
        Ri = results.Ri;
        plotRi(Ri);
    end

    if (ismember('dRi',fields) && (ismember('dRi',plots) || plot_all_flag))
        recognized_fields = [recognized_fields, 'dRi'];
        dRi = results.dRi;
        plotdRi(dRi);
    end

    if (ismember('ddRi',fields) && (ismember('ddRi',plots) || plot_all_flag))
        recognized_fields = [recognized_fields, 'ddRi'];
        ddRi = results.ddRi;
        plotddRi(ddRi);
    end

    if (ismember('dq',fields) && (ismember('dq',plots) || plot_all_flag))
        %to do
    end

    if (ismember('q',fields) && (ismember('q',plots) || plot_all_flag))
        %to do
    end

    if (ismember('dw',fields) && (ismember('dw',plots) || plot_all_flag))
        %to do
    end

    
    if (ismember('Eul',fields) && (ismember('Eul',plots) || plot_all_flag))
        recognized_fields = [recognized_fields, 'Eul'];
        Eul = results.Eul;
        plotEul(Eul);
    end

    if (ismember('w',fields) && (ismember('w',plots) || plot_all_flag))
        recognized_fields = [recognized_fields, 'w'];
        w = results.w;
        plotw(w);
    end

    if (ismember('FT_list',fields) && (ismember('FT_list',plots) || plot_all_flag))
        recognized_fields = [recognized_fields, 'FT_list'];
        FT_list = results.FT_list;
        plotFT_list(FT_list);
    end

    if (ismember('FTb',fields) && (ismember('FTb',plots) || plot_all_flag))
        recognized_fields = [recognized_fields, 'FTb'];
        FTb = results.FTb;
        plotFTb(FTb);
     end

    if (ismember('MTb',fields) && (ismember('MTb',plots) || plot_all_flag))
        recognized_fields = [recognized_fields, 'MTb'];
        MTb = results.MTb;
        plotMTb(MTb);
     end

    if (ismember('Fb',fields) && (ismember('Fb',plots) || plot_all_flag))
         recognized_fields = [recognized_fields,'Fb'];
         Fb = results.Fb;
         plotFb(Fb);
    end

    if (ismember('Fi',fields) && (ismember('Fi',plots) || plot_all_flag))
         recognized_fields = [recognized_fields,'Fi'];
         Fi = results.Fi;
         plotFi(Fi);
    end

    if (ismember('Mb',fields) && (ismember('Mb',plots) || plot_all_flag))
         %todo
         
     end

     if (ismember('Fb_buoy',fields) && (ismember('Fb_buoy',plots) || plot_all_flag))
         %todo
         recognized_fields = [recognized_fields,'Fb_buoy'];
         Fb_buoy = results.Fb_buoy;
         plotFb_buoy(Fb_buoy);
     end

     if (ismember('Mb_buoy',fields) && (ismember('Mb_buoy',plots) || plot_all_flag))
         %todo
         recognized_fields = [recognized_fields,'Mb_buoy'];
         Mb_buoy = results.Mb_buoy;
         plotMb_buoy(Mb_buoy);
     end

     if (ismember('Fi_buoy',fields) && (ismember('Fi_buoy',plots) || plot_all_flag))
         %todo
         recognized_fields = [recognized_fields,'Fi_buoy'];
         Fi_buoy = results.Fi_buoy;
         plotFi_buoy(Fi_buoy);
     end

     if (ismember('Fb_drag',fields) && (ismember('Fb_drag',plots) || plot_all_flag))
         %todo
         plotFTb
     end

     if (ismember('Mb_drag',fields) && (ismember('Mb_drag',plots) || plot_all_flag))
         %todo
     end

     if (ismember('Fb_g',fields) && (ismember('Fb_g',plots) || plot_all_flag))
         %todo
     end

     if (ismember('Mb_g',fields) && (ismember('Mb_g',plots) || plot_all_flag))
         %todo
     end

     if (ismember('fT_cmd_list',fields) && (ismember('fT_cmd_list',plots) || plot_all_flag))
         recognized_fields = [recognized_fields, 'fT_cmd_list'];
         fT_cmd_list = results.fT_cmd_list;
         plotfT_cmd_list(fT_cmd_list);
     end

     if (ismember('pwm_cmd_list',fields) && (ismember('pwm_cmd_list',plots) || plot_all_flag))
         recognized_fields = [recognized_fields, 'pwm_cmd_list'];
         pwm_cmd_list = results.pwm_cmd_list;
         plotpwm_cmd_list(pwm_cmd_list);
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