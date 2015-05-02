function [] = checkValid(infile, var_name)
var = variable(var_name, infile);
if any(isnan(var(:)))
    sprintf('%s has NaN.\n', infile);
elseif any(isinf(var(:)))
    sprintf('%s has Inf.\n', infile);
end