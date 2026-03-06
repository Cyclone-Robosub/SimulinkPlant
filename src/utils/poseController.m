function [dRb_u,qib_int_u] = poseController(X,Xu,K_zi,K_xb,level_tol, point_tol, far_tol)
%{
The poseController inputs the target state and the (estimated) current
state and outputs a target attitude and velocity. The controller chooses a
vertical velocity to match the elevation of the target state and generates
an intermediate quaternion target to yaw the nose in the direction of the
target while targeting zero pitch and roll. 

If the vehicle is far from the target state, only vertical velocity and
yaw commands are applied. Once the yaw-error is small, a forward velocity
will be commanded as well. 

If the vehicle is close to the target waypoint, the user set attitude
target is maintained and the velocity target is zeroed.

%TODO Unit tests

%}

%unpack the relevant target states
Ri_u = Xu(1:3); %waypoint position in the inertial frame
qib_u = Xu(7:10); %waypoint attitude [qscalar; qvector]

%unpack the relevant current states
Ri = X(1:3); %current position in the intertial frame
qib = X(7:10); %current attitude [qscalar; qvector]

%proportional control of the altitude (only if the vehicle is level)
if(isLevel(qib,level_tol))
    zi_u = Ri_u(3);
    zi = Ri(3);
    dzi_u = K_zi*(zi_u - zi); %K_zi > 0
else
    dzi_u = 0;
end

%Use inertial velocity target for body vertical velocity
dzb_u = dzi_u;

%drive forward (only if the vehicle is pointed and far from the target)
if(isPointed(qib,qib_u,point_tol) && isFar(Ri,Ri_u,far_tol))
    xi_error = Ri(1) - Ri_u(1);
    yi_error = Ri(2) - Ri_u(2);
    xy_error = sqrt(xi_error^2 + yi_error^2);
    
    %forward velocity target (always positive)
    dxb_u = K_xb*(xy_error); %K_xb > 0
else
    dxb_u = 0;
end

%do not attempt to translate in the body y-direction
dyb_u = 0;

%pack velocity target
dRb_u = [dxb_u; dyb_u; dzb_u];

%if far away, pass intermediate quaternion for pointing
if(isFar(Ri,Ri_u,far_tol))
    qib_int_u = pointingQuatTarget(Ri_u, Ri);
else
    %if close, pass user defined target quaternion
    qib_int_u = qib_u;
end

%helper functions

function qib_int_u = pointingQuatTarget(Ri_u, Ri)
    %{
    Calculates the required attitude to point at the target position.

    %%TODO
    Break out to a util function and add unit tests.
    %}

    %target a pitch and roll of zero to remain level
    pitch_u = 0;
    roll_u = 0;

    %compute the vector from the current position to the target
    Ri_error = Ri_u - Ri;

    %calculate the yaw target
    yaw_u = atan2(Ri_error(2),Ri_error(1));

    %convert to quaternion
    eul = [yaw_u pitch_u roll_u];
    qib_int_u = eul2quat(eul,'ZYX');
end

function tf = isLevel(qib,level_tol)
    %Unpack the roll and pitch from the quaternion
    eul = quat2eul(qib,'ZYX'); %outputs as [yaw pitch roll]
    pitch = eul(2);
    roll = eul(3);

    if(abs(pitch) > level_tol)
        tf = false;
    elseif(abs(roll) > level_tol)
        tf = false;
    else
        tf = true;
    end
end

function tf = isPointed(qib,qib_u,point_tol)
    %Unpack the yaw from the quaternion and quaternion target
    eul_u = quat2eul(qib_u,'ZYX');
    eul = quat2eul(qib,'ZYX');

    yaw_error = abs(wrapToPi(eul(1) - eul_u(1)));
    if(yaw_error < point_tol)
        tf = true;
    else
        tf = false;
    end
end

function tf = isFar(Ri, Ri_u, far_tol)
    %Unpack and x and y
    xi = Ri(1);
    xi_u = Ri_u(1);
    yi = Ri(2);
    yi_u = Ri_u(2);

    %Calculate the straight line distance
    d = sqrt((xi-xi_u)^2 + (yi-yi_u)^2);

    if(d>far_tol)
        tf = true;
    else
        tf = false;
    end

end

end

