function validFlag = isValidPlotData(t,data,expected_size)
%{
This function checks if the provided dataset matches the expected size and
contains plottable data.

t - timeseries
data - dataset to be plotted
expected_size - expected dimension [num_row,num_col] of the data set
%}

try
    num_row = expected_size(1);
    num_col = expected_size(2);
    t_steps = length(t);
    
    [n,m] = size(data);
    if((num_row == n) && (num_col == m) && (t_steps == num_row))
        %this function makes sure the data has a number of rows equal to
        %the number of time steps, i.e. the matrix is tall and skinny
        
        %TODO additional checks for plottable data go here.
        validFlag = 1;
    else
        validFlag = 0;
    end
catch
    %if the previous checks fail for any reason, return 0
    validFlag = 0;
end



end



