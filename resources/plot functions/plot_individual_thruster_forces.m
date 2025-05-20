function plot_individual_thruster_forces(results)

t_cmd = squeeze(results.thruster_cmd.Time); %nx1
t_del = squeeze(results.thruster_delivered.Time); %nx1
F_cmd = squeeze(results.thruster_cmd.Data); %nx8
F_del = squeeze(results.thruster_delivered.Data)'; %nx8

figure
subplot(4,2,1)
plot(t_cmd,F_cmd(:,1))
hold on
plot(t_del,F_del(:,1))
legend("Commanded","Delivered")
title("Thruster 0")

subplot(4,2,2)
plot(t_cmd,F_cmd(:,2))
hold on
plot(t_del,F_del(:,2))
title("Thruster 1")

subplot(4,2,3)
plot(t_cmd,F_cmd(:,3))
hold on
plot(t_del,F_del(:,3))
title("Thruster 2")

subplot(4,2,4)
plot(t_cmd,F_cmd(:,4))
hold on
plot(t_del,F_del(:,4))
title("Thruster 3")

subplot(4,2,5)
plot(t_cmd,F_cmd(:,5))
hold on
plot(t_del,F_del(:,5))
title("Thruster 4")

subplot(4,2,6)
plot(t_cmd,F_cmd(:,6))
hold on
plot(t_del,F_del(:,6))
title("Thruster 5")

subplot(4,2,7)
plot(t_cmd,F_cmd(:,7))
hold on
plot(t_del,F_del(:,7))
title("Thruster 6")

subplot(4,2,8)
plot(t_cmd,F_cmd(:,8))
hold on
plot(t_del,F_del(:,8))
title("Thruster 7")

end

