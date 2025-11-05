%{
Calculates the total volume of the simplified model and the approximate
location of the centroid of volume with respect to the origin of the
Onshape assembly.
%}

%dimensions
%main cylinder
rm = 6.3;
lm = 18;
Rm = [0 0 -4.53]';

%thruster cylinders
rt = 1.6;
lt = 4.6;
Rt1 = [9.95 8 -1.675]';
Rt2 = [9.95 -8 -1.675]';
Rt3 = [-9.95 8 -1.675]';
Rt4 = [-9.95 -8 -1.675]';
Rt5 = [7.03 -4.95 1.93]';
Rt6 = [7.03 -4.95 1.93]';
Rt7 = [-8.3 3.7 1.93]';
Rt8 = [-8.3 -3.7 1.93]';

%camera box
lc = 5;
wc = 5;
hc = 5;
Rc = [2 0 2.3]';

%base plate
lp = 18;
wp = 10.25;
hp = 0.25;
Rp = [0 0 0.125]';

%DVL cylinder
rd = 1.7;
ld = 1.65;
Rd = [-4 0 1.5]';

%calculate all the volumes
Vm = pi*rm^2*lm;
Vt = pi*rt^2*lt;
Vc = lc*wc*hc;
Vp = lp*wp*hp;
Vd = pi*rd^2*ld;
V = [Vm Vt Vt Vt Vt Vt Vt Vt Vc Vp Vd];

%pack of positions
R = [Rm Rt1 Rt2 Rt3 Rt4 Rt5 Rt6 Rt7 Rt8 Rc Rp Rd];

%loop through the objects and calculate the centroid
Rcv = zeros(3,1);
for k = 1:length(V)
    Rcv = Rcv + V(k)*R(:,k);
end
V_total_in = sum(V);
Rcv_in = Rcv/V_total_in;

%convert to m
Rcv_m = Rcv_in*2.54/100;
V_total_m = V_total_in*(2.54/100)^3;