function [SD_change]=SD_sum_Change(SD_Vector,Total_N)
 
%% Calculate the standard deviation of change in fibrosis score for each individualt trial
  
for i =1: numel(SD_Vector(:,1))

       nplus1(i)=SD_Vector(i,1)/1 ;
       nplus2(i)=SD_Vector(i,2)/2 ;
       nplus3(i)=SD_Vector(i,3)/3 ;
       nplus4(i)=SD_Vector(i,4)/4 ;
       nneg1(i)= SD_Vector(i,5)/-1;
       nneg2(i)= SD_Vector(i,6)/-2;
       nneg3(i)= SD_Vector(i,7)/-3;
       nneg4(i)= SD_Vector(i,8)/-4;

    Nchange(i,:)=[nplus1(i), nplus2(i), nplus3(i), nplus4(i), nneg1(i), nneg2(i), nneg3(i), nneg4(i)];
    Ndiff(i)=sum(Nchange(i,:));
    % Place patients in individual patient change
    N_no_change(i)=(Total_N-Ndiff(i)) ;
    Indv_Patient_change=[] ;

    
    for h=1:N_no_change(i)
        Indv_Patient_change(h) = 0 ;
    end
 
     if nplus1(i) ~=0
        A= numel(Indv_Patient_change);
        B=A+nplus1(i) ;
        for j=A+1:B
             Indv_Patient_change=1 ;
        end
     end
     if nplus2(i) ~=0
        A= numel(Indv_Patient_change);
        B=A+nplus2(i) ;
        for k=A+1:B
             Indv_Patient_change(k)=2 ;
        end
     end
     if nplus3(i) ~=0
        A=numel(Indv_Patient_change);
        B=A+nplus3(i);
        for m=A+1:B
             Indv_Patient_change(m)=3 ;
        end
     end
     if nplus4(i) ~= 0
        A= numel(Indv_Patient_change);
        B=A+nplus4(i) ;
        for p=A+1:B
             Indv_Patient_change(p)=4 ;
        end
     end
     if nneg1(i) ~= 0
        A= numel(Indv_Patient_change);
        B=A+nneg1(i) ;
         for q=A+1:B
            Indv_Patient_change(q)=-1 ;
         end
     end
    if nneg2(i) ~= 0
        A= numel(Indv_Patient_change);
        B=A+nneg2(i) ;
        for r=A+1:B
             Indv_Patient_change(r)=-2 ;
         end
    elseif nneg3(i) ~= 0
        A= numel(Indv_Patient_change);
        B=A+nneg3(i) ;
        for s=A+1:B
             Indv_Patient_change(s)=-3 ;
        end
    end
    if nneg4(i) ~= 0
        A= numel(Indv_Patient_change);
        B=A+nneg4(i) ;
        for z=A+1:B
             Indv_Patient_change(z)=-4 ;
        end
    end
     
     SD_change(i)=std(Indv_Patient_change) ;

end
    