f = figure();

dt = 1/30;
tspan = 10;
t = 0:dt:tspan;
theta = @(t) 2*t;

ax = axes('Parent',f);
axis(ax,[-1 1 -1 1 -1 1])
axis(ax,'manual')
view(ax,3)
set(gca,'Zdir','reverse')
set(gca,'Ydir','reverse')

filename = "C:\GitHub\Cyclone Robosub\SimulinkPlant\src\temp\manny.gif";
tic
for k = 1:length(t)
    cla(f)
    R = [0.25*t(k) 0 0]';
    axis(ax,[-1+R(1) 1+R(1) -1+R(2) 1+R(2) -1+R(3) 1+R(3)])
    C = eul2rotm([theta(t(k)),theta(t(k)),theta(t(k))]);
    kdrawManny(R,C,'Figure',f)
    kdrawAxis('Figure',f)
    frame = getframe(f);
    [A,map] = rgb2ind(frame2im(frame),256);
    if k == 1
        imwrite(A,map,filename,'gif','LoopCount',inf,'DelayTime',dt);
    else
        imwrite(A,map,filename,'gif','WriteMode','append','DelayTime',dt);
    end
end
toc