function [var]=Parameter_Sweep(sweep_values,parameter_file,Data)
    % var_flag = 0 is for placebo parameters
    var_flag =0;

for h=1:numel(parameter_file.final_parameters.markov.forward)
    for ix = 1:length(sweep_values)
    load ('Save_Results1','log_p','final_parameters')    
    final_parameters.markov.forward(h)=final_parameters.markov.forward(h)*sweep_values(ix);
    [score_struc_for, NF_total]=simdataGenN(final_parameters,Data,var_flag);
    save_struc_forward(ix,:)=score_struc_for ;
    end
    var(h).for=save_struc_forward ;
end

% Parameter sweep for backward parameters
for h=1:numel(parameter_file.final_parameters.markov.backward)
    for ix = 1:length(sweep_values)
    load ('Save_Results1','log_p','final_parameters')  
    final_parameters.markov.backward(h)=final_parameters.markov.backward(h)*sweep_values(ix);
    [score_struc_back, NF_total]=simdataGenN(final_parameters,Data,var_flag);
    save_struc_backward(ix,:)=score_struc_back ;
    end
    var(h).back=save_struc_backward ;
end     