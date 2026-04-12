%settings

%ramp settings
start = 1600;
stop = 1700;
Tmax = 3;
mask = [1 0 0 0 0 0 0 0]';

tspan = 3;
dt_control = 0.01;

sim('Pi_Noise_Test.slx');

