function [final_parameters,Data]=Fit_Fibrosis_Gen(save_str,varargin)
% Varargin inputs allows for the input of multiple data sets 
%***Very Important to make sure data sets are in chronological order***%%
%% Select the baseline parameters of the model

baseline_parameters.ode=[0.5 0.5/30];
% Forward rates of the markov chain model
baseline_parameters.markov.forward=1/12;
% Backward rates of the markov chain model
baseline_parameters.markov.backward=1/100;
% Probability you are a progressor (given you are in the first state).
baseline_parameters.progressor_probability=1;

Data=varargin;

%scoreFibrosisModel
f=@(p) scoreFibrosisModel_Gennan(p,baseline_parameters,Data);


%% Guess initial values for the model parameters
p_lower(1:2:8)=1/200; %forward rates
p_upper(1:2:8)=2;

p_lower(2:2:8)=1/2000; %back rates
p_upper(2:2:8)=1/5;

p_upper(9)=1;  % probability_of_being a progressor
p_lower(9)=0.2;

% Fit parameters on the log scale (this helps if they are different orders
% of magnitude)
p_lower_log=log(p_lower);
p_upper_log=log(p_upper);

%% Set-up genetic algorithm to fit the parameters
options=optimoptions('ga');
options.UseParallel = false; %Changed to zero from 1
%options.Display='iter';
options.MaxGenerations=100;
options.PopulationSize=50; 


[x,fval]=ga(f,9,[],[],[],[],p_lower_log,p_upper_log,[],options);

final_parameters=baseline_parameters;
final_parameters.markov.forward=exp(x(1:2:8));
final_parameters.markov.backward=exp(x(2:2:8));
final_parameters.progressor_probability=exp(x(9));

log_p=x;

% Save the final parameters
save(save_str,'final_parameters','log_p','fval')

end