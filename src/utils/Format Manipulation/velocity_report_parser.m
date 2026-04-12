function [velocity, altitude, covariance, fom] = velocity_report_parser(velocity_report)
%VELOCITY_REPORT_PARSER
%   Velocity Data reported by the DVL is sent over ros via the topic DVL_VR


velocity = [velocity_report.velocity_data.x,velocity_report.velocity_data.y,velocity_report.velocity_data.z]';

altitude = velocity_report.altitude;

covariance = velocity_report.covariance.data;

fom = velocity_report.fom;

end