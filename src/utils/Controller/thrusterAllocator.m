function FT_cmd_list = thrusterAllocator(FT_moment_list, FT_force_list, max_thruster_force)
%{
Weighted thruster allocation.
%}

% FT_moment_list = max(-max_thruster_force, min(FT_moment_list, max_thruster_force));
% FT_force_list = max(-max_thruster_force, min(FT_force_list, max_thruster_force));
% 
% [val1, ~] = max(abs(FT_moment_list));
% [val2,~] = max(abs(FT_force_list));
% 
% %weighting factors for each force
% alpha1 = val1/(val1 + val2);
% alpha2 = val2/(val1 + val2);
% 
% FT_cmd_list = FT_moment_list.*alpha1 + FT_force_list.*alpha2;

FT_cmd_list = FT_moment_list + FT_force_list;


end