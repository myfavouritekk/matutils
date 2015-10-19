function [] = appendmat(source_file, target_file, variable, axis)
%APPENDMAT Apppend matrix from a source Mat-file to a target Mat-file
%   APPENDMAT(SOURCE_FILE, TARGET_FILE, VARIABLE) append element VARIABLE
%   from SOURCE_FILE to TARGET_FILE
%
if nargin < 4
    axis = 2
end
source_mat = matfile(source_file);
target_mat = matfile(target_file, 'Writable', true);
try
    switch axis
        case 2
            [~, end_idx] = size(target_mat, variable);
        case 1
            [end_idx, ~] = size(target_mat, variable);
        otherwise
            error('appendmat: appending axis has to be either 1 or 2.');
    end
catch
    target_mat.(variable) = source_mat.(variable);
    return
end
l = size(source_mat.(variable), axis);
switch axis
    case 2
        target_mat.(variable)(:,end_idx+1:end_idx+l) = source_mat.(variable);
    case 1
        target_mat.(variable)(end_idx+1:end_idx+l,:) = source_mat.(variable);
    otherwise
        error('appendmat: appending axis has to be either 1 or 2.');
end
