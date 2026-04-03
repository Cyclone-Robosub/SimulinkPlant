function id = cmdStatusID(cmd_status)

%{
A brief function to map the command status 'SUCC', 'FAIL', and 'RUNN' to
the numbers 1, 2, 3 for debugging plots.
%}


switch char(cmd_status)
    case 'SUCC'
        id = 1;
    case 'FAIL'
        id = 2;
    case 'RUNN'
        id = 3;
    otherwise
        id = 0;
end

end