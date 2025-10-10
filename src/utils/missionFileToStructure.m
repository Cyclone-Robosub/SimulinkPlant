function [mission_struct] = missionFileToStructure(mission_file)
%{
Version 1

This function contains the code to parse a mission text file into a mission
structure that can be used in Simulink. The version of the 
missionFileToStructure, parseMissionStructure, and mission file must all 
match or errors will occur.

The mission structure that is created has a dynamic number of items in it
depending on the type of command. It will always have at least a 
command_type.

command_type - a keyword corresponding with the type of command

The command_type tells the parser which type of command is being run so the
timings and PWMs can be handled accordingly. Different command types have
different numbers of input arguments, which are stored in additional
structure fields. 

The input to this is the name of the mission_file.

-KJH 10_4_2025
%}

%calls an importer script generated using the Matlab Import Data menu.
mission_table = importMissionFile(mission_file);


%Populate structure with the values from the table
mission_struct.command_type = mission_table.command_type;
mission_struct.var1 = mission_table.var1;
mission_struct.var2 = mission_table.var2;
mission_struct.var3 = mission_table.var3;
mission_struct.var4 = mission_table.var4;
mission_struct.var5 = mission_table.var5;
mission_struct.var6 = mission_table.var6;
mission_struct.var7 = mission_table.var7;
mission_struct.var8 = mission_table.var8;
mission_struct.var9 = mission_table.var9;

end