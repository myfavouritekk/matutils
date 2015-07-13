function [output] = basename(filename, new_ext)
%BASENAME Extract basename from path
%   [output] = BASENAME(FILENAME) returns basename of FILENAME with original
%       extension
%   [output] = BASENAME(FILENAME, new_ext) returns basename of FILENAME with
%       new extension NEW_EXT
%   [output] = BASENAME(FILENAME, '') returns basename of FILENAME without
%       extension
%
[~, name, ext] = fileparts(filename);
switch nargin
    case 1
        output = [name, ext];
    case 2
        output = [name, new_ext];
end
