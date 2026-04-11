function dt = roundToSimTimestep(dt_target, dt_sim)
% This function makes sure the timestep dt is a multiple of dt_sim, which
% is a requirement for discrete fixed time-step simulations.


if(dt_target < dt_sim)
    %if the target is too small, use dt sim
    dt = dt_sim;
else
    %otherwise round to a multiple of dt_sim
    dt = round((dt_target/dt_sim))*dt_sim;
end
end