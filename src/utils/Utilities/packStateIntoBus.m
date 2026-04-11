function X = packStateIntoBus(Ri, qib, dRi, wb, ddRi)
Eul = quatToEul(qib);
Cib = quatToRotm(qib);
Cbi = Cib';

X.Ri = Ri;
X.Rb = Cbi*Ri;
X.Eul = Eul;
X.qib = qib;
X.Cib = Cib;
X.Cbi = Cbi;
X.dRi = dRi;
X.dRb = Cbi*dRi;
X.wb = wb;
X.wi = Cib*wb;
X.ddRi = ddRi;
X.ddRb = Cbi*ddRi;

end