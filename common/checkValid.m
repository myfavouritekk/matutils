function [] = checkValid(infile, var_name)
%%CHECKVALID check if an element in a Mat-file does not contain NaN or Inf
%
%   CHECKVALID(INFILE, VAR_NAME) checks if element VAR_NAME in Mat-file
%   INFILE does not contain NaN or Inf
%
var = variable(var_name, infile);
if any(isnan(var(:)))
    sprintf('%s has NaN.\n', infile);
elseif any(isinf(var(:)))
    sprintf('%s has Inf.\n', infile);
end