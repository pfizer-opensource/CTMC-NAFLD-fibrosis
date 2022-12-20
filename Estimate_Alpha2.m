function [score_struc,Avg_Change,Change,SD_mean, Avg_SD,SD,score]= Estimate_Alpha2(save_str,Data,Parameter_File,Actual_Change,fit_flag,plot_flag,var_flag)
%% var_flag describes if there are 9 or 17  parmeters 
% 
% var_flag  = 0 is for placebo parameter fits
% var_flag  = 1 is forward parameter fitting (alpha parameters)
% var_flag  = 2 is forward  and reverse parameter fitting (beta parameters)

%% Fit_flag describes if parameters are  fit or loaded from a previous step 
% fit_flag    = 1  is forward parameter fitting (alpha parameters)
% fit_flag    = 2  is forward  and reverse parameter fitting (beta parameters)
% fit_flag    = 4  for loading 17 parameters fit from previous step
%% Script for estimating model parameters using distribution data only
%Input Initial and Final distributions
Initial_A=Data{1,1}.NF ;
Final_A=Data{1,1}.Dist ; 
T_final=Data{1,1}.T_end ;
Data_Dist=Read_in_dataDist(Initial_A,Final_A,T_final) ;

%% Fit Data using Fit_Fibrosis_Distribution

% Fit Alpha parameters
if fit_flag ==1 
load(Parameter_File,'log_p','final_parameters')
[alpha_parameters,~]=Fit_Fibrosis_Distribution_Alpha(Data,final_parameters,Actual_Change,var_flag,Data_Dist); 
save(save_str,'alpha_parameters')
   
% Fit Beta parameters
elseif fit_flag==2
load(Parameter_File,'new_parameter_file')
[alpha_parameters,~]=Fit_Fibrosis_Distribution_Alpha(Data,new_parameter_file,Actual_Change,var_flag,Data_Dist); 
save(save_str,'alpha_parameters')

% Load  parameter set with 17  parameters
% Use var_flag =  1 or 2
elseif fit_flag ==4
load(Parameter_File,'new_parameter_file');
alpha_parameters=new_parameter_file ;
% elseif fit_flag==0
%   load(Parameter_File,'new_parameter_file');
    alpha_parameters=new_parameter_file ;
end
%% Calculating Improvement from score structure

[score_struc,~,~]=simdataGenN(alpha_parameters,Data,var_flag);

[~,SD,score]=Change_Fib_ScoreRSD(score_struc) ;
[SD_mean, Avg_Change, Avg_SD, Change]=Percent_Pop_Improved(score_struc);

%% Figures 
    if plot_flag==1  && fit_flag ==1
    figure;
    DistributionCheck(Final_A,score_struc)
    title('Placebo')
    xlabel('Fibrosis Stage')
    elseif plot_flag ==1 && fit_flag  ==2 || plot_flag ==1 && fit_flag  == 4
    figure;
    DistributionCheck(Final_A,score_struc)
    title('Pioglitazone')
    xlabel('Fibrosis Stage')
    end 
end
