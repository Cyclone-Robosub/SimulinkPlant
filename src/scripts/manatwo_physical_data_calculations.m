%changing the order these are run in will break things
%working on a more elegant solution
run('manatwo_buoyancy_calculations.m')
run('manatwo_mass_calculations.m')
run('manatwo_wrench_calculations.m')
run("manatwo_added_mass_calculations.m")
run("manatwo_drag_calculations.m")
run("setup_default_maneuvers.m")
run("setup_default_maneuvers2.m")