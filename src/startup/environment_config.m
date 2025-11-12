path = 'C:\GitHub\Cyclone Robosub\SimulinkPlant\src\codegen';

try
    Simulink.fileGenControl('set', 'CacheFolder', path);
    Simulink.fileGenControl('set', 'CodeGenFolder', path);
catch
    warning("Unable to configure environemnt variables. Check path in environment_config.m.");
end