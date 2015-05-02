function [] = setVariable(value, var_name, mat_path)
%SETVARIABLE save a variable into a mat-file
%   SETVARIABLE(VALUE, VAR_NAME, MAT_PATH) saves value VALUE into element
%   VAR_NAME in Mat-file MAT_PATH
%
    mat = matfile(mat_path, 'Writable', true);
    mat.(var_name) = value;
