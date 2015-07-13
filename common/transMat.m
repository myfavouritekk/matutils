function transMat(varname, infile, outfile)
%TRANSMAT Transpose matrix in a Mat-file
%   TRANSMAT(VARNAME, MATFILE) transposes variable VARNAME in MATFILE, if
%   it is a matrix, overriding the original variable
%
%   TRANSMAT(VARNAME, INFILE, OUTFILE) transposes variable VARNAME in
%   INFILE and save the results in OUTFILE
%
%   See also CATMAT, APPENDMAT

var = variable(varname, infile);
if ismatrix(var)
    switch nargin
        case 2
            setVariable(var', varname, infile);
        case 3
            setVariable(var', varname, outfile);
        otherwise
            fprintf('transMat accepts 2 or 3 arguments.\n');
    end
else
    fprintf('%s in %s is not a matrix.\n', varname, infile);
end