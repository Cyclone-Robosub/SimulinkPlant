function A_out = enforceTallSkinny(A_in)
%{
Helper script to enforce a matrix to be tall and skinny instead of short
and wide.

For a given NxM matrix, if N < M the matrix is transposed, and if N >= M the
matrix is left unchanged.
%}

[N,M] = size(A_in);

if(N < M)
    A_out = A_in';
else
    A_out = A_in;
end