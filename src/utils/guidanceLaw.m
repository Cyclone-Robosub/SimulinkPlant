function [qib_int_u, Rb_error, action_id_out] = guidanceLaw(X, Xu, Ri_e_tol, Eul_e_tol)
%{
This function breaks down the state X and target state Xu into body-centric
commands. An inertial position and attitude error is manipulated so that
the controller 1) points the vehicle toward the target, 2) drives towards
the target, and 3) aligns at the commanded attitude once at the target.

Inputs:
X - state vector in the form [Ri; qib, dRi, wb] where qib is expressed in
the [vector; scalar] convention. 
Xu - the target state vector

Outputs:
qib_int_u - an intermediate target quaternion to point the vehicle at the
target if Ri - Ri_u is large. If the position error is small, qib_int_u
returns qib_u.
dRbx_u - a velocity command in the forward forward/backward of the vehicle
dRbz_u - a velocity command in the up/down direction of the vehicle
action_id - what the controller is currently trying to do (1 = point to wp, 2 =
drive to wp)
%}

persistent persistant_yaw_target
persistent action_id

if(isempty(action_id))
    action_id = 1;
end


%unpack the required inputs (wb_u and dRi_u are assumed zero)
Ri = X(1:3);
Ri_u = Xu(1:3);
qib = X(4:7); %[vector, scalar]
qib_u = Xu(4:7);

%project the position target and position onto the xy inertial plane
Ri_xy_u = [Ri_u(1); Ri_u(2)]; %[-5,0]
Ri_xy = [Ri(1); Ri(2)]; %[0 0]

%find the error vector from the vehicle to the target
Ri_xy_e = Ri_xy_u - Ri_xy; %[-5 0]

%find the yaw to point at the target
pitch_u = 0; %to keep vehicle level 
roll_u = 0;
yaw_u = atan2(Ri_xy_e(2),Ri_xy_e(1)); %pi

if(isempty(persistant_yaw_target))
    persistant_yaw_target = yaw_u;
end

if(action_id==2)
    persistant_yaw_target = yaw_u;
end




%if the position error is large, use yaw target for the target quaternion
if(norm(Ri_xy_e) >= Ri_e_tol)
    
    qib_int_u = eulToQuat([roll_u, pitch_u, persistant_yaw_target]);
else
    qib_int_u = qib_u;
end

%calculate the quaternion error between the current and target attitudes
qib_e = quatError(qib, qib_int_u); %expected in the form [vector; scalar]

%calculate the roll, pitch, and yaw error from this quaternion
Eul_e = quatToEul(qib_e);

%if any of the angle errors are large, don't command forward or up
if(max(abs(Eul_e)) > Eul_e_tol)
    Rb_error = [0;0;0];
    action_id = 1;
    

elseif(norm(Ri_xy_e) >= Ri_e_tol) %use only forward and up commands if we are far away the target
    %this will only be reached if the vehicle is level and pointing toward
    %the target, so no need to convert any of these to the body frame.
    %once we reach driving mode, clear the persistant yaw target
    Rb_error = [norm(Ri_xy_e); 0; Ri_u(3) - Ri(3)];
    action_id = 2;
    

else
    %allow for x, y, and z body commands
    Cib = quatToRotm(qib);
    Cbi = Cib';
    Rb_u = Cbi*Ri_u;
    Rb = Cbi*Ri;
    Rb_error = Rb_u - Rb;

    action_id = 3;
    
end

action_id_out = action_id;

end