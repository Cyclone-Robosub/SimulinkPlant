function [Fb_drag, Mb_drag] = drag_lin(dRb, w, drag_wrench, do_drag_flag)
%{
@dRb - the velocity vector in body coordinates
@W - the angular velocity vector in body coordinates

@Fb_drag - the force due to drag
@Mb_drag - the moment due to the drag
%}


VW2=[dRb.*abs(dRb);w];

result=-drag_wrench*VW2;

Fb_drag=result(1:3);
Mb_drag=result(4:6);

if(~do_drag_flag)
    Fb_drag=[0;0;0];
    Mb_drag=[0;0;0];
end