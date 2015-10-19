function [] = catmat(indir, outmat, variable, axis)
%CATMAT Concatenate matrices from all Mat-files in a directory to a target
%Mat-file
%   CATMAT(INDIR, OUTMAT, VARIABLE) concatenates element VARIABLE from all
%   Mat-files in INDIR to TARGET_FILE
%
%   CATMAT(INDIR, OUTMAT, VARIABLE, AXIS) concatenates along the axis AXIS,
%   AXIS \in {1,2}
%
if nargin < 4
    axis = 2;
end
batchProcess(@(x) appendmat(x, outmat, variable, axis), indir,...
             'Verbose', true,...
             'InputExtension', '.mat');
