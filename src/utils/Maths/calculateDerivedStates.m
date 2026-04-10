function [Ri,Rb,dRi,dRb,Cbi,Cib,qib,Eul,w] = calculateDerivedStates(Ri,dRi,qib,w)
%{
This function calculates all the necessary derived state variables from the
propagated state vector.
%}

Cib = quatToRotm(qib);
Cbi = Cib';
Eul = quatToEul(qib);
Rb = Cbi*Ri;
dRb = Cbi*dRi;
end