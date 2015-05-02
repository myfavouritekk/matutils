function [] = threshold(infile, outfile, var_name, thres_value)
%%THRESHOLD: set thresholds on a variable in a matfile
    mat = variable(var_name, infile);
    mask = mat>thres_value;
    mat(mask) = 1;
    mat(~mask) = 0;
    setVariable(mat, var_name, outfile);
