%% Step 5: Power Analysis
% Generates Figure 6
% Plots Power vs. Sample Size of Patient population using two-sample t-test

Weight=[0.346,0.435,0.099,0.1188,0] ; % Weighted distribution of patients in each stage of fibrosis
T_end=18 ;                            % Duration (Months)
NMAX = 105 ;                          % Maximum number of patients to simulate
fit_flag=1;
Power_Calculations1(Weight,NMAX,T_end,fit_flag) ; % Run Analysis to generate figure 6

%% Helper functions
function Calculate_Final_Parameters(save_str,parameter_file)
load(parameter_file) ;
new_parameter_file=struct ;
new_parameter_file.markov.forward=[alpha_parameters.markov.forward].*[alpha_parameters.alpha(1:2:8)];
new_parameter_file.markov.backward=[alpha_parameters.markov.backward].*[alpha_parameters.alpha(2:2:8)];
new_parameter_file.alpha=1 ;
new_parameter_file.progressor_probability=alpha_parameters.progressor_probability;
new_parameter_file.ode=alpha_parameters.ode;

save(save_str,'new_parameter_file');
end

function Calculate_BetaFinal_Parameters(save_str,alpha_parameter_file,beta_parameter_file)
A=load(alpha_parameter_file) ;
B=load(beta_parameter_file); % Cusi estimated beta parameters
new_parameter_file=struct ;
new_parameter_file.markov.forward=[A.new_parameter_file.markov.forward].*[B.alpha_parameters.alpha(1:2:8)];
new_parameter_file.markov.backward=[A.new_parameter_file.markov.backward].*[B.alpha_parameters.alpha(2:2:8)];
new_parameter_file.alpha=1 ;
new_parameter_file.progressor_probability=B.alpha_parameters.progressor_probability;
new_parameter_file.ode=B.alpha_parameters.ode ;
save(save_str,'new_parameter_file');
end