function dEul = angularVelocityToEulerRates(w,Eul)
%{
This function impliments Eqn 1.59 from De Ruiter Spacecraft Dynamics and
Control in order to calculate the time derivative of the Euler angles given
angular velocity and the Euler angles.

INPUTS
w = [3x1] angular velocity in body coordinates (rad/s)
Eul = [3x1] Euler angles corresponding to a ZYX rotation from the body to
the inertial frame in the order [roll,pitch,yaw] (rad)
%}

%enforce column vector inputs
w = w(:); %[p q r]'

%unpack Euls
a = Eul(1); %roll
b = Eul(2); %pitch

%precompute signs and cosines
sa = sin(a);
tb = tan(b);
ca = cos(a);
seb = sec(b);

%avoid numerical instability due to very large sec or tan values
if(seb > 1e3)
    seb = 1e3;
end
if(tb > 1e3)
    tb = 1e3;
end

%assemble matrix
invT = [1 sa*tb ca*tb;
        0 ca -sa;
        0 sa*seb ca*seb];

%calculate the Euler rates
dEul = invT*w;
end