function X_est = derivedStateEstimates(qib_est, wb_meas, Rb_est, dRb_est, ddRb_meas)

%attitude representations
Cib = quatToRotm(qib_est);
Cbi = Cib';
Eul = quatToEul(qib_est);


%rotated states
Ri = Cib*Rb_est;
dRi = Cib*dRb_est;
ddRi = Cib*ddRb_meas;
wi = Cib*wb_meas;

%pack into bus (matches setup_X_bus.m, order matters)
X_est.Ri = Ri;
X_est.Rb = Rb_est;
X_est.Eul = Eul;
X_est.qib = qib_est;
X_est.Cib = Cib;
X_est.Cbi = Cbi;
X_est.dRi = dRi;
X_est.dRb = dRb_est;
X_est.wb = wb_meas;
X_est.wi = wi;
X_est.ddRi = ddRi;
X_est.ddRb = ddRb_meas;