%quick script to make interpolant for mapping force to pwm or pwm to force
forces = load("forces.mat").forces;
pwm = load("pwm.mat").pwm;
voltage = load("voltage.mat").voltage;

interp_function_ForceToPWM = griddedInterpolant(force_grid,voltage_grid,pwm_grid);