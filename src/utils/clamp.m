function out = clamp(in,lower,upper)
%create a boolean mask of elements greater than upper
out = in;
bool_mask = in>upper;
out(bool_mask) = upper;
bool_mask = in<lower;
out(bool_mask) = lower;
end