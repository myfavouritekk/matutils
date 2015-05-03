function [] = batchProcess(funhandle, indir, varargin)
%BATCHPROCESS Process multiple files with given processing function
%   BATCHPROCESS(FUNC, INDIR) processes every file or directory in
%   INDIR using processing funtion FUNC.
%
%   FUNC is a function handle that takes source filename and target
%   directory as input variables. For example, if FUNC = @foo, then
%   BATCHPROCESS calls foo(infile) to every infile in INDIR.
%
%   BATCHPROCESS(..., 'para1', value1, 'para2', value2, ...) takes extra
%   parameter-value pairs to handle input or output options. Parameters are:
%
%       'InputExtension' -- A string value of input file extensions, for
%           example, BATCHPROCESS(@foo, INDIR, 'InputExtension','.jpg')
%           will only process jpg files in INDIR.
%
%       'StartWith' -- File to start processing, default is empty.
%
%       'EndWith' -- File to end processing, default is empty.
%
%       'Verbose' -- verbose the processing, false by default.
%
%       'Parallel' -- Processing in parallel, false by default.
%
%   See also BATCHCOMBINE, BATCHCONVERT.

%%  checking minimum arguments requried
minargs = 2;
maxargs = inf;
n_exargs = length(varargin);

try
    narginchk(minargs, maxargs);
catch err
    if strcmp(err.identifier,'MATLAB:narginchk:notEnoughInputs')
        error('batchProcess:notEnoughInputs',...
              ['Not enough inputs, at least %d arguments are needed. '...
              'Including indir and function handle.'],minargs);
    else
        rethrow(err);
    end
end

%%  default parameters
opts = struct('inputextension', '',...
              'startwith', '', 'endwith', '',...
              'verbose', false,...
              'parallel', false);
optnames = fieldnames(opts); %   case insensitive

%%  override default parameters
if rem(n_exargs,2)  % odd number of name/value
    error('batchProcess:notParameterValuePairs',...
          'Arguments after first %d should be parameter name/value pairs.',...
          minargs);
end
for pair = reshape(varargin,2,[])
    inoptname = lower(pair{1}); %   making it case insensitive
    if validatestring(inoptname, optnames)
        opts.(inoptname) = pair{2};
    else
        error('batchProcess:invalidparameter','%s is not a valid parameter.',...
              inoptname);
    end
end

%%  processing
sourcefile = dir([indir '/*' opts.inputextension]);
if isempty(opts.startwith)
    startProcess = true;
else
    startProcess = false;
end

infiles={};
for i = 1:length(sourcefile)
    if strcmp(sourcefile(i).name(1),'.')
     continue;
 end
 infile = [indir '/' sourcefile(i).name];
 [~,name,ext] = fileparts(infile);

 if ~startProcess && any(strfind(infile, opts.startwith))
    startProcess = true;
end

if any(strfind(infile, opts.endwith))
    break;
end

if startProcess
    infiles{end+1} = infile;
end
end

if opts.parallel
    parfor i = 1:length(infiles)
        if opts.verbose
            disp(sprintf('Processing %s.', infiles{i}));
        end
        try
          funhandle(infiles{i});
        catch err
            disp(sprintf('ERROR: %s\ninfile: %s\n',...
                err.identifier, infiles{i}));
        end
    end
else
    for i = 1:length(infiles)
        if opts.verbose
            disp(sprintf('Processing %s.', infiles{i}));
        end
        try
            funhandle(infiles{i});
        catch err
            disp(sprintf('ERROR: %s\ninfile: %s\n',...
                err.identifier, infiles{i}));
        end
    end
end
