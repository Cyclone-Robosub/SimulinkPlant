function plot_forces_and_torques(results)

t_cmd = squeeze(results.force_torque_cmd.Time); %nx1
t_del = squeeze(results.force_torque_delivered.Time); %nx1
F_cmd = squeeze(results.force_torque_cmd.Data)'; %nx6
F_del = squeeze(results.force_torque_delivered.Data)'; %nx6

figure
subplot(3,2,1)
plot(t_cmd,F_cmd(:,1))
hold on
plot(t_del,F_del(:,1))
legend("Commanded","Delivered")
title("Force X")

subplot(3,2,2)
plot(t_cmd,F_cmd(:,2))
hold on
plot(t_del,F_del(:,2))
title("Force Y")

subplot(3,2,3)
plot(t_cmd,F_cmd(:,3))
hold on
plot(t_del,F_del(:,3))
title("Force Z")

subplot(3,2,4)
plot(t_cmd,F_cmd(:,4))
hold on
plot(t_del,F_del(:,4))
title("Roll Torque")

subplot(3,2,5)
plot(t_cmd,F_cmd(:,5))
hold on
plot(t_del,F_del(:,5))
title("Pitch Torque")

subplot(3,2,6)
plot(t_cmd,F_cmd(:,6))
hold on
plot(t_del,F_del(:,6))
title("Yaw Torque")



end

