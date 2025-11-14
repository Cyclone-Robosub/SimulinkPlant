function dw = angularAccelerationFromEulerRates(w,Eul,ddEul)
%{
This function calculates the angular acceleration (i.e. dw/dt) given the
angular velocity, the Euler angles, and the second derivative of the Euler
angles. It also needs the derivative of Euler angles, which are calculated
in the angularVelocityToEulerRates function call.

The idea here is that a PID controller inputting roll, pitch, and yaw error
will output a control signal that we want to treat as torque. If we put the
raw output of the PID into the thrusters as a torque command the main
concern is that this formulation does not take into account the constraint
between angular velocity and Euler angles. 

To attempt to rectify this, the output from the PID is input to this
function as if it was just a constant times ddEul, and the output dw will
be treated as a constant times dw (aka a torque) that can be fed to the
thrusters.

This math is a little bit shady and I haven't yet found a source backing up
this approach, but we'll see how it goes.
%}

%calculate the euler rates
dEul = angularVelocityToEulerRates(w,Eul);

%unpack
a = Eul(1);
b = Eul(2);
c = Eul(3);
da = dEul(1); %roll rate
db = dEul(2); %pitch rate
dc = dEul(3); %yaw rate

dda = ddEul(1); %roll PID ctrl
ddb = ddEul(2); %pitch PID ctrl
ddc = ddEul(3); %yaw PID ctrl

%precompute sines and cosines
sa = sin(a);
sb  = sin(b);
ca = cos(a);
cb = cos(b);
%calculate dw components
%I don't have a source for these, I just calculated them
dp = dda - ddc*sb - dc*db*cb;
dq = ddb*ca + ddc*cb*sa - sa*da*db + ca*cb*da*dc - sa*sb*db*da;
dr = ddc*ca*cb - ddb*sa - ca*da*db - cb*sa*da*db - ca*sb*db*dc;

dw = [dp; dq; dr];