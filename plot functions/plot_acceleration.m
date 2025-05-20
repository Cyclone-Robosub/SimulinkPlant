function plot_acceleration(results)
%unpack input signal
figure
A_b_meas = squeeze(results.A_b_meas.Data)';
Abe_b = squeeze(results.A_be_b.Data);
Abe_e_meas = squeeze(results.a_e_meas.Data);

subplot(3,1,1)
plot(results.A_be_b.Time,Abe_b(:,1),'color','b')
title("Inertial Ax (North)")
xlabel("Time (s)")
ylabel("Acceleration (m/s^2)")
hold on
plot(results.A_b_meas.Time,A_b_meas(:,1),'color','r')
plot(results.a_e_meas.Time,Abe_e_meas(1,:),'color','cyan')
legend("True in Inertial","Measured in Body", "Measured Converted in Inertial")
subplot(3,1,2)
plot(results.A_be_b.Time,Abe_b(:,2),'color','b')
xlabel("Time (s)")
ylabel("Acceleration (m/s^2)")
hold on
plot(results.A_b_meas.Time,A_b_meas(:,2),'color','r')
plot(results.a_e_meas.Time,Abe_e_meas(2,:),'color','cyan')
title("Inertial Ay (East)")
subplot(3,1,3)
plot(results.A_be_b.Time,Abe_b(:,3),'color','b')
xlabel("Time (s)")
ylabel("Acceleration (m/s^2)")
hold on
plot(results.A_b_meas.Time,A_b_meas(:,3),'color','r')
plot(results.a_e_meas.Time,Abe_e_meas(3,:),'color','cyan')
title("Inertial Az (Down)")
end

