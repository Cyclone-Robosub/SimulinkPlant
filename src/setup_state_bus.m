%{
The state of the system is a bus object that includes all useful physical
quantities and their various representations used in the simulation.

POSITION
Ri - position in world coords [Rix, Riy, Riz]'
Rb - position in body coords [Rbx, Rby, Rbz]'

ATTITUDE
Eul - euler angles [roll, pitch, yaw]'
qib - quaternion [vector; scalar]
Cib - rotation matrix from body to inertial
Cbi - rotation matrix from inertial to body

VELOCITY
dRi - inertial frame velocity [dRix, dRiy, dRiz]'
dRb - body frame velocity [dRbx, dRby, dRbz]'

ANGULAR VELOCITY 
wb - angular velocity of the body expressed in the body frame 
[wbx, wby, wbz]' 
wi - angular velocity of the body expressed in the
inertial frame [wix, wiy, wiz]

ACCELERATION
ddRi - inertial frame acceleration [ddRix, ddRiy, ddRiz]'
ddRb - body frame acceleration [ddRbx, ddRby, ddRbz]'

%}

%% Elements
%create a Simulink with matching elements
Ri = Simulink.BusElement;
Ri.Name = 'Ri';
Ri.DataType = 'double';
Ri.Dimensions = [3,1];

Rb = Simulink.BusElement;
Rb.Name = 'Rb';
Rb.DataType = 'double';
Rb.Dimensions = [3,1];

Eul = Simulink.BusElement;
Eul.Name = 'Eul';
Eul.DataType = 'double';
Eul.Dimensions = [3,1];

qib = Simulink.BusElement;
qib.Name = 'qib';
qib.DataType = 'double';
qib.Dimensions = [4,1];

Cib = Simulink.BusElement;
Cib.Name = 'Cib';
Cib.DataType = 'double';
Cib.Dimensions = [3,3];

Cbi = Simulink.BusElement;
Cbi.Name = 'Cbi';
Cbi.DataType = 'double';
Cbi.Dimensions = [3,3];

dRi = Simulink.BusElement;
dRi.Name = 'dRi';
dRi.DataType = 'double';
dRi.Dimensions = [3,1];

dRb = Simulink.BusElement;
dRb.Name = 'dRb';
dRb.DataType = 'double';
dRb.Dimensions = [3,1];

wb = Simulink.BusElement;
wb.Name = 'wb';
wb.DataType = 'double';
wb.Dimensions = [3,1];

wi = Simulink.BusElement;
wi.Name = 'wi';
wi.DataType = 'double';
wi.Dimensions = [3,1];

ddRi = Simulink.BusElement;
ddRi.Name = 'ddRi';
ddRi.DataType = 'double';
ddRi.Dimensions = [3,1];

ddRb = Simulink.BusElement;
ddRb.Name = 'ddRb';
ddRb.DataType = 'double';
ddRb.Dimensions = [3,1];

X_bus = Simulink.Bus;

X_bus.Elements = [Ri, Rb, Eul, qib, Cib, Cbi, dRi, dRb, wb, wi, ddRi, ddRb];

