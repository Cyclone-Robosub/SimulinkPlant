%define conversion factor from in to m
in2m = 2.54/100;

%Ficticous volume for tuning, basically air-filled balast
lf = 0.1417;
wf = 0.1417;
hf = 0.1417;
Rf = [-1.2 0 0]'*in2m;


%{
Calculates the total volume of the simplified model and the approximate
location of the centroid of volume with respect to the origin of the
Onshape assembly.
%}



%dimensions
%main cylinder
rm = 3.15*in2m;
lm = 18*in2m;
Rm = [0 0 -4.53]'*in2m;

%thruster cylinders
%effective volume of the thruster cylinder is smaller than the envelope 
rt = 1.6*in2m;
lt = 4.6*in2m;
Rt1 = [9.95 -8 -1.675]'*in2m;
Rt2 = [9.95 8 -1.675]'*in2m;
Rt3 = [-9.95 -8 -1.675]'*in2m;
Rt4 = [-9.95 8 -1.675]'*in2m;
Rt5 = [7.03 -4.95 1.93]'*in2m;
Rt6 = [7.03 4.95 1.93]'*in2m;
Rt7 = [-8.3 -3.7 1.93]'*in2m;
Rt8 = [-8.3 3.7 1.93]'*in2m;


%camera box
lc = 5*in2m;
wc = 5*in2m;
hc = 5*in2m;
Rc = [2 0 2.3]'*in2m;

%base plate
lp = 18*in2m;
wp = 10.25*in2m;
hp = 0.25*in2m;
Rp = [0 0 0.125]'*in2m;

%DVL cylinder
rd = 1.7*in2m;
ld = 1.65*in2m;
Rd = [-4 0 1.5]'*in2m;



%calculate all the volumes
Vm = pi*rm^2*lm;
Vt = pi*rt^2*lt;
Vt = 0; %test to fix buoyancy math
Vc = lc*wc*hc;
Vp = lp*wp*hp;
Vd = pi*rd^2*ld;
Vf = lf*wf*hf;
V = [Vm Vt Vt Vt Vt Vt Vt Vt Vt Vc Vp Vd Vf];

%pack of positions
R_o2obj = [Rm Rt1 Rt2 Rt3 Rt4 Rt5 Rt6 Rt7 Rt8 Rc Rp Rd Rf];

%loop through the objects and calculate the centroid
R_o2cv = zeros(3,1);
for k = 1:length(V)
    R_o2cv = R_o2cv + V(k)*R_o2obj(:,k);
end
V_total = sum(V);
R_o2cv = R_o2cv/V_total;

