%% Run Complete Model Script
% Step 1: Estimate parameters for disease progression data
% Function input 'save_str' to store fitted parameters
% Speed options: open Fit_Fibrosis_Gen to change Genetic Algorithm
% Population and maximum generations (200 and 100)
% Open: simdataGenN to change number of simulations k=1:500 
% Input Data options: Open RunPlacebo Script and manually enter data tables
% in chronological order 

% Generates results in Figure 2 and saves final parameter estimates

RunPlaceboFunc('Save_Results1')


%% Step 2: Sensitivity Analysis
% Parameter sweep for sensitivity analysis
% Generates Figure 3 
% Inputs: save_string and fit flag to indicate model fitting
 
 Fit_flag=1;
 sensitivity_analysis('Save_Results1',Fit_flag)

%% Step 3: Fitting Pioglitazone Comparison
%  Generate Figure 4 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%  Cusi et al. %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Placebo Data, 18 months
% Fit new parameters to Cusi data  
Data1=[20,0,0,0,0;0,22,0,0,0;0,0,4,0,0; 0,0,0,5,0;0,0,0,0,0;];
[Data1]=Read_in_data(Data1,18);
[Data1]=Fit_Fibrosis_test(Data1);
Data1{1,1}.Dist=[22,19,4,6,0];
Actual_Change_3=0; % Indicates average change in fibrosis score for the cohort

% Alpha parameters represent the differences in placebo effectfrom trial 
% to trial. 
% Alpha parameters are added to baseline fitted parameters from studies with no intervention 
fit_flag=1; plot_flag=1; var_flag=1;

Estimate_Alpha2('Cusi_Alpha',Data1,'Save_Results1',Actual_Change_3,fit_flag,plot_flag,var_flag);

% Converts alpha parameters to final parameters for the specified trial
 
 Calculate_Final_Parameters('Cusi_Placebo_Fit','Cusi_Alpha'); 

%Cusi Pioglitazone
Data2=[15,0,0,0,0;0,22,0,0,0;0,0,6,0,0; 0,0,0,7,0;0,0,0,0,0;];
[Data2]=Read_in_data(Data2,18);
[Data2]=Fit_Fibrosis_test(Data2);
Data2{1,1}.Dist=[28,16,2,4,0];
Actual_Change_C=-0.5; % Indicates average change in fibrosis score for the cohort
fit_flag=2; plot_flag=1; var_flag=2;
% Beta paramters represent the change in fibrosis score attributed to
% pioglitazone

Estimate_Alpha2('Cusi_Beta',Data2,'Cusi_Placebo_Fit',Actual_Change_C,fit_flag,plot_flag,var_flag);

%Calculate_Final_Parameters('Cusi_Pio_Fit','Cusi_Beta')

Calculate_BetaFinal_Parameters('Cusi_Pio_Fit','Cusi_Placebo_Fit','Cusi_Beta')


%%%%%%%%%%%%%%%%%%%%%%%%%%  Belfort et al. %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Placebo data, 6 months

Data3=[6,0,0,0,0;0,9,0,0,0;0,0,4,0,0; 0,0,0,2,0;0,0,0,0,0;];
[Data3]=Read_in_data(Data3,6);
[Data3]=Fit_Fibrosis_test(Data3);
Data3{1,1}.Dist=[8,7,3,1,1];
Actual_Change_2 = -0.3; % Average change in fibrosis score for the cohort
fit_flag=1; plot_flag=1; var_flag=1;

 Estimate_Alpha2('Belfort_Alpha',Data3,'Save_Results1',Actual_Change_2,fit_flag,plot_flag,var_flag);
 Calculate_Final_Parameters('Belfort_Placebo_Fit','Belfort_Alpha');

% Pioglitazone 6 months
Data4=[2,0,0,0,0;0,12,0,0,0;0,0,5,0,0; 0,0,0,7,0;0,0,0,0,0;];
[Data4]=Read_in_data(Data4,6);
[Data4]=Fit_Fibrosis_test(Data4);
Data4{1,1}.Dist=[5,15,6,0,0];
Actual_Change_B = -0.7; % Average change in fibrosis score for the cohort
fit_flag=4; plot_flag=1; var_flag=2;

% Calculate alpha and beta paramters for validation
% Input save string, final placebo fit parameters, pioglitazone fold-change paramters

Calculate_BetaFinal_Parameters('Belfort_Pio','Belfort_Placebo_Fit','Cusi_Beta');
Estimate_Alpha2('Belfort_Beta',Data4,'Belfort_Pio',Actual_Change_B,fit_flag,plot_flag,var_flag);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%  Aithal et al. %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Placebo, 12 months
Data5=[5,0,0,0,0;0,2,0,0,0;0,0,12,0,0; 0,0,0,7,0;0,0,0,0,4;];
[Data5]=Read_in_data(Data5,12);
[Data5]=Fit_Fibrosis_test(Data5);
Data5{1,1}.Dist=[7,3,9,3,8];
Actual_Change_1 =0.03; % Average change in fibrosis score for the cohort
fit_flag=1; plot_flag=1; var_flag=1;

Estimate_Alpha2('Aithal_Alpha',Data5,'Save_Results1',Actual_Change_1,fit_flag,plot_flag,var_flag);
Calculate_Final_Parameters('Aithal_Placebo_Fit','Aithal_Alpha');

% Pioglitazone, 12 months, dose 45 mg/day
Data6=[8,0,0,0,0;0,2,0,0,0;0,0,14,0,0; 0,0,0,5,0;0,0,0,0,2;];
[Data6]=Read_in_data(Data6,12);
[Data6]= Fit_Fibrosis_test(Data6);
Data6{1,1}.Dist=[12,5,10,2,2];
Actual_Change_A=0.45; % Average change in fibrosis score for the cohort
fit_flag=4; plot_flag=1; var_flag=2;

Calculate_BetaFinal_Parameters('Aithal_Pio','Aithal_Placebo_Fit','Cusi_Beta');
Estimate_Alpha2('Aithal_Beta',Data6,'Aithal_Pio',Actual_Change_A,fit_flag,plot_flag,var_flag);

%% Step 4: Percent of patient population improved
%Generates Figure 5A
figure5 

%Figure 5B
Placebo_Weight= [0.346,0.435,0.099,0.1188,0] ; % Weighted distribution of patients in each stage of fibrosis
fig =51;

 Placebo_Simulation_alpha_multDist(Placebo_Weight,'results5b',fig)

% Figure 5C
Placebo_Weight=[0,0,0.5,0.5,0]; % Assume F2 and F3 patients only
fig = 52;

 Placebo_Simulation_alpha_multDist(Placebo_Weight,'results5c',fig)

%% Step 5: Power Analysis
% Generates Figure 6
% Plots Power vs. Sample Size of Patient population using two-sample t-test

Weight=[0.346,0.435,0.099,0.1188,0] ; % Weighted distribution of patients in each stage of fibrosis
T_end=18 ;                            % Duration (Months)
NMAX = 125 ;                          % Maximum number of patients to simulate
fit_flag=1;
Power_Calculations1(Weight,NMAX,T_end,fit_flag) ; % Run Analysis to generate figure 6

%% Save plots as PDF

Fighandles=findall(0,'Type','figure');

for i = 1:numel(Fighandles)
    figure(i)
    if i == 1 
    subplot(5,1,1)
    title({'6 Months';'(Harrison et al. 2003)'});
    elseif i ==2
    subplot(5,1,1)
    title({'36 Months';'(Wong et al. 2010)'});
    elseif i == 3
    subplot(5,1,1)
    title({'72 Months';'(Chan et al. 2014)'});
    elseif i ==4
    subplot(5,1,1)
    title({'156 Months';'(Ekstedt et al. 2006)'});
    elseif i ==9
    title({'Placebo 18 Months';'(Cusi et al.)'});
    elseif i ==10
    title({'Pioglitazone 18 Months';'(Cusi et al.)'});
    elseif i ==11
    title({'Placebo 6 Months';'(Belfort et al.)'});
    elseif i ==12
    title({'Pioglitazone 6 Months';'(Belfort et al.)'});
    elseif i ==13
    title({'Placebo 12 Months';'(Aithal et al.)'});
    elseif i ==14
    title({'Pioglitazone 12 Months';'(Aithal et al.)'});
    elseif i ==16
    title({'Population with improved fibrosis\geq 1';'[35% F0, 44% F1, 10% F2, 12% F3]'});
    elseif i ==17
    title({'Population with improved fibrosis\geq 1';'[50% F2, 50% F3]'});
 	end
    
    filename=['Fig_',num2str(i),'.pdf'];
    saveas(gcf,filename)
end

%% Helper functions
function Calculate_Final_Parameters(save_str,parameter_file)
load(parameter_file) ;
new_parameter_file=struct ;
new_parameter_file.markov.forward=[alpha_parameters.markov.forward].*[alpha_parameters.alpha(1:2:8)];
new_parameter_file.markov.backward=[alpha_parameters.markov.backward].*[alpha_parameters.alpha(2:2:8)];
new_parameter_file.alpha=ones(1,8) ;
new_parameter_file.progressor_probability=alpha_parameters.progressor_probability;
new_parameter_file.ode=alpha_parameters.ode;

save(save_str,'new_parameter_file');
end

function Calculate_BetaFinal_Parameters(save_str,alpha_parameter_file,beta_parameter_file)
A=load(alpha_parameter_file) ; % Placebo
B=load(beta_parameter_file); % Cusi estimated beta parameters
new_parameter_file=struct ;
new_parameter_file.markov.forward=[A.new_parameter_file.markov.forward].*[B.alpha_parameters.alpha(1:2:8)];
new_parameter_file.markov.backward=[A.new_parameter_file.markov.backward].*[B.alpha_parameters.alpha(2:2:8)];
new_parameter_file.alpha=ones(1,8) ;
new_parameter_file.progressor_probability=B.alpha_parameters.progressor_probability;
new_parameter_file.ode=B.alpha_parameters.ode ;
save(save_str,'new_parameter_file');
end