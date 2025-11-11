function [Fb_drag, Mb_drag] = drag(dRb, W, drag_wrench, do_drag_flag)
%{
@dRb - the velocity vector in body coordinates
@W - the angular velocity vector in body coordinates

@Fb_drag - the force due to drag
@Mb_drag - the moment due to the drag
%}

VW2=[dRb.*abs(dRb);W.*abs(W)];

result=-drag_wrench*VW2;

Fb_drag=result(0:3);
Mb_drag=result(3:6);

if(do_drag_flag==0)
    Fb_drag=[0;0;0];
    Mb_drag=[0;0;0];
end