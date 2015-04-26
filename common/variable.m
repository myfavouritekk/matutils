function [var] = variable(var_name, mat_path)
%VARIABLE read variable from a mat-file
%   VARIABLE(VAR_NAME, MAT_PATH) returns element VAR_NAME from Mat-file
%   MAT_FILE
%
    m = matfile(mat_path);
    var = m.(var_name);
