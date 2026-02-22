function [std,angle,pos] = dead_reck_report_parser(dead_reck_report)
%DEAD_RECK_REPORT_PARSER Parses the DVL structure to get data
%   MATLAB listens to the DVL and understands it as a structure with fields
%   the fields are all descriptors of the message. 

std = dead_reck_report.pos_std;

angle = [dead_reck_report.angle.x; dead_reck_report.angle.y; dead_reck_report.angle.z];

pos = [dead_reck_report.position.x; dead_reck_report.position.y; dead_reck_report.position.z];
end