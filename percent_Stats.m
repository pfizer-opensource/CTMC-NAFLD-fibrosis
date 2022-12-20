function[meanpercent,percentile2,percentile]=percent_Stats(Change_percent_save)
% This function converts the percent change variable into stats for each N
N=[10:5:100];

for i=1:1:numel(Change_percent_save(:,1))
    
    meanpercent(i)=mean(Change_percent_save(i,:));           %Mean     
    %std_Dev(i)=std(Change_percent_save(i,:));%/(sqrt(N(i)));                %Std of the mean
    percentile(i,:)=prctile(Change_percent_save(i,:),[5 95]); %Calculate 90th percentiles of the data
%CI95(i,:) = tinv([0.025 0.975], (i*5-1));                    % Calculate 95% Probability Intervals Of t-Distribution
%yCI95(i,:) = bsxfun(@times, std_Dev(i), CI95(i,:));          % 95% confidence intervals
end
percentile2(2,:)=percentile(:,2)-meanpercent(1,:)'; % upper bounds
percentile2(1,:)=meanpercent(1,:)'-percentile(:,1); % lower bounds
