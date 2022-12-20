function plot_bar_fibrosis(score_struc)
% Function to plot frequency of fibrosis stage 

for i=1:numel(score_struc)
subplot(numel(score_struc),1,i)

model=score_struc(i).model;
data=score_struc(i).data;

Y=zeros(5,2);
for k=1:5
    median_count(k)=median(model(:,k));
    ub(k)=prctile(model(:,k),95)-median(model(:,k));
    lb(k)=-prctile(model(:,k),5)+median(model(:,k));
    Y(k,:)=[median_count(k) data(k)];
end

bar(Y);
    
    % Finding the number of groups and the number of bars in each group
ngroups = size(Y, 1);
nbars = size(Y, 2);

% Calculating the width for each bar group
groupwidth = min(0.8, nbars/(nbars + 1.5));
% Set the position of each error bar in the center of the main bar

% Based on barweb.m by Bolu Ajiboye from MATLAB File Exchange
for j = 1:2:nbars
     %Calculate center of each bar
xpos = (1:ngroups) - (groupwidth/2) + (2*j-1) * (groupwidth / (2*nbars));
hold on
    errorbar(xpos, Y(:,j), lb,ub, 'k', 'linestyle', 'none');
    hold off
  
    max_model=max(median_count+ub);
    max_all=max(Y(:));
    max_all(max_all==0)=1;
    ylim([0 1.2*max(max_model,max_all)])
end
set(gca,'XTickLabel',{'F0','F1','F2','F3','F4'}, 'FontSize',14);
end
subplot(5,1,1); ylabel('F0');
subplot(5,1,2); ylabel('F1');
subplot(5,1,3); ylabel({'Initial Fibrosis Stage';'F2'});
subplot(5,1,4); ylabel('F3');
subplot(5,1,5); ylabel('F4'); xlabel('End Fibrosis Stage')
end

