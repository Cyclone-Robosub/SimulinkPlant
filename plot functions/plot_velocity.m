function plot_velocity(results)
%unpack input signal
figure
v_e_hat = squeeze(results.v_e_hat.Data);
v_e_des = zeros(size(v_e_hat));

subplot(3,1,1)
plot(results.v_e.Time,results.v_e.Data(:,1),'color','b')
title("Inertial Vx (North)")
xlabel("Time (s)")
ylabel("Velocity (m/s)")
hold on
plot(results.v_e_hat.Time,v_e_hat(1,:),'color','r')
plot(results.v_e_hat.Time,v_e_des(1,:),'color','g')
legend("True","Estimated","Desired")
subplot(3,1,2)
plot(results.v_e.Time,results.v_e.Data(:,2),'color','b')
xlabel("Time (s)")
ylabel("Velocity (m/s)")
hold on
plot(results.v_e_hat.Time,v_e_hat(2,:),'color','r')
plot(results.v_e_hat.Time,v_e_des(2,:),'color','g')
title("Inertial Vy (East)")
subplot(3,1,3)
plot(results.v_e.Time,results.v_e.Data(:,3),'color','b')
xlabel("Time (s)")
ylabel("Velocity (m/s)")
hold on
plot(results.v_e_hat.Time,v_e_hat(3,:),'color','r')
plot(results.v_e_hat.Time,v_e_des(3,:),'color','g')
title("Inertial Vz (Down)")
end

