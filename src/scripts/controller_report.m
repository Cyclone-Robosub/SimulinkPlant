%{
This script is intended to be run after a controller test using either a
SIM or HIL model. 

This script prints out a table of all the PID controller parameters and
creates plots of the controller state vs setpoint for each controlled
state, the force commands, and moment commands, the thruster commands, and
the pwms. 

The outputs are saved automatically to the data file.

NOTE: Expects all ToFile or ToWorkspace blocks to have been saved with the
same rate dt_data!
%}

fprintf("Generating controller report for the data at:\n");
fprintf("%s\n\n",prj_path_list.prior_run_data_path);

%creates "results" from the data file if it isn't already in the workspace
if(~exist('results','var'))
    results = Simulink.SimulationOutput;
    results = fileToResults(results, prj_path_list.prior_run_data_path);
end

%use the joystick_mode_enabled_flag as a mask to select the portions of the
%data where the feedback controller is running
mask = ~squeeze(results.joystick_mode_enabled_flag.Data);
N = length(mask); 

fprintf("TEST CONFIGURATION\n");
fprintf("Attitude Control Enabled: %s\n", string(do_moment_cmd_flag));
fprintf("Position Control Enabled: %s\n\n", string(do_force_cmd_flag));
fprintf("Injecting State Errors (Eul, Rb): %s\n", string(overwrite_state_error_flag));
fprintf("Injecting Rate Errors (wb, dRb): %s\n", string(overwrite_rate_error_flag));
fprintf("Injecting State Setpoints (Eul, Rb): %s\n", string(overwrite_state_setpoint_flag));
fprintf("Injecting Rate Setpoints (wb, dRb): %s\n\n", string(overwrite_rate_setpoint_flag));

fprintf("INJECTED VALUES\n\n");
if(overwrite_state_error_flag)
    fprintf("Eul Error: [%.2f, %.2f, %.2f]\n", eul_error_inject(1), eul_error_inject(2), eul_error_inject(3));
    fprintf("Rb Error: [%.2f, %.2f, %.2f]\n", Rb_error_inject(1), Rb_error_inject(2), Rb_error_inject(3));
end
if(overwrite_rate_error_flag)
    fprintf("wb Error: [%.2f, %.2f, %.2f]\n",wb_error_inject(1), wb_error_inject(2), wb_error_inject(3));
    fprintf("dRb Error: [%.2f, %.2f, %.2f]\n\n", dRb_error_inject(1), dRb_error_inject(2), dRb_error_inject(3));
end
if(overwrite_state_setpoint_flag)
    fprintf("Eul SP: [%.2f, %.2f, %.2f]\n",eul_sp_inject(1), eul_sp_inject(2), eul_sp_inject(3));
    fprintf("Rb SP: [%.2f, %.2f, %.2f]\n", Rb_sp_inject(1), Rb_sp_inject(2), Rb_sp_inject(3));
end
if(overwrite_rate_setpoint_flag)
    fprintf("wb SP: [%.2f, %.2f, %.2f]\n",wb_sp_inject(1), wb_sp_inject(2), wb_sp_inject(3));
    fprintf("dRb SP: [%.2f, %.2f, %.2f]\n\n", Rb_sp_inject(1), Rb_sp_inject(2), Rb_sp_inject(3));
end

fprintf("CONTROLLER PERFORMANCE\n\n");

fprintf("\nAttitude --> Angular Velocity:\n");
fprintf("\t P = [%.2f, %.2f, %.2f, %.2f]\n", qib_PID.Kp(1), qib_PID.Kp(2), qib_PID.Kp(3), qib_PID.Kp(4));
fprintf("\t I = [%.2f, %.2f, %.2f, %.2f]\n", qib_PID.Kp(1), qib_PID.Kp(2), qib_PID.Kp(3), qib_PID.Kp(4));
fprintf("\t D = [%.2f, %.2f, %.2f, %.2f]\n", qib_PID.Kp(1), qib_PID.Kp(2), qib_PID.Kp(3), qib_PID.Kp(4));
fprintf("\t Int Sat = %.2f\n", qib_PID.int_sat);
fprintf("\t Out Sat = %.2f\n", qib_PID.output_sat);

fprintf("\nAngular Velocity --> Force:\n");
fprintf("\t P = [%.2f, %.2f, %.2f]\n", wb_PID.Kp(1), wb_PID.Kp(2), wb_PID.Kp(3));
fprintf("\t I = [%.2f, %.2f, %.2f]\n", wb_PID.Ki(1), wb_PID.Ki(2), wb_PID.Ki(3));
fprintf("\t D = [%.2f, %.2f, %.2f]\n", wb_PID.Kd(1), wb_PID.Kd(2), wb_PID.Kd(3));
fprintf("\t Int Sat = %.2f\n", wb_PID.int_sat);
fprintf("\t Out Sat = %.2f\n", wb_PID.output_sat);

fprintf("\nPosition --> Velocity\n");
fprintf("\t P = [%.2f, %.2f, %.2f]\n", Rb_PID.Kp(1), Rb_PID.Kp(2), Rb_PID.Kp(3));
fprintf("\t I = [%.2f, %.2f, %.2f]\n", Rb_PID.Ki(1), Rb_PID.Ki(2), Rb_PID.Ki(3));
fprintf("\t D = [%.2f, %.2f, %.2f]\n", Rb_PID.Kd(1), Rb_PID.Kd(2), Rb_PID.Kd(3));
fprintf("\t Int Sat = %.2f\n", Rb_PID.int_sat);
fprintf("\t Out Sat = %.2f\n", Rb_PID.output_sat);

fprintf("\nVelocity --> Force\n");
fprintf("\t P = [%.2f, %.2f, %.2f]\n", dRb_PID.Kp(1), dRb_PID.Kp(2), dRb_PID.Kp(3));
fprintf("\t I = [%.2f, %.2f, %.2f]\n", dRb_PID.Ki(1), dRb_PID.Ki(2), dRb_PID.Ki(3));
fprintf("\t D = [%.2f, %.2f, %.2f]\n", dRb_PID.Kd(1), dRb_PID.Kd(2), dRb_PID.Kd(3));
fprintf("\t Int Sat = %.2f\n", dRb_PID.int_sat);
fprintf("\t Out Sat = %.2f\n", dRb_PID.output_sat);



eul = enforceTallSkinny(squeeze(results.Eul_est.Data));
eul_u = enforceTallSkinny(squeeze(results.Eul_u.Data));
wb = enforceTallSkinny(squeeze(results.wb_est.Data));
wb_u = enforceTallSkinny(squeeze(results.wb_u.Data));
Rb = enforceTallSkinny(squeeze(results.Rb_est.Data));
Rb_u = enforceTallSkinny(squeeze(results.Rb_u.Data));
dRb = enforceTallSkinny(squeeze(results.dRb_est.Data));
dRb_u = enforceTallSkinny(squeeze(results.dRb_u.Data));
pwm_cmd = enforceTallSkinny(squeeze(results.pwm_cmd.Data));
force_cmd = enforceTallSkinny(squeeze(results.force_cmd.Data));
moment_cmd = enforceTallSkinny(squeeze(results.moment_cmd.Data));
FT_cmd_list = enforceTallSkinny(squeeze(results.FT_cmd_list.Data));

t = results.Eul_est.Time;

%roll, roll rate
figure('Name','Roll','NumberTitle','off')
subplot(2,1,1)
plot(t(mask), eul(mask,1),'Color','#005073')
hold on
plot(t(mask), eul_u(mask,1),'Color','#107dac','LineStyle','--')
title("Roll Controller")
xlabel("Time (s)")
ylabel("Angle (rad)")
legend(["Roll", "Roll SP"])
subplot(2,1,2)
plot(t(mask), wb(mask,1),'Color','#189ad3')
hold on
plot(t(mask), wb_u(mask,1),'Color','#71c7ec', 'LineStyle','--')
title("Roll Rate Controller")
xlabel("Time (s)")
ylabel("Angular Velocity (rad/s)")
legend(["Roll Rate", "Role Rate SP"])
sgtitle("ROLL")

%pitch, pitch rate
figure('Name','Pitch','NumberTitle','off')
subplot(2,1,1)
plot(t(mask), eul(mask,2),'Color','#005073')
hold on
plot(t(mask), eul_u(mask,2),'Color','#107dac','LineStyle','--')
title("Pitch Controller")
xlabel("Time (s)")
ylabel("Angle (rad)")
legend(["Pitch", "Pitch SP"])
subplot(2,1,2)
plot(t(mask), wb(mask,2),'Color','#189ad3')
hold on
plot(t(mask), wb_u(mask,2),'Color','#71c7ec', 'LineStyle','--')
title("Pitch Rate Controller")
xlabel("Time (s)")
ylabel("Angular Velocity (rad/s)")
legend(["Pitch Rate", "Pitch Rate SP"])
sgtitle("PITCH")

%yaw, yaw rate
figure('Name','Yaw','NumberTitle','off')
subplot(2,1,1)
plot(t(mask), eul(mask,3),'Color','#005073')
hold on
plot(t(mask), eul_u(mask,3),'Color','#107dac','LineStyle','--')
title("Yaw Controller")
xlabel("Time (s)")
ylabel("Angle (rad)")
legend(["Yaw", "Yaw SP"])
subplot(2,1,2)
plot(t(mask), wb(mask,3),'Color','#189ad3')
hold on
plot(t(mask), wb_u(mask,3),'Color','#71c7ec', 'LineStyle','--')
title("Yaw Rate Controller")
xlabel("Time (s)")
ylabel("Angular Velocity (rad/s)")
legend(["Yaw Rate", "Yaw Rate SP"])
sgtitle("YAW")


%x, dx
figure('Name','X','NumberTitle','off')
subplot(2,1,1)
plot(t(mask), Rb(mask,1),'Color','#005073')
hold on
plot(t(mask), Rb_u(mask,1),'Color','#107dac','LineStyle','--')
title("X Controller")
xlabel("Time (s)")
ylabel("Position (m)")
legend(["X", "X SP"])
subplot(2,1,2)
plot(t(mask), wb(mask,1),'Color','#189ad3')
hold on
plot(t(mask), wb_u(mask,1),'Color','#71c7ec', 'LineStyle','--')
title("dX Controller")
xlabel("Time (s)")
ylabel("Velocity (m/s)")
legend(["dX", "dX SP"])
sgtitle("X")


%y, dy
figure('Name','Y','NumberTitle','off')
subplot(2,1,1)
plot(t(mask), Rb(mask,2),'Color','#005073')
hold on
plot(t(mask), Rb_u(mask,2),'Color','#107dac','LineStyle','--')
title("Y Controller")
xlabel("Time (s)")
ylabel("Position (m)")
legend(["Y", "Y SP"])
subplot(2,1,2)
plot(t(mask), wb(mask,2),'Color','#189ad3')
hold on
plot(t(mask), wb_u(mask,2),'Color','#71c7ec', 'LineStyle','--')
title("dY Controller")
xlabel("Time (s)")
ylabel("Velocity (m/s)")
legend(["dY", "dY SP"])
sgtitle("Y")



%z, dz
figure('Name','Z','NumberTitle','off')
subplot(2,1,1)
plot(t(mask), Rb(mask,3),'Color','#005073')
hold on
plot(t(mask), Rb_u(mask,3),'Color','#107dac','LineStyle','--')
title("Z Controller")
xlabel("Time (s)")
ylabel("Position (m)")
legend(["Z", "Z SP"])
subplot(2,1,2)
plot(t(mask), wb(mask,3),'Color','#189ad3')
hold on
plot(t(mask), wb_u(mask,3),'Color','#71c7ec', 'LineStyle','--')
title("dZ Controller")
xlabel("Time (s)")
ylabel("Velocity (m/s)")
legend(["dZ", "dZ SP"])
sgtitle("Z")

%Force, Moment
figure('Name','Force Moment','NumberTitle','off')
subplot(2,1,1)
plot(t(mask), force_cmd(mask,1),'Color','#005073')
hold on
plot(t(mask), force_cmd(mask,2),'Color','#005073')
plot(t(mask), force_cmd(mask,3),'Color','#005073')
title("Force Command")
xlabel("Time (s)")
ylabel("Force (N)")
legend(["Fbx", "Fby", "Fbz"])
subplot(2,1,2)
plot(t(mask), moment_cmd(mask,1),'Color','#005073')
hold on
plot(t(mask), moment_cmd(mask,2),'Color','#005073')
plot(t(mask), moment_cmd(mask,3),'Color','#005073')
title("Moment Command")
xlabel("Time (s)")
ylabel("Moment (N-M)")
legend(["Mbx", "Mby", "Mbz"])
sgtitle("Z")

%PWMS
figure('Name','PWM', 'NumberTitle','off')
subplot(4,2,1)
plot(t(mask), pwm_cmd(mask,1))
xlabel("Time (s)")
ylabel("pwm (us)")
title("Thruster 0")
subplot(4,2,2)
plot(t(mask), pwm_cmd(mask,2))
xlabel("Time (s)")
ylabel("pwm (us)")
title("Thruster 1")
subplot(4,2,3)
plot(t(mask), pwm_cmd(mask,3))
xlabel("Time (s)")
ylabel("pwm (us)")
title("Thruster 2")
subplot(4,2,4)
plot(t(mask), pwm_cmd(mask,4))
xlabel("Time (s)")
ylabel("pwm (us)")
title("Thruster 3")
subplot(4,2,5)
plot(t(mask), pwm_cmd(mask,5))
xlabel("Time (s)")
ylabel("pwm (us)")
title("Thruster 4")
subplot(4,2,6)
plot(t(mask), pwm_cmd(mask,6))
xlabel("Time (s)")
ylabel("pwm (us)")
title("Thruster 5")
subplot(4,2,7)
plot(t(mask), pwm_cmd(mask,7))
xlabel("Time (s)")
ylabel("pwm (us)")
title("Thruster 6")
subplot(4,2,8)
plot(t(mask), pwm_cmd(mask,8))
xlabel("Time (s)")
ylabel("pwm (us)")
title("Thruster 7")
sgtitle("PWM")

%FT_List
figure('Name','FT_List', 'NumberTitle','off')
subplot(4,2,1)
plot(t(mask), FT_cmd_list(mask,1))
xlabel("Time (s)")
ylabel("Force (N)")
title("Thruster 0")
subplot(4,2,2)
plot(t(mask), FT_cmd_list(mask,2))
xlabel("Time (s)")
ylabel("Force (N)")
title("Thruster 1")
subplot(4,2,3)
plot(t(mask), FT_cmd_list(mask,3))
xlabel("Time (s)")
ylabel("Force (N)")
title("Thruster 2")
subplot(4,2,4)
plot(t(mask), FT_cmd_list(mask,4))
xlabel("Time (s)")
ylabel("Force (N)")
title("Thruster 3")
subplot(4,2,5)
plot(t(mask), FT_cmd_list(mask,5))
xlabel("Time (s)")
ylabel("Force (N)")
title("Thruster 4")
subplot(4,2,6)
plot(t(mask), FT_cmd_list(mask,6))
xlabel("Time (s)")
ylabel("Force (N)")
title("Thruster 5")
subplot(4,2,7)
plot(t(mask), FT_cmd_list(mask,7))
xlabel("Time (s)")
ylabel("Force (N)")
title("Thruster 6")
subplot(4,2,8)
plot(t(mask), FT_cmd_list(mask,8))
xlabel("Time (s)")
ylabel("Force (N)")
title("Thruster 7")
sgtitle("FT_list")