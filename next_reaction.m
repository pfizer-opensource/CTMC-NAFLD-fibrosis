function [tauout,xnew] = next_reaction(xcurrent,react_struc,tcurrent)

%react_struc

%react_struc(i) reactions at ith node
%react_struc(i).possible, possible transitions
%react_struc(i).possible(j).constant, logical 0 if rate is function of time
%react_struc(i).possible(j).time, rate time points (nan if constant)
%react_struc(i).possible(j).rate, double if constant, double vector if not.

this_react=react_struc(xcurrent);


N_of_reacts=numel(this_react.possible);


T=cell2mat(this_react.time(1));
tau=zeros(N_of_reacts,1);

%% Calculate the next reaction 
% See J Chem Thanh et al., 2015 
for j=1:N_of_reacts

    if this_react.constant(j)==1
    lambda=cell2mat(this_react.rate(j));
    tau(j)=log(1/rand)/lambda(1);
    end
    if this_react.constant(j)~=1
    rate_t_course=cell2mat(this_react.rate(j));
    tau(j)=backsolve_rate(rate_t_course,T,tcurrent);
    end
    
end

[tauout,new_idx]=min(tau);

xnew=this_react.possible(new_idx);
end

