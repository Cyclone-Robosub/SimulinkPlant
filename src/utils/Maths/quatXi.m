function Xi = quatXi(q)
%Equation A.174a from Crassidis 2e
%Quaternion must be [vector; scalar]
q = q(:);
eps = q(1:3);
eta = q(4);

Xi_top = eta*eye(3) + vectorCross(eps);
Xi_bottom = -eps';

Xi = [Xi_top;Xi_bottom];
end