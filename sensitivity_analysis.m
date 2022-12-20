function sensitivity_analysis(parameter_file,fit_flag)
%% Script to determine sensitivity of parameters
% Given the placebo set of parameters, what degree of change will
% elicit a change in the average fibrosis score of a given initial population.

%% Input Data
% Cusi et al. Data
Data_Table1=[20,0,0,0,0;0,20,0,0,0;0,0,20,0,0; 0,0,0,20,0;0,0,0,0,20;];

%% Read data into a data set compiling information about patient # and time in months
[Data_Set_1]=Read_in_data(Data_Table1,24);

%% Load parameters to sweep through
Parameter_File=load(parameter_file);

%Compile Data Set to structure (can be useful for multiple data sets)
[Data]=Fit_Fibrosis_test(Data_Set_1) ;

% Parameter sweep for forward parameters
ii=logspace(-4,2,20);
if fit_flag ==1
    [PRM_sweep]=Parameter_Sweep(ii,Parameter_File,Data);
    save('PRM_sweep','PRM_sweep')
elseif fit_flag == 0
    load('PRM_sweep')
end

%% Calculate the average change in fibrosis score assuming a large population
for i=1:numel(PRM_sweep)
    Calculate_iterative_Change(ii,PRM_sweep(i).for,PRM_sweep(i).back,Data,i)
end


%% Helper function
    function [Data]=Fit_Fibrosis_test(varargin)
        % Organizes data into readable structure
        % most useful for multiple data sets but also necessary
        % for a single data set to be read properly into files
        Data=varargin;
    end
end