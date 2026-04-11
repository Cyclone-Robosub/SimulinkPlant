function [velocity, altitude, covariance, fom] = velocity_report_parser(velocity_report)
%VELOCITY_REPORT_PARSER Summary of this function goes here
%   Velocity Data reported by the DVL is sent over ros via the topic DVL_VR
%   It is our goal here to take the data from DVL_VR and parse the relevant
%   data for use within our sensor fusion algorithms and data gathering
%   during deployments. 
%   This is pertinent for our HIL.

velocity = [velocity_report.velocity_data.x,velocity_report.velocity_data.y,velocity_report.velocity_data.z]';

altitude = velocity_report.altitude;

covariance = velocity_report.covariance.data;

fom = velocity_report.fom;

end