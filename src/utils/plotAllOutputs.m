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

    if ismember('Ri',fields)
        Ri = results.Ri;
        plotRi(Ri);
    end

    if ismember('Vi',fields)
        Vi = results.Vi;
        plotVi(Vi);
    end

    if ismember('Eul',fields)
        Eul = results.Eul;
        plotEul(Eul);
    end

    if ismember('Wb',fields)
        Wb = results.Wb;
        plotWb(Wb);
    end

    if ismember('FT_list',fields)
        FT_list = results.FT_list;
        plotFT_list(FT_list);
    end

     if ismember('FTb',fields)
        FTb = results.FTb;
        plotFTb(FTb);
     end

     if ismember('MTb',fields)
        MTb = results.MTb;
        plotMTb(MTb);
     end

end