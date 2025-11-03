function plot_position(results)
%plots true position (x), estimated position (x_hat), and desired position
%(x_des)
x_e_hat = squeeze(results.x_e_hat.Data);
%unpack input signal
figure
subplot(3,1,1)
plot(results.x_e.Time,results.x_e.Data(:,1),'color','b')
title("Inertial X (North)")
xlabel("Time (s)")
ylabel("Position (m)")
hold on
plot(results.x_e_hat.Time,x_e_hat(1,:),'color','r')
plot(results.desired_states.Time,results.desired_states.Data(:,1),'color','g')
legend("True","Estimated","Desired")
subplot(3,1,2)
plot(results.x_e.Time,results.x_e.Data(:,2),'color','b')
xlabel("Time (s)")
ylabel("Position (m)")
hold on
plot(results.x_e_hat.Time,x_e_hat(2,:),'color','r')
plot(results.desired_states.Time,results.desired_states.Data(:,2),'color','g')
title("Inertial Y (East)")
subplot(3,1,3)
plot(results.x_e.Time,results.x_e.Data(:,3),'color','b')
xlabel("Time (s)")
ylabel("Position (m)")
hold on
plot(results.x_e_hat.Time,x_e_hat(3,:),'color','r')
plot(results.desired_states.Time,results.desired_states.Data(:,3),'color','g')
title("Inertial Z (Down)")
end

