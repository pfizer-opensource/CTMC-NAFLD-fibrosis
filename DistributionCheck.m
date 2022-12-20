
function DistributionCheck(FinalDist1,score_struc)
% Plot Model prediction of the final distribution against initial
% distribution

    for i=1:5
        F0(i)=median(score_struc(i).model(:,1));
        F1(i)=median(score_struc(i).model(:,2));
        F2(i)=median(score_struc(i).model(:,3));
        F3(i)=median(score_struc(i).model(:,4));
        F4(i)=median(score_struc(i).model(:,5));



        ubF0(i)=prctile(score_struc(i).model(:,1),95)-F0(i);
        lbF0(i)=-prctile(score_struc(i).model(:,1),5)+F0(i);
        ubF1(i)=prctile(score_struc(i).model(:,2),95)-F1(i);
        lbF1(i)=-prctile(score_struc(i).model(:,2),5)+F1(i);
        ubF2(i)=prctile(score_struc(i).model(:,3),95)-F2(i);
        lbF2(i)=-prctile(score_struc(i).model(:,3),5)+F2(i);
        ubF3(i)=prctile(score_struc(i).model(:,4),95)-F3(i);
        lbF3(i)=-prctile(score_struc(i).model(:,4),5)+F3(i);
        ubF4(i)=prctile(score_struc(i).model(:,5),95)-F4(i);
        lbF4(i)=-prctile(score_struc(i).model(:,5),5)+F4(i);
    end


F0=sum(F0);
F1=sum(F1);
F2=sum(F2);
F3=sum(F3);
F4=sum(F4);

ub=[median(ubF0),median(ubF1), median(ubF2), median(ubF3), median(ubF4)];

lb=[median(lbF0),median(lbF1), median(lbF2), median(lbF3), median(lbF4)];


FinalDist=[F0,F1,F2,F3,F4]; %Final predicted Distribution
FinalDist1 = FinalDist1' ;   %Observed Final Distribution
FinalDist =FinalDist' ;
Y=[FinalDist, FinalDist1];

bar(Y,'group')

ngroups = size(Y, 1);
nbars = size(Y, 2);

%Add Ymax
max_all=max(FinalDist);
ylim([0 2*max_all]);


% Calculating the width for each bar group
groupwidth = min(0.8, nbars/(nbars + 1.5));
% Set the position of each error bar in the centre of the main bar
% Based on barweb.m by Bolu Ajiboye from MATLAB File Exchange
    for j = 1:2:nbars
        %Calculate center of each bar
        xpos = (1:ngroups) - (groupwidth/2) + (2*j-1) * (groupwidth / (2*nbars));
        hold on
        errorbar(xpos, Y(:,j), lb,ub, 'k', 'linestyle', 'none');
        hold off

    end


set(gca,'XTickLabel',{'F0','F1','F2','F3','F4'}, 'FontSize',14);
ylabel('Frequency')