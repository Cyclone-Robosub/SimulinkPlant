%changing the order these are run in will break things
%working on a more elegant solution
run('buoyancy_calculations.m')
run('mass_calculations.m')
run('wrench_calculations.m')
run("added_mass_calculations.m")
run("drag_calculations.m")
run("setup_default_maneuvers.m")
%run("setup_default_maneuvers2.m")