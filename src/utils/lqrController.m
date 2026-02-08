function U = lqrController(X_lqr_error, Uref, K)
%{
Calculates the control input from the X_lqr_error and the lqr gain.

X_lqr_error = [x-xr, y-yr, z-zr, dx-dxr, dy-dyr, dz-dzr, roll-rollr,
pitch-pitchr, yaw-yawr, wx-wxr, wy-wyr, wz-wzr]

%}


U = Uref - K*X_lqr_error;

end