function qib = rotmToQuat(rotm)
%{
Inputs:
rotm - The 3x3 rotation matrix from the body to the inertial frame.

Outputs:
qib - [eps; eta] where eps is the 3x1 quaternion vector and eta is the 
quaternion scalar. The quaternion corresponding with the rotation matrix 
from the body frame to the inertia frame.

Reference: 
De Ruiter - Spacecraft Dynamics and Control, Chapter 1
%}

C = rotm;

%scalar component (De Ruiter Eqn 1.35)
eta = sqrt(trace(C)+1)/2;

%vector component
eps = zeros(3,1);
if(eta ~= 0)
    eps(1) = (C(2,3) - C(3,2))/(4*eta); %De Ruiter Eqn 1.37
    eps(2) = (C(3,1) - C(1,3))/(4*eta);
    eps(3) = (C(1,2) - C(2,1))/(4*eta);
else %eta = 0 case
    abs_eps1 = sqrt((C(1,1) + 1)/2);
    abs_eps2 = sqrt((C(2,2) + 1)/2);
    abs_eps3 = sqrt((C(3,3) + 1)/2);

    if(abs_eps1 > 0)
        eps(1) = abs_eps1;
        eps(2) = sign(C(1,2))*abs_eps2;
        eps(3) = sign(C(1,3))*abs_eps3;
    elseif(abs_eps2 > 0)
        eps(1) = sign(C(1,2))*abs_eps1;
        eps(2) = abs_eps2;
        eps(3) = sign(C(2,3))*abs_eps3;
    else
        eps(1) = sign(C(1,2))*abs_eps1;
        eps(2) = sign(C(2,3))*abs_eps2;
        eps(3) = abs_eps3;
    end
end

qib = [eps;eta];
qib = quatNormalization(qib);


end
