function [results] = hasVariable(var_name, infile)
%HASVARIABLE checks if a Mat-file contains a variable
%   [RESULTS] = HASVARIABLE(VAR_NAME, INFILE) checks if Mat-file INFILE
%       contains variable VAR_NAME
%
%   See also: MATFILE, ISMEMBER
mat = matfile(infile);
results = ismember(var_name, who(mat));