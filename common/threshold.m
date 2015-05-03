function [] = threshold(infile, outfile, var_name, thres_value)
%%THRESHOLD: set thresholds on a variable in a matfile
%
%   THRESHOLD(INFILE, OUTFILE, VAR_NAME, THRES_VALUE) sets thresold value
%   THRES_VALUE on element VAR_NAME in INFILE and save the result in OUTFILE
%   with the same variable name VAR_NAME
%
    mat = variable(var_name, infile);
    mask = mat>thres_value;
    mat(mask) = 1;
    mat(~mask) = 0;
    setVariable(mat, var_name, outfile);
