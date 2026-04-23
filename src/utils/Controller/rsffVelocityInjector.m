function [wb_e, dRb_e] = rsffVelocityInjector(cmd, wb_e, dRb_e, X_est, RSFF_maneuvers)
%{
This function acts by modifying the velocity and angular velocity error
before they are fed into the corresponding PID controllers. The objective
of this function is to provide limited feedback control capability based on
the sensor measurements from the IMU and the DVL without sensor fusion. 

If the cmd_id is duration_trick, this function throws out the errors sent
from upstream in the cascade controller and just ouputs the error based on
the reference rates stored in the maneuver.
%}

%rotate the imu measurement
dX_meas = [X_est.dRb; X_est.wb];

if(isequal(char(cmd.cmd_id),'duration_trick__'))
    switch char(cmd.trick_id)
        case 'rsff_forward____'
                        dX_e = RSFF_maneuvers.rsff_forward - dX_meas;
                        dRb_e = dX_e(1:3);
                        wb_e = dX_e(4:6);
        case 'rsff_backward___'
                        dX_e = RSFF_maneuvers.rsff_backward - dX_meas;
                        dRb_e = dX_e(1:3);
                        wb_e = dX_e(4:6);
        case 'rsff_up_________'
                        dX_e = RSFF_maneuvers.rsff_up - dX_meas;
                        dRb_e = dX_e(1:3);
                        wb_e = dX_e(4:6);
        case 'rsff_down_______'
                        dX_e = RSFF_maneuvers.rsff_down - dX_meas;
                        dRb_e = dX_e(1:3);
                        wb_e = dX_e(4:6);
        case 'rsff_right______'
                        dX_e = RSFF_maneuvers.rsff_right - dX_meas;
                        dRb_e = dX_e(1:3);
                        wb_e = dX_e(4:6);
        case 'rsff_left_______'
                        dX_e = RSFF_maneuvers.rsff_left - dX_meas;
                        dRb_e = dX_e(1:3);
                        wb_e = dX_e(4:6);
        case 'rsff_pitchUp____'
                        dX_e = RSFF_maneuvers.rsff_pitchUp - dX_meas;
                        dRb_e = dX_e(1:3);
                        wb_e = dX_e(4:6);
        case 'rsff_pitchDown__'
                        dX_e = RSFF_maneuvers.rsff_pitchDown - dX_meas;
                        dRb_e = dX_e(1:3);
                        wb_e = dX_e(4:6);
        case 'rsff_yawRight___'
                        dX_e = RSFF_maneuvers.rsff_yawRight - dX_meas;
                        dRb_e = dX_e(1:3);
                        wb_e = dX_e(4:6);
        case 'rsff_yawLeft____'
                        dX_e = RSFF_maneuvers.rsff_yawLeft - dX_meas;
                        dRb_e = dX_e(1:3);
                        wb_e = dX_e(4:6);
        case 'rsff_rollRight__'
                        dX_e = RSFF_maneuvers.rsff_rollRight - dX_meas;
                        dRb_e = dX_e(1:3);
                        wb_e = dX_e(4:6);
        case 'rsff_rollLeft___'
                        dX_e = RSFF_maneuvers.rsff_rollLeft - dX_meas;
                        dRb_e = dX_e(1:3);
                        wb_e = dX_e(4:6);
        case 'rsff_stop_______'
                        dX_e = RSFF_maneuvers.rsff_stop - dX_meas;
                        dRb_e = dX_e(1:3);
                        wb_e = dX_e(4:6);
        otherwise
            %no need to modify the velocity if not in an rsff trick.
             dRb_e = dRb_e;
             wb_e = wb_e;
    end
end
end