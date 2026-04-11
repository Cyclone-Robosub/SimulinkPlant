function wb_u = quatPID(q, qu, q_proportional, q_integral, q_derivative)
%{
This function impliments equation 16 and 18 from Quaternion-Based Control
Architecture for Determining Controllability/Maneuverability Limits by B.
J. Bacon at NASA Langely Research Center.

Inputs:
q - [eps; eta] where eps is the 3x1 quaternion vector and eta is the 
quaternion scalar. The quaternion corresponding with the rotation matrix 
from the body frame to the inertial frame.
qu - [eps_u, eta_u]. The quaternion corresponding with the rotation matrix
from the target frame to the inertial frame.
q_proportional - The proportional term Kp*deltaQuatError
q_integral - The integral term Ki*deltaQuatError
q_derivative - The derivative Kd*deltaQuatError

PID terms calculated using deltaQuatError in the form [scalar; vector] so
no more re-orientation is necessary for them!

Outputs: 
wb_u - The angular velocity command.
%}

% Calculate the quaternion error
qe = quatError(q, qu);

% Calculate Qe1 and Qe2 (both use [vector; scalar])
Qe1 = calcQ1(qe);
Qe2 = calcQ2(qe);

% Calculate dqe_des (result will be in [scalar; vector])
dqe_des = Qe1*Qe1'*(q_proportional + q_integral + q_derivative); %Eqn 18

% Calculate the angular velocity command for a constant qu
wb_u = -Qe2'*(2*dqe_des); %Eqn 16

end
