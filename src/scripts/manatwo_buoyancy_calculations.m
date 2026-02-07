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
%pelican case
lp = 11.768 * in2m;
wp = 16.2 * in2m;
hp = 6.55 * in2m;
Rp = [0 0 3.275]'*in2m;

%thruster cylinders
%effective volume of the thruster cylinder is smaller than the envelope 
rt = 1.6*in2m;
lt = 4.6*in2m;
Rt1 = [-13.055 7.278 6.101]'*in2m;
Rt2 = [13.055 7.278 6.101]'*in2m;
Rt3 = [-13.055 -7.278 6.101]'*in2m;
Rt4 = [13.055 -7.278 6.101]'*in2m;
Rt5 = [-13.055 7.278 -2.601]'*in2m;
Rt6 = [13.055 7.278 -2.601]'*in2m;
Rt7 = [-13.055 -7.278 -2.601]'*in2m;
Rt8 = [13.055 -7.278 -2.601]'*in2m;

%chassis frame
wc = 22 * in2m;
lc = 24 * in2m; %average of the top and bottom half of frame
hc = 13.5 * in2m;
Rc = [0 0 0.364]'*in2m;


%calculate all the volumes
Vt = pi*rt^2*lt;
Vc = 306.938 * in2m^3; %estimated from onshape
Vp = lp*wp*hp;
Vf = lf*wf*hf;
V = [Vp Vt Vt Vt Vt Vt Vt Vt Vt Vc Vf];

%pack of positions
R_o2obj = [Rp Rt1 Rt2 Rt3 Rt4 Rt5 Rt6 Rt7 Rt8 Rc Rf];

%loop through the objects and calculate the centroid
R_o2cv = zeros(3,1);
for k = 1:length(V)
    R_o2cv = R_o2cv + V(k)*R_o2obj(:,k);
end
V_total = sum(V);
R_o2cv = R_o2cv/V_total;

