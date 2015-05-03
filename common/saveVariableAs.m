function [] = saveVariableAs(infile, in_var, outfile, out_var)
%%SAVEVARIABLEAS: Save an element in one Mat-file in another Mat-file
%
%   SAVEVARIABLEAS(INFILE, IN_VAR, OUTFILE, OUT_VAR) saves element IN_VAR
%   in INFILE as OUT_VAR in OUTFILE
%
%   See also VARIABLE, SETVARIABLE.
%
setVariable(variable(in_var, infile), out_var, outfile);
