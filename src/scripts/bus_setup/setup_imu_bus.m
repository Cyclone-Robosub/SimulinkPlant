%{
Bus for the imu data used in the sensor model.
%}

imu_bus = Simulink.Bus;

el = Simulink.BusElement;
el.Name = 'imu_acc';
el.Dimensions = [3 1];
imu_bus.Elements(end+1) = el;

el = Simulink.BusElement;
el.Name = 'imu_w';
el.Dimensions = [3 1];
imu_bus.Elements(end+1) = el;

el = Simulink.BusElement;
el.Name = 'imu_mag';
el.Dimensions = [3 1];
imu_bus.Elements(end+1) = el;

el = Simulink.BusElement;
el.Name = 'new_imu_flag';
el.Dimensions = [1 1];
imu_bus.Elements(end+1) = el;
