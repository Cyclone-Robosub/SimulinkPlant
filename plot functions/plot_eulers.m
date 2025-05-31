function plot_eulers(results)

t = results.E.Time; %N x 1
E = squeeze(results.E.Data); %N x 3
E = E';
E_desired = results.desired_states.Data(:,4:6); 
E_hat = squeeze(results.E_hat.Data);
E_hat = E_hat';


figure
subplot(3,1,1)
plot(t,E(:,1),'Linestyle','-.','marker','none','Color','b')
hold on
plot(t,E_hat(:,1),'Color','r','LineStyle','--')
plot(t,E_desired(:,1),'Color','g','LineStyle',':')
legend("True","Estimated","Desired")
title("Roll")
xlabel("Time (s)")
ylabel("Angle (rad)")
subplot(3,1,2)
plot(t,E(:,2),'Linestyle','-.','marker','none','Color','b')
hold on
plot(t,E_hat(:,2),'Color','r','LineStyle','--')
plot(t,E_desired(:,2),'Color','g','LineStyle',':')
legend("True","Estimated","Desired")
title("Pitch")
xlabel("Time (s)")
ylabel("Angle (rad)")
subplot(3,1,3)
plot(t,E(:,3),'Linestyle','-.','marker','none','Color','b')
hold on
plot(t,E_hat(:,3),'Color','r','LineStyle','--')
plot(t,E_desired(:,3),'Color','g','LineStyle',':')
legend("True","Estimated","Desired")
title("Yaw")
xlabel("Time (s)")
ylabel("Angle (rad)")
end

