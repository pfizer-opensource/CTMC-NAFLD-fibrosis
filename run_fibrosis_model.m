function [T,Y,X] = run_fibrosis_model(react_struc,progressor_flag,initialx,Tend,T,Y,plot_flag)

%% Run fibrosis markov chain model

% react_struct - model definition
% progressor_flag (0 never leave F0 if you start there, 1 leave at normal rate)
% initialx - which state you start in
% Tend - simulation length in months
% plot_flag plot the path you took

% set the forward rate slow if you are progressing
if progressor_flag==0 && initialx==1
    react_struc(1).rate(1)= {1e-20*Y(:,1)./Y(:,1)}; % F0->F1 rate
end


%% initialize some variables

% Running_t time variable to keep track of simulation time
running_t=0; % months
% What state you are in currently
xcurrent=initialx;
% Keep track of which state you are in at time T 
X=zeros(size(T));
% index 
Icurrent=1;
% Store the state outuput
X(Icurrent)=initialx;

%% Run the model
while running_t <= Tend
  
    % Calculate the reaction time and new state 
    [tauout,xnew] = next_reaction(xcurrent,react_struc,running_t);
    
    % Add the reaction time to the total
    running_t=running_t+tauout;
 
    % Find the closest time index
    [~,Inew]=min(abs(T-running_t));
    
    % Label the states for which you were in the old state
    X((Icurrent+1):(Inew))=xcurrent;
    % Update state and index
    xcurrent=xnew;
    Icurrent=Inew;
end


%% Tidy up the last part (needed in case reaction time is longer than trial)
X(end)=X(end-1); % Don't switch on the last time point

if X(end)==0
   first_zero=find(X,1,'last')+1;
   X(first_zero:end)=X(first_zero-1);
end


%% Plot the trajectory  of  an individual
if plot_flag==1
   Xplot=X;
   Xplot(Xplot==6)=0;
   
   
    h=plotyy(T, Xplot,T, Y);
    
    axes1=h(1);
    axes2=h(2);
    
    set(axes1,'FontSize',20,'YColor',[0 0.447 0.741],'YTick',[1 2 3 4 5],...
    'YTickLabel',{'F0','F1','F2','F3','F4'});
    ylim([0,5]);
    xlabel('Time (months)');
    set(axes2,'Color','none','FontSize',20,'HitTest','off','YAxisLocation',...
    'right','YColor',[0.85 0.325 0.098],'YTick',[0:5:35]);
end

end
