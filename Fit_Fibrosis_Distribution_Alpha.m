function [final_parameters,Data]=Fit_Fibrosis_Distribution_Alpha(Data2,Initial_Parameters,Actual_Change,var_flag,varargin)
% var_flag = 1 is forward parameter fitting (alpha parameters)
% var_flag = 2 is forward  and reverse parameter fitting (beta parameters)
% Varargin inputs allows for the input of multiple data sets
%% Load the baseline parameters of the model

% ignore this unless you have time dependent rates in the model goverened
% by ODEs
baseline_parameters.ode=[0.5 0.5/30];

% the forward rates of the markov chain model
baseline_parameters.markov.forward=Initial_Parameters.markov.forward;
% the backward rates of the markov chain model
baseline_parameters.markov.backward =Initial_Parameters.markov.backward;
% the probability you are a progressor (given you are in the first state).
baseline_parameters.progressor_probability=Initial_Parameters.progressor_probability;
% alpha term
baseline_parameters.alpha=1;

Data=varargin;

%scoreFibrosisModel
f=@(p) scoreFibrosisModel_DistributionDelta(p,baseline_parameters,Actual_Change,Data,Data2);


%% guess initial values for the model parameters %p(1:9) fixed to placebo parameters
p_lower(1:2:8)=baseline_parameters.markov.forward ;
p_upper(1:2:8)=baseline_parameters.markov.forward ;
p_upper(2:2:8)=baseline_parameters.markov.backward ;
p_lower(2:2:8)=baseline_parameters.markov.backward ;
p_lower(9)=baseline_parameters.progressor_probability ;
p_upper(9)=baseline_parameters.progressor_probability ;

if var_flag== 1
    p_upper(10:1:17)=[5,1,5,1,5,1,5,1];
    p_lower(10:1:17)=[0.2,1,.2,1,.2,1,.2,1];
elseif var_flag==2
    p_upper(10:1:17)=[5,5,5,5,5,5,5,5];
    % ignore this unless you have time dependent rates in the model goverened
    % by ODEs
    baseline_parameters.ode=[0.5 0.5/30];
    
    % the forward rates of the markov chain model
    baseline_parameters.markov.forward=Initial_Parameters.markov.forward;
    % the backward rates of the markov chain model
    baseline_parameters.markov.backward =Initial_Parameters.markov.backward;
    % the probability you are a progressor (given you are in the first state).
    baseline_parameters.progressor_probability=Initial_Parameters.progressor_probability;
    % alpha term
    baseline_parameters.alpha=1;
    p_lower(10:1:17)=[.2,.2,.2,.2,.2,.2,.2,.2];
end

% fit parameters on the log scale (this helps if they are different orders
% of magnitude
p_lower_log=log(p_lower);
p_upper_log=log(p_upper);

%% set up genetic algorithm to fit the parameters.
options=optimoptions('ga');
options.UseParallel=false;
options.MaxGenerations=200;
options.PopulationSize=100;
options.FunctionTolerance=1.0e-6;

[x,fval]=ga(f,17,[],[],[],[],p_lower_log,p_upper_log,[],options);

final_parameters=baseline_parameters;
final_parameters.markov.forward=exp(x(1:2:8));
final_parameters.markov.backward=exp(x(2:2:8));
final_parameters.progressor_probability=exp(x(9));
final_parameters.alpha=exp(x(10:1:17));

log_p=x;


end