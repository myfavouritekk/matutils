function [] = catmat(indir, outmat, variable)
%CATMAT Concatenate matrices from all Mat-files in a directory to a target
%Mat-file
%   CATMAT(INDIR, OUTMAT, VARIABLE) concatenates element VARIABLE from all
%   Mat-files in INDIR to TARGET_FILE
%
batchProcess(@(x) appendmat(x, outmat, variable), indir, 'Verbose', true,...
             'InputExtension', '.mat');
