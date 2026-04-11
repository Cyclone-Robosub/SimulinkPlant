function J = pat(I,R_obj2newpoint,m)

%calculate J
J = I + m*((dot(R_obj2newpoint,R_obj2newpoint)*eye(3) - R_obj2newpoint*R_obj2newpoint'));
end