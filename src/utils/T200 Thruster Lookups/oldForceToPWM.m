function pwm_cmd = oldForceToPWM(thruster_force_cmd)

pwm_cmd = 0;
%uses a curve fit for thrust to pwm from the t200 thruster data sheet

for i=1:length(pwm_cmd)
    x = thruster_force_cmd(i);

    if(x>0)
        y = round(0.00231011300235566*x^3 + -0.229204832763592*x^2 + 13.7272237851422*x + 1536.34500151024);
    elseif(x<0)
        y = round(0.00475737746846442*x^3 + 0.360062809963915*x^2 + 17.2034080439155*x + 1463.91061014397);
    else
        y = 1500;
    end

    %saturation
    if(y > 1900)
        y = 1900;
    end
    if (y < 1100)
        y = 1100;
    end

    pwm_cmd = y;

end


