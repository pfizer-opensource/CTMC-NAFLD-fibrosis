function RunPlaceboFunc(Save_str)
%% Script for running model with multiple data sets at different study end times


%% Input Data (Chronological Order)
% Data looks like
%   F0_starter: F0_end, F1_end, F2_end, F3_end, F4_end ;
%   F1_starter: F0_end, F1_end, F2_end, F3_end, F4_end ;
% 
% Format Data_TableN=[F0,F1,F2,F3,F4;F0,F1,F2,F3,F4;...] etc. for each starting
% position                                                         % References
Data_Table1=[3,0,0,0,0;8,3,2,1,0;0,0,1,0,0;0,1,0,3,0;0,0,0,0,0;];  % Harrison et al.   % Mathurin et al. 
Data_Table2=[0,0,0,0,0;1,4,0,0,0;0,0,0,0,0;0,0,0,0,0;0,0,0,0,0;];  % Ratzui et al.     % Adams et al.
Data_Table3=[17,7,0,1,1;8,7,1,2,0;4,1,0,1,1;0,0,1,0,0;0,0,0,0,1;]; % Wong et al.       % Fassio et al.
Data_Table4=[2,3,0,0,0;1,0,1,0,0;0,0,0,0,0;0,0,0,0,0;0,0,0,0,0;];  % Hui et al.
Data_Table5=[4,0,0,0,0;1,0,1,0,1;0,0,0,0,0;0,0,0,0,0;0,0,0,0,0;];  % Evans et al.
Data_Table6=[0,2,2,0,0;0,8,7,1,1;0,0,8,8,0;0,0,0,3,1;0,0,0,0,1;];  % Chan et al.
Data_Table7=[4,1,0,0,0;0,1,1,0,0;0,0,0,0,1;0,0,0,0,0;0,0,0,0,0;];  % McPherson et al.
Data_Table8=[20,8,7,3,0;6,9,4,1,1;0,5,1,2,3;0,0,1,1,2;0,0,0,0,0;]; % Ekstedt et al.

% Read data into a data set compiling information about patient #, Time in
% months etc.
[Data_Set1]=Read_in_data(Data_Table1,6);
[Data_Set2]=Read_in_data(Data_Table2,24);
[Data_Set3]=Read_in_data(Data_Table3,36);
[Data_Set4]=Read_in_data(Data_Table4,48);
[Data_Set5]=Read_in_data(Data_Table5,60);
[Data_Set6]=Read_in_data(Data_Table6,72);
[Data_Set7]=Read_in_data(Data_Table7,96);
[Data_Set8]=Read_in_data(Data_Table8,156);


%% Fit Data to get final parameter estimates
%   Fit_Fibrosis_Gen can take any number of Data_Sets
%   Each data set is at a different end study time (T_end)
%   Run model fitting minimizing sum of squares weighted by number of patients

% Generate Final parameter estimates and data table
[final_parameters,Data]=Fit_Fibrosis_Gen(Save_str,Data_Set1,Data_Set2,Data_Set3,Data_Set4,Data_Set5,Data_Set6,Data_Set7,Data_Set8);
    

%% Run model 500 times to get statistics
% Simulate data can either simulate output with a given set of parameters 
% and is also useful for generating the score_structure for plotting
 load(Save_str,'log_p','final_parameters')


%% Simulate the model with the same number of N to assess parameters and model performance
% Simulate for each time point with N of trial
[Data1]=Fit_Fibrosis_test(Data_Set1);
[Data2]=Fit_Fibrosis_test(Data_Set2);
[Data3]=Fit_Fibrosis_test(Data_Set3);
[Data4]=Fit_Fibrosis_test(Data_Set4);
[Data5]=Fit_Fibrosis_test(Data_Set5);
[Data6]=Fit_Fibrosis_test(Data_Set6);
[Data7]=Fit_Fibrosis_test(Data_Set7);
[Data8]=Fit_Fibrosis_test(Data_Set8);

var_flag = 0;
[score_struc_1,~]=simdataGenN(final_parameters,Data1,var_flag);
[score_struc_2,~]=simdataGenN(final_parameters,Data2,var_flag);
[score_struc_3,~]=simdataGenN(final_parameters,Data3,var_flag);
[score_struc_4,~]=simdataGenN(final_parameters,Data4,var_flag);
[score_struc_5,~]=simdataGenN(final_parameters,Data5,var_flag);
[score_struc_6,~]=simdataGenN(final_parameters,Data6,var_flag);
[score_struc_7,~]=simdataGenN(final_parameters,Data7,var_flag);
[score_struc_8,~]=simdataGenN(final_parameters,Data8,var_flag);

%% Figure 2
% Plot Bar Graphs for each time point
figure; % Figure 2A
plot_bar_fibrosis(score_struc_1) 
figure; % Figure 2B
plot_bar_fibrosis(score_struc_3)
figure; % Figure 2C
plot_bar_fibrosis(score_struc_6)
figure; % Figure 2D
plot_bar_fibrosis(score_struc_8)

%% Helper functions
    function [Data]=Fit_Fibrosis_test(varargin)
    % organizes data into readable structure 
    % most useful for multiple data sets but also necessary 
    % for a single data set to be read properly into files
    Data=varargin;
    end
end