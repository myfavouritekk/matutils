function [] = appendmat(source_file, target_file, variable)
%APPENDMAT Apppend matrix from a source Mat-file to a target Mat-file
%   APPENDMAT(SOURCE_FILE, TARGET_FILE, VARIABLE) append element VARIABLE
%   from SOURCE_FILE to TARGET_FILE
%
source_mat = matfile(source_file);
target_mat = matfile(target_file, 'Writable', true);
try
    [~, end_idx] = size(target_mat, variable);
catch
    target_mat.(variable) = source_mat.(variable);
    return
end
l = size(source_mat.(variable), 2);
target_mat.(variable)(:,end_idx+1:end_idx+l) = source_mat.(variable);
