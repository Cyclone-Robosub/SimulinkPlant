clc
close all
clear all

%load exact data
pwm = load("pwm.mat").pwm;
force1 = load("forces.mat").forces;
voltage = load("voltage.mat").voltage;


hold on
plot(pwm,force1(:,3));
xlabel("PWM")
ylabel("Force (N)")
title("Force Fit Comparison")

%calculate old fit data
force2 = oldPWMToForce(pwm);

%plot(pwm,force2);

%calculate new fit data
force3 = PWMToForce(pwm,14);
plot(pwm,force3,'Color','k','LineStyle','--');