function dEul = angularVelocityToEulerRates(w,Eul)
%{
This function impliments Eqn 1.59 from De Ruiter Spacecraft Dynamics and
Control in order to calculate the time derivative of the Euler angles given
angular velocity and the Euler angles.

TODO - add protection in the case that the pitch is +/- pi/2
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

%assemble matrix
invT = [1 sa*tb ca*tb;
        0 ca -sa;
        0 sa*seb ca*seb];

%calculate the Euler rates
dEul = invT*w;
end