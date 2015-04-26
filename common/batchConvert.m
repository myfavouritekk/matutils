function [] = batchConvert(funhandle, indir, outdir, varargin)
%BATCHCONVERT Convert multiple files with given conversion function
%   BATCHCONVERT(FUNC, INDIR, OUTDIR) converts every file or directory in
%   INDIR using conversion funtion FUNC and save the converted files to
%   OUTDIR with the same names as in INDIR.
%
%   FUNC is a function handle that takes source filename and target
%   directory as input variables. For example, if FUNC = @foo, then
%   BATCHCONVERT calls foo(infile, outfile) to every infile in INDIR.
%
%   BATCHCONVERT(..., 'para1', value1, 'para2', value2, ...) takes extra
%   parameter-value pairs to handle input or output options. Parameters are:
%
%       'SameBasename' -- A logical value indicating whether using the same
%           basename for output files as with input files. 'SameBasename' is
%           true by default.
%
%       'SameExtension' -- A logical value indicating whether using the same
%           extension for outputs files as with input files. 'SameExtension'
%           is true by default.
%
%       'InputExtension' -- A string value of input file extensions, for
%           example, BATCHCONVERT(INDIR, OUTDIR, foo, 'InputExtension','.jpg')
%           will only convert jpg files in INDIR.
%
%       'OutputExtension' -- A string value of output file extensions.
%
%       'StartWith' -- File to start conversion, default is empty.
%
%       'EndWith' -- File to end conversion, default is empty.
%
%       'Verbose' -- verbose the conversion, false by default.
%

%%  checking minimum arguments requried
minargs = 3;
maxargs = inf;
n_exargs = length(varargin);

try
    narginchk(minargs, maxargs);
catch err
    if strcmp(err.identifier,'MATLAB:narginchk:notEnoughInputs')
        error('batchconvert:notEnoughInputs',...
             ['Not enough inputs, at least %d arguments are needed. '...
              'Including indir, outdir and function handle.'],minargs);
    else
        rethrow(err);
    end
end

%%  default parameters
opts = struct('samebasename', true, 'sameextension', true,...
              'inputextension', '', 'outputextension', '',...
              'startwith', '', 'endwith', '',...
              'verbose', false);
optnames = fieldnames(opts); %   case insensitive

%%  override default parameters
if rem(n_exargs,2)  % odd number of name/value
    error('batchconvert:notParameterValuePairs',...
          'Arguments after first %d should be parameter name/value pairs.',...
          minargs);
end
for pair = reshape(varargin,2,[])
    inoptname = lower(pair{1}); %   making it case insensitive
    if validatestring(inoptname, optnames)
        opts.(inoptname) = pair{2};
    else
        error('batchconvert:invalidparameter','%s is not a valid parameter.',...
              inoptname);
    end
end

%%  conversion
if ~exist(outdir,'dir')
    mkdir(outdir);
end
sourcefile = dir([indir '/*' opts.inputextension]);
ndigits = numel(num2str(length(sourcefile)));
digitformat = sprintf('%%0%dd',ndigits);

if isempty(opts.startwith)
    startConversion = true;
else
    startConversion = false;
end

infiles={};
outfiles={};
for i = 1:length(sourcefile)
    if strcmp(sourcefile(i).name(1),'.')
       continue;
    end
    infile = [indir '/' sourcefile(i).name];
    outfile = outdir;
    [~,name,ext] = fileparts(infile);

    if opts.samebasename
        outfile = fullfile(outfile, name);
    else
        outfile = fullfile(outfile, sprintf(digitformat, i));
    end

    if ~isempty(opts.outputextension)
        outfile = [outfile opts.outputextension];
    elseif opts.sameextension
        outfile = [outfile ext];
    end

    if ~startConversion && any(strfind(infile, opts.startwith))
        startConversion = true;
    end

    if any(strfind(infile, opts.endwith))
        break;
    end

    if startConversion
        infiles{end+1} = infile;
        outfiles{end+1} = outfile;
    end
end

parfor i=1:length(infiles)
    if opts.verbose
        disp(sprintf('Converting %s to %s.', infiles{i}, outfiles{i}));
    end
    try
        funhandle(infiles{i}, outfiles{i});
    catch err
        disp(sprintf('ERROR: %s\ninfile: %s\noutfile: %s\n',...
                err.identifier, infiles{i}, outfiles{i}));
    end
end

end
