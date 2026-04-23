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
else % eta = 0 case
    % Find which component is largest to use as sign reference
    diag_vals = [(C(1,1)+1)/2, (C(2,2)+1)/2, (C(3,3)+1)/2];
    [~, idx] = max(diag_vals);
    
    abs_eps1 = sqrt(max(0, (C(1,1)+1)/2));
    abs_eps2 = sqrt(max(0, (C(2,2)+1)/2));
    abs_eps3 = sqrt(max(0, (C(3,3)+1)/2));
    
    % Note: C(i,j) = 2*eps(i)*eps(j) when eta=0
    % Use largest component as reference to avoid sign(0) issues
    if idx == 1
        eps(1) = abs_eps1;
        eps(2) = sign(C(1,2)) * abs_eps2;  % sign(eps1*eps2), eps1>0 so = sign(eps2)
        eps(3) = sign(C(1,3)) * abs_eps3;
    elseif idx == 2
        eps(2) = abs_eps2;
        eps(1) = sign(C(1,2)) * abs_eps1;
        eps(3) = sign(C(2,3)) * abs_eps3;
    else
        eps(3) = abs_eps3;
        eps(1) = sign(C(1,3)) * abs_eps1;
        eps(2) = sign(C(2,3)) * abs_eps2;
    end
end

qib = [eps;eta];
qib = quatNormalization(qib);


end
