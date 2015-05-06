function [combination] = batchCombine(funhandle, indir, varargin)
%BATCHCOMBINE Process multiple files and combine the results into a cell array
%   BATCHCOMBINE(FUNC, INDIR) processes every file or directory in
%   INDIR using processing funtion FUNC.
%
%   FUNC is a function handle that takes source filename as input variables.
%   For example, if FUNC = @foo, then BATCHCOMBINE calls foo(infile) to
%   every infile in INDIR.
%
%   BATCHCOMBINE(..., 'para1', value1, 'para2', value2, ...) takes extra
%   parameter-value pairs to handle input or output options. Parameters are:
%
%       'InputExtension' -- A string value of input file extensions, for
%           example, BATCHCOMBINE(@foo, INDIR, 'InputExtension','.jpg')
%           will only process jpg files in INDIR.
%
%       'StartWith' -- File to start processing, default is empty.
%
%       'EndWith' -- File to end processing, default is empty.
%
%       'Verbose' -- verbose the processing, false by default.
%
%   See also BATCHCONVERT, BATCHPROCESS.

%%  checking minimum arguments requried
minargs = 2;
maxargs = inf;
n_exargs = length(varargin);

try
    narginchk(minargs, maxargs);
catch err
    if strcmp(err.identifier,'MATLAB:narginchk:notEnoughInputs')
        error('batchCombine:notEnoughInputs',...
             ['Not enough inputs, at least %d arguments are needed.' ...
              'Including indir and function handle.'],minargs);
    else
        rethrow(err);
    end
end

%%  default parameters
opts = struct('inputextension', '',...
              'startwith', '', 'endwith', '',...
              'verbose', false);
optnames = fieldnames(opts); %   case insensitive

%%  override default parameters
if rem(n_exargs,2)  % odd number of name/value
    error('batchCombine:notParameterValuePairs',...
          'Arguments after first %d should be parameter name/value pairs.',...
          minargs);
end
for pair = reshape(varargin,2,[])
    inoptname = lower(pair{1}); %   making it case insensitive
    if validatestring(inoptname, optnames)
        opts.(inoptname) = pair{2};
    else
        error('batchCombine:invalidparameter','%s is not a valid parameter.',...
              inoptname);
    end
end

%%  combining
sourcefile = dir([indir '/*' opts.inputextension]);
if isempty(opts.startwith)
    startCombining = true;
else
    startCombining = false;
end

n = 0;
total_length = length(sourcefile);
tmpCombine = cell(total_length,1);
for i = 1:total_length
    if strcmp(sourcefile(i).name(1),'.')
       continue;
    end
    infile = [indir '/' sourcefile(i).name];


    if ~startCombining && any(strfind(infile, opts.startwith))
        startCombining = true;
    end

    if any(strfind(infile, opts.endwith))
        break;
    end

    if startCombining
        if opts.verbose
            displayString = sprintf('Combining %s.', infile);
            disp(displayString);
        end
        n = n + 1;
        tmpCombine{n} = funhandle(infile);
    end
end

combination = tmpCombine(1:n);

disp(sprintf('Combined %d files in total.', n));

end