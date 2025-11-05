function J = pat(I,R_new_point_to_body,m)
%we need the vector from the body to the new point
R = -R_new_point_to_body;

%calculate J
J = I + m*((dot(R,R)*eye(3) - outer(R,R)));
end