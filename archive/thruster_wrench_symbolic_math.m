%{
This script is a demonstration of the equality of the force_wrench and
moment_wrench constructions used in the model with the simple summation of
forces and moments on the body.

The benefit of using the wrench formulation is the existence of the
pseudoinverse operation to compute the individual thruster commands from a
generic body force command.
%}

%define symbolic variables
syms fT1 fT2 fT3 fT4 fT5 fT6 fT7 fT8 real %thruster magnitudes
syms RT1x RT1y RT1z RT2x RT2y RT2z RT3x RT3y RT3z RT4x RT4y RT4z...
    RT5x RT5y RT5z RT6x RT6y RT6z RT7x RT7y RT7z RT8x RT8y RT8z real %thruster position components
syms NT1x NT1y NT1z NT2x NT2y NT2z NT3x NT3y NT3z NT4x NT4y NT4z...
    NT5x NT5y NT5z NT6x NT6y NT6z NT7x NT7y NT7z NT8x NT8y NT8z real %thruster direction components

%define lists
fT_list = [fT1 fT2 fT3 fT4 fT5 fT6 fT7 fT8]';
RT_list = [RT1x RT2x RT3x RT4x RT5x RT6x RT7x RT8x;...
           RT1y RT2y RT3y RT4y RT5y RT6y RT7y RT8y;...
           RT1z RT2z RT3z RT4z RT5z RT6z RT7z RT8z];
NT_list = [NT1x NT2x NT3x NT4x NT5x NT6x NT7x NT8x;...
           NT1y NT2y NT3y NT4y NT5y NT6y NT7y NT8y;...
           NT1z NT2z NT3z NT4z NT5z NT6z NT7z NT8z];

%calculate force and moments manually
FT_manual = sym(zeros(3,1));
MT_manual = sym(zeros(3,1));
for k = 1:8
    FT_manual = FT_manual + NT_list(:,k)*fT_list(k);
    MT_manual = MT_manual + cross(RT_list(:,k),NT_list(:,k))*fT_list(k);
end

%define wrenches
force_wrench = NT_list;
moment_wrench = sym(zeros(3,8));
for k = 1:8
    moment_wrench(:,k) = cross(RT_list(:,k),NT_list(:,k));
end

%calculate force and moments using wrenches
FT_wrench = force_wrench*fT_list;
MT_wrench = moment_wrench*fT_list;

%verify equality between methods
isAlways(simplify(FT_manual)==simplify(FT_wrench))
isAlways(simplify(MT_manual)==simplify(MT_wrench))