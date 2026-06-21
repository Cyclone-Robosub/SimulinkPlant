%{
Sensor bus for the dvl data used in the sensor model.
%}

dvl_bus = Simulink.Bus;

el = Simulink.BusElement;
el.Name = 'dRb_dvl';
el.Dimensions = [3 1];
dvl_bus.Elements(end+1) = el;

el = Simulink.BusElement;
el.Name = 'alt_dvl';
el.Dimensions = [1 1];
dvl_bus.Elements(end+1) = el;

el = Simulink.BusElement;
el.Name = 'dRb_cov_dvl';
el.Dimensions = [3 3];
dvl_bus.Elements(end+1) = el;

el = Simulink.BusElement;
el.Name = 'new_vr_flag';
el.Dimensions = [1 1];
dvl_bus.Elements(end+1) = el;


el = Simulink.BusElement;
el.Name = 'new_drr_flag';
el.Dimensions = [1 1];
dvl_bus.Elements(end+1) = el;

el = Simulink.BusElement;
el.Name = 'Ri_dvl';
el.Dimensions = [3 1];
dvl_bus.Elements(end+1) = el;

el = Simulink.BusElement;
el.Name = 'Eul_dvl';
el.Dimensions = [3 1];
dvl_bus.Elements(end+1) = el;
