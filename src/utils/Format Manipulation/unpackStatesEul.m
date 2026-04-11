function [R,Eul,dR,w] = unpackStatesEul(X)
%enforce column
X = X(:);

R = X(1:3);
q = X(4:7);
dR = X(8:10);
w = X(11:13);

Eul = quatToEul(q);
end