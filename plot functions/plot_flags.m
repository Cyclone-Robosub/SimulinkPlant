function plot_flags(results)
flags = results.flags.Data;
roll_flag = flags(:,1);
pitch_flag = flags(:,2);
yaw_flag = flags(:,3);
t = results.flags.Time;

figure
subplot(3,1,1)
plot(t,roll_flag)
xlabel("Time (s)")
ylabel("Flag")
title("Roll Flag")
subplot(3,1,2)
plot(t,pitch_flag)
xlabel("Time (s)")
ylabel("Flag")
title("Pitch Flag")
subplot(3,1,3)
plot(t,yaw_flag)
xlabel("Time (s)")
ylabel("Flag")
title("Yaw Flag")
end

