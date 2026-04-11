function Fb_cmd = linearVelocityController(dRb_u, X, K_drB)
%{
This function applies a simple proportional controller for body frame
velocity.

In the future, this function may be adjusted to import dRb_meas from the
DVL directly instead of the state vector, which requires use of attitude
knowledge to calcularte dRb from dRi and qib. 

%}

%calculate dRb
qib = X(7:10); %[qscalar; qvector]
Cib = quat2rotm(qib');
Cbi = inv(Cib);
dRi = X(4:6);
dRb = Cbi*dRi;

%calculate the force command
Fb_cmd = K_dRb*(dRb_u - dRb);


end