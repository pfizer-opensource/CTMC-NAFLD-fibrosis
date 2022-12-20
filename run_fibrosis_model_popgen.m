function [table] = run_fibrosis_model_popgen(N,distribution,react_struc,T_end,Tvec,Tvector,Y)

% N number of times to run
% distribution - fraction of people in each stage
% react_struct - model definition
% Tend how long you need to run
% Tvector and Y, ODE results Tvector is months
% Tvec is time outputs

% Initialize where we are going to collect the data (how many people ended
% up in each stage)
   if N<=0
         for m=1:numel(Tvec)
         c=[0 0 0 0 0];
         table{m}=c;
         end
   else
            

        for k=1:numel(Tvec)
        count=zeros(1,5);
 
        % Probability if you start in F0 that you leave it
        prog_prob=react_struc(1).progressor;

            for i=1:numel(distribution)

               for j=1:round(N*distribution(i))

                     % for each person j roll dice to see if they progress.
                    if i==1
                    progressor_flag=random('bino',1,prog_prob);
                    else
                    progressor_flag=1;
                    end    

                % Run the markov chain model for one person starting in state i. 
                [T,Y,X] = run_fibrosis_model(react_struc,progressor_flag,i,T_end,Tvector,Y,0);

                % output is 
                A=Tvec(1,k);
                count(X(A))=count(X(A))+1;
                table{k}=count;
               end
            end
        end
    
    end
end

