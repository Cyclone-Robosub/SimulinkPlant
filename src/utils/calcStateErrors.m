function [R_error,Eul_error] = calcStateErrors(X_target,X)
%{
This function unpacks the state vector and target state vector and returns
the error in position and attitude.

X_target is a column vectors of [Ri_target; Eul_target] while X is a column
vector of [Ri; q; dRi; w];
%}
%enforce column
X_target = X_target(:);
X = X(:);

%unpack
Ri_target = X_target(1:3);
Eul_target = X_target(4:6);

Ri = X(1:3);
qib = X(4:7);

%convert quaternion qib to Euler angles
Eul = quatToEul(qib); 
Eul = Eul(:);

%calculate errors
R_error = Ri_target - Ri;


%compute Euler errors, making sure to flip errors to the right quadrant to
%make sure the direction is correct (i.e. controller takes shorter of 2
%paths)
Eul_error = zeros(3,1);

%roll error
choices = [Eul_target(1)-Eul(1); Eul_target(1)+2*pi-Eul(1); Eul_target(1) - 2*pi-Eul(1)];
[~,index] = min(abs(choices));
Eul_error(1) = choices(index);

%yaw error (same calculation as with roll)
choices = [Eul_target(3)-Eul(3); Eul_target(3)+2*pi-Eul(3); Eul_target(3) - 2*pi-Eul(3)];
[~,index] = min(abs(choices));
Eul_error(3) = choices(index);

%pitch error
Eul_error(2) = Eul_target(2)-Eul(2);

%enforce column
Eul_error = Eul_error(:);
end