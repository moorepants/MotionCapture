% File: renameFiles.m
% Date: March 3, 2008
% Author: Jason Moore
% Description: Copies and renames the tnXX.mat and tnXXX.mat files recorded on
% February 9th, 10th and 11th to a common file name iXXX.mat where i =
% 1,2,3 refers to Jodi, Victor and Jason respectively. XXX is the run
% number such as 024 for run # 24.

clear all
close all
clc

for j = 1:3 % go through each rider directory
    directory = ['pp' num2str(j)]; % set the directory name
    for i = 1:110 % go through each trial, max number of trials < 100
        % set the original file name
        if i < 10
            fileName = ['tn0' num2str(i)];
        else
            fileName = ['tn' num2str(i)];
        end
        % see what files are in the directory
        s = what(directory);
        % is the current file name in the directory?
        isThere = strcmp([fileName '.mat'],s.mat);
        % if not, don't do anything
        if isThere==0
        else % load the data
            load([directory '\' fileName]); % load the mat file
            clear maxrms % erase these
            % set the new file name
            if i < 10
                newFileName = [num2str(j) '00' num2str(i)];
            elseif i >= 10 && i < 100
                newFileName = [num2str(j) '0' num2str(i)];
            else
                newFileName = [num2str(j) num2str(i)];
            end
            % save the variables to the new file name
            save(newFileName,'x','y','z','xori','yori','zori','t',...
                'bike','condition','gear','V')
            % erase the variables
            clear t x y z xori yori zori condition gear bike V
        end
    end
end