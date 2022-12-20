function [react_struc,T,Y] = fibrosis_model_construct(parameters,IC,Tend,var_flag)
% var_flag  = 0 is for placebo parameter fits
% var_flag = 1 is forward parameter fitting (alpha parameters)
% var_flag = 2 is forward  and reverse parameter fitting (beta parameters)

%% Extract the parameters from the function input
q=parameters.ode; % Set of parameters to illustrate coupling to ODE model
%p(1:2:8)=parameters.markov.forward;
%p(2:2:8)=parameters.markov.backward;
%p(9)=parameters.progressor_probability;
%p(10:1:17)=parameters.alpha;


%% An example of how to couple an ODE to this code
Tin=0:1:Tend;
f=@(t,x)ctmc_odes(t,x,q);
[T,Y]=ode15s(f,Tin,IC);


%% Build a structure to build the model

%react_struc(i) reactions at ith node
%react_struc(i).possible, possible transitions
%react_struc(i).possible(j).constant, logical 0 if rate is function of time
%react_struc(i).possible(j).time, rate time points (nan if constant)
%react_struc(i).possible(j).rate, double if constant, double vector if not.

if var_flag ==0
    p(1:2:8)=parameters.markov.forward;
    p(2:2:8)=parameters.markov.backward;
    p(9)=parameters.progressor_probability;
    
    % F0->F1
    react_struc(1).possible(1)=2; react_struc(1).constant(1)=1; react_struc(1).rate(1)={p(1)*Y(:,1)./Y(:,1)}; react_struc(1).time(1)={T};  %replace
    react_struc(1).progressor=p(9);
    % F1->F0
    react_struc(2).possible(1)=1; react_struc(2).constant(1)=1; react_struc(2).rate(1)={p(2)}; react_struc(2).time(1)={T};
    % F1->F2
    react_struc(2).possible(2)=3; react_struc(2).constant(2)=1; react_struc(2).rate(2)={p(3)*Y(:,1)./Y(:,1)}; react_struc(2).time(2)={T}; %replace
    % F2->F1
    react_struc(3).possible(1)=2; react_struc(3).constant(1)=1; react_struc(3).rate(1)={p(4)}; react_struc(3).time(1)={T};
    % F2->F3
    react_struc(3).possible(2)=4; react_struc(3).constant(2)=1; react_struc(3).rate(2)={p(5)*Y(:,1)./Y(:,1)}; react_struc(3).time(2)={T}; %replace
    %F3->F2
    react_struc(4).possible(1)=3; react_struc(4).constant(1)=1; react_struc(4).rate(1)={p(6)}; react_struc(4).time(1)={T};
    %F3->F4
    react_struc(4).possible(2)=5; react_struc(4).constant(2)=1; react_struc(4).rate(2)={p(7)*Y(:,1)./Y(:,1)}; react_struc(4).time(2)={T}; %replace
    %F4->F3
    react_struc(5).possible(1)=4; react_struc(5).constant(1)=1; react_struc(5).rate(1)={p(8)}; react_struc(5).time(1)={T};
else
    p(1:2:8)=parameters.markov.forward;
    p(2:2:8)=parameters.markov.backward;
    p(9)=parameters.progressor_probability;
    p(10:1:17)=parameters.alpha;
    
    % F0->F1
    react_struc(1).possible(1)=2; react_struc(1).constant(1)=1; react_struc(1).rate(1)={p(10)*p(1)*Y(:,1)./Y(:,1)}; react_struc(1).time(1)={T};  %replace
    react_struc(1).progressor=p(9);
    % F1->F0
    react_struc(2).possible(1)=1; react_struc(2).constant(1)=1; react_struc(2).rate(1)={p(11)*p(2)}; react_struc(2).time(1)={T};
    % F1->F2
    react_struc(2).possible(2)=3; react_struc(2).constant(2)=1; react_struc(2).rate(2)={p(12)*p(3)*Y(:,1)./Y(:,1)}; react_struc(2).time(2)={T}; %replace
    % F2->F1
    react_struc(3).possible(1)=2; react_struc(3).constant(1)=1; react_struc(3).rate(1)={p(13)*p(4)}; react_struc(3).time(1)={T};
    % F2->F3
    react_struc(3).possible(2)=4; react_struc(3).constant(2)=1; react_struc(3).rate(2)={p(14)*p(5)*Y(:,1)./Y(:,1)}; react_struc(3).time(2)={T}; %replace
    %F3->F2
    react_struc(4).possible(1)=3; react_struc(4).constant(1)=1; react_struc(4).rate(1)={p(15)*p(6)}; react_struc(4).time(1)={T};
    %F3->F4
    react_struc(4).possible(2)=5; react_struc(4).constant(2)=1; react_struc(4).rate(2)={p(16)*p(7)*Y(:,1)./Y(:,1)}; react_struc(4).time(2)={T}; %replace
    %F4->F3
    react_struc(5).possible(1)=4; react_struc(5).constant(1)=1; react_struc(5).rate(1)={p(17)*p(8)}; react_struc(5).time(1)={T};
end
% Note about {p(1)*Y(:,1)./Y(:,1)} terms. These are written like this in
% case p is to be a function of time


end

