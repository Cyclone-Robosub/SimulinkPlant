function [qib_int_u, Rb_error, action_id_out, driving_yaw_target, Rb_u,debug] = guidanceLaw(X, Xu, Ri_e_tol, Eul_e_tol, cmd, overwrite_state_error_flag, Rb_error_inject, overwrite_state_setpoint_flag, Rb_sp_inject)
%{
This function breaks down the state X and target state Xu into body-centric
commands. An inertial position and attitude error is manipulated so that
the controller 1) points the vehicle toward the target, 2) drives towards
the target, and 3) aligns at the commanded attitude once at the target.

Inputs:
X - state vector in the form [Ri; qib, dRi, wb] where qib is expressed in
the [vector; scalar] convention. 
Xu - the target state vector, overwrite_state_sp_flag, Rb_sp_inject

Outputs:
qib_int_u - an intermediate target quaternion to point the vehicle at the
target if Ri - Ri_u is large. If the position error is small, qib_int_u
returns qib_u.
dRbx_u - a velocity command in the forward forward/backward of the vehicle
dRbz_u - a velocity command in the up/down direction of the vehicle
action_id - what the controller is currently trying to do (1 = point to wp, 2 =
drive to wp)
%}
debug = 0;

persistent persistant_yaw_target
persistent action_id
persistent prior_action_id

if(isempty(action_id))
    action_id = 1;
end
if(isempty(prior_action_id))
    prior_action_id = action_id;
end


%unpack the required inputs (wb_u and dRi_u are assumed zero)
Ri = X.Ri;
Ri_u = Xu(1:3);
qib = X.qib; %[vector, scalar]
qib_u = Xu(4:7);

%project the position target and position onto the xy inertial plane
Ri_xy_u = [Ri_u(1); Ri_u(2)];
Ri_xy = [Ri(1); Ri(2)]; 

%find the error vector from the vehicle to the target
Ri_xy_e = Ri_xy_u - Ri_xy; 

%find the yaw to point at the target
pitch_u = 0; %to keep vehicle level 
roll_u = 0;
yaw_u = atan2(Ri_xy_e(2),Ri_xy_e(1)); %pi
debug = yaw_u;

if(isempty(persistant_yaw_target))
    persistant_yaw_target = yaw_u;
end

%TODO - add some filtering to prevent jitter from yaw_u recalc
%TODO - remove unused persistent_yaw_target code
%if the position error is large, use yaw target for the target quaternion
if(norm(Ri_xy_e) >= Ri_e_tol)
    qib_int_u = eulToQuat([roll_u, pitch_u, yaw_u]);
    persistant_yaw_target = yaw_u;
else
    Eul_u = quatToEul(qib_u);
    persistant_yaw_target = yaw_u;
    qib_int_u = qib_u;
    
end
Eul_u = quatToEul(qib_int_u);
%{
Eul_u is not switching backward for some reason when the vehicle passes
waypoint.
%}

%If the trick ID is duration trick, no need to make any intermediate yaw
%waypoints so just use the qib_u
if(isequal(char(cmd.cmd_id),'duration_trick__'))
    qib_int_u = qib_u;
    if(isequal(char(cmd.trick_id), 'barrel_roll_____'))
        Eul_u = quatToEul(qib_u);
        Eul_u_modified = [0; Eul_u(2); Eul_u(3)];
        qib_int_u = eulToQuat(Eul_u_modified);
    end
end



%calculate the quaternion error between the current and target attitudes
qib_e = quatError(qib, qib_int_u); %expected in the form [vector; scalar]

%calculate the roll, pitch, and yaw error from this quaternion
Eul_e = quatToEul(qib_e);

%if any of the angle errors are large, don't command forward or up
if(max(abs(Eul_e)) > Eul_e_tol) %TURNING
    % Rb_error = [0;0;0];

    %allow for x, y, and z body commands (these should be small due to the
    %idle waypoint)
    Cib = quatToRotm(qib);
    Cbi = Cib';
    Rb_u = Cbi*Ri_u;
    Rb = Cbi*Ri;
    Rb_error = Rb_u - Rb;

    action_id = 1;
    

elseif(norm(Ri_xy_e) >= Ri_e_tol) %DRIVING
    %use only forward and up commands if we are far away the target
    %this will only be reached if the vehicle is level and pointing toward
    %the target, so no need to convert any of these to the body frame.
    %once we reach driving mode, clear the persistant yaw target
    Cib = quatToRotm(qib);
    Cbi = Cib';
    Rb_u = Cbi*Ri_u;
    
    Rb_error = [norm(Ri_xy_e); 0; Ri_u(3) - Ri(3)];
    action_id = 2;
    

else %SETTLING
    %allow for x, y, and z body commands
    Cib = quatToRotm(qib);
    Cbi = Cib';
    Rb_u = Cbi*Ri_u;
    Rb = Cbi*Ri;
    Rb_error = Rb_u - Rb;

    action_id = 3;
    
end

if(overwrite_state_setpoint_flag)
    Rb_u = Rb_sp_inject;
    Rb = Cbi*Ri;
    Rb_error = Rb_u - Rb;
end

if(overwrite_state_error_flag)
    Rb_error = Rb_error_inject;
end

%update the yaw target every time the action id changes
if(action_id ~= prior_action_id)
    persistant_yaw_target = yaw_u;
end




action_id_out = action_id;
driving_yaw_target = persistant_yaw_target;
prior_action_id = action_id;
end