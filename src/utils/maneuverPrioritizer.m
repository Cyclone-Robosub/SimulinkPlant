function [R_error_p,Eul_error_p,flags] = maneuverPrioritizer( ...
    R_error,Eul_error,dRi,w, ...
    roll_tol,pitch_tol,yaw_tol,w_tol)


roll_ok  = abs(Eul_error(1)) <= roll_tol;
pitch_ok = abs(Eul_error(2)) <= pitch_tol;
yaw_ok   = abs(Eul_error(3)) <= yaw_tol;
w_ok     = norm(w) <= w_tol;

% priority logic
do_roll = 1;
do_pitch = 1;
do_yaw = 1;

if ~roll_ok || ~pitch_ok|| ~yaw_ok || ~w_ok
    do_pos = 0;
else
    do_pos = 1;
end

flags = [do_roll do_pitch do_yaw do_pos];

% prioritized
R_error_p = zeros(3,1);
Eul_error_p = zeros(3,1);

%always do pitch and roll
Eul_error_p(1:2) = Eul_error(1:2);

if do_yaw %add back in yaw
    Eul_error_p(3) = Eul_error(3);
end

if do_pos
    R_error_p = R_error;
end

R_error_p(3) = R_error(3);

