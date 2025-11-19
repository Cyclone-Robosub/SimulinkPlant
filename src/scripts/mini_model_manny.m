%function draws manny and the body axis.
R = zeros(3,1);
C = eye(3);

kdrawManny(R,C)
kdrawAxis('Length',0.25,'OneSided',1,'Color','r','LineWidth',2,'FontSize',16)
ax = gca;
view(ax,3)
set(gca,'Zdir','reverse')
set(gca,'Ydir','reverse')
xlim([-.5,.5])
ylim([-.5,.5])
zlim([-.25,.25])