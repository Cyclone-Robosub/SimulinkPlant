% close all plots
close all
clc
clear all

% run constants.m
run("constants.m");
run("calculate_wrench.m");
run("calculate_inertia.m")

% run simulation
%run('PID_LOOP_2024a.slx')

% unpack data

% for each simulation run create plots

    % position vs time
    % euler angle vs time
    % velocity vs time
    % angular velocity vs time
    % force vector vs time
    % thrust vector vs time
    % PID error vs time
    % thruster duty cycle vs time

% call animation function

