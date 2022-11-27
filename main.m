clear all
clc
global Violmod l h 
l=50;  %ПКГХУСЛЭР
m=10;  %ЕЯЦОСТэСИА
h=24;  %ЧЯЕР КЕИТОУЯЦъАР
sum = [ 1036 1110 1258 1406 1480 1628 1702 1776 1924 2072 2146 2220 2072 1924 1776 1554 1480 1628 1776 2072 1924 1628 1332 1184 ];
pmax = [ 470 460 340 300 243 160 130 120 80 55 ];
pmin = [ 150 135 73 60 73 57 20 47 20 55 ];
Vmax = 20*.01*(pmax-pmin);
phi = [ 2 2 ];
e = 10^-6;
EPANAL=1000;
%целисла пимайым я,V, ле туваиес тилес
for i=1:l           
    for k=1:h
        for j=1:m
         P(i,j,k)=(pmax(j)-pmin(j))*rand+pmin(j);
         V(i,j,k)=(Vmax(j)+Vmax(j))*rand-Vmax(j);
        end
    end
end
%упокоцислос аявийгс паяабиасгс
for i=1:l
    for k=1:h
    Viol(i,k)=sum(k);
        for j=1:m
         Viol(i,k)=Viol(i,k)-P(i,j,k);
        end
        if abs(Viol(i,k))<e
            Viol(i,k)=0;
        end
        if Viol(i,k)<0                  %циа еяытгла а
            Violmod(i,k)=Viol(i,k);     %
            Viol(i,k)=0;                %
        else                            %
            Violmod(i,k)=Viol(i,k);     %
        end                             %
    end
end
%упокоцислос аявийоу сумокийоу йостоус паяацыцгс
for i=1:l
    ftot(i)=0;
    for k=1:h
    f(i,k)=(0.00043*P(i,1,k)^2+21.60*P(i,1,k)+958.20)+(0.00063*P(i,2,k)^2+21.05*P(i,2,k)+1131.60)+(0.00039*P(i,3,k)^2+20.81*P(i,3,k)+604.97)+(0.00070*P(i,4,k)^2+23.90*P(i,4,k)+471.60)+(0.00079*P(i,5,k)^2+21.62*P(i,5,k)+480.29)+(0.00056*P(i,6,k)^2+17.87*P(i,6,k)+601.75)+(0.00211*P(i,7,k)^2+16.51*P(i,7,k)+502.70)+(0.00480*P(i,8,k)^2+23.23*P(i,8,k)+639.40)+(0.10908*P(i,9,k)^2+19.58*P(i,9,k)+455.60)+(0.00951*P(i,10,k)^2+22.54*P(i,10,k)+692.40)+10000*nn(i,k);
    ftot(i)=f(i,k)+ftot(i);
    end
end
%упокоцислос ARXIKOY PERSONAL BEST
for i=1:l
    for k=1:h
        for j=1:m
         Pbest(i,j,k)=P(i,j,k);
        end
        fbest(i,k)=f(i,k);
        Violbest(i,k)=Viol(i,k);
    end
end
%упокоцислос ARXIKOY GLOBAL BEST ле SUPERIORITY OF FEASIBLE SOLUTIONS
for k=1:h
    [Violg(k),n(k)]=min(Violbest(:,k));
    fbestg(k)=fbest(n(k),k);
end
for j=1:m
    for k=1:h
     Pbestg(k,j)=Pbest(n(k),j,k);
    end
end
%аявг епамакгптийгс диадийасиас
for count=1:EPANAL
    %упокоцислос тавутгтас йаи меас цемиас P
     for i=1:l
        for j=1:2
        U(i,j)=rand;
        end
    end
    for i=1:l
        for j=1:m
            for k=1:h
             V(i,j,k)=V(i,j,k)+phi(1)*U(i,1)*(Pbest(i,j,k)-P(i,j,k))+phi(2)*U(i,2)*(Pbestg(k,j)-P(i,j,k));
             %екецвос паяабиасгс пеяиояислоу тавутгтас
             if V(i,j,k)>Vmax(j) 
              V(i,j,k)= Vmax(j);
             end
             if V(i,j,k)<-Vmax(j)
              V(i,j,k)= -Vmax(j); 
             end
             P(i,j,k)=P(i,j,k)+V(i,j,k);
             %апояяиьг тым ейтос ояиым кусеым
             if P(i,j,k)>pmax(j)     %%%%%%%%%%%%%%%%%%%%
              P(i,j,k)=pmax(j);
             end
             if P(i,j,k)<pmin(j)
              P(i,j,k)=pmin(j);
             end               
            end
        end
    end
    %упокоцислос паяабиасгс
    for i=1:l
        for k=1:h
         Viol(i,k)=sum(k);
            for j=1:m
             Viol(i,k)=Viol(i,k)-P(i,j,k);
            end
            if abs(Viol(i,k))<e
                Viol(i,k)=0;
            end
            if Viol(i,k)<0                 %циа еяытгла а
             Violmod(i,k)=Viol(i,k);       %
             Viol(i,k)=0;                  %
            else                           %
             Violmod(i,k)=Viol(i,k);       %
            end                            %
        end
    end
   %упокоцислос сумокийоу йостоус паяацыцгс
    for i=1:l
        ftot(i)=0;
        for k=1:h
         f(i,k)=(0.00043*P(i,1,k)^2+21.60*P(i,1,k)+958.20)+(0.00063*P(i,2,k)^2+21.05*P(i,2,k)+1131.60)+(0.00039*P(i,3,k)^2+20.81*P(i,3,k)+604.97)+(0.00070*P(i,4,k)^2+23.90*P(i,4,k)+471.60)+(0.00079*P(i,5,k)^2+21.62*P(i,5,k)+480.29)+(0.00056*P(i,6,k)^2+17.87*P(i,6,k)+601.75)+(0.00211*P(i,7,k)^2+16.51*P(i,7,k)+502.70)+(0.00480*P(i,8,k)^2+23.23*P(i,8,k)+639.40)+(0.10908*P(i,9,k)^2+19.58*P(i,9,k)+455.60)+(0.00951*P(i,10,k)^2+22.54*P(i,10,k)+692.40)+10000*nn(i,k);
         ftot(i)=f(i,k)+ftot(i);
        end
    end
    %упокоцислос PERSONAL BEST ле SUPERIORITY OF FEASIBLE SOLUTIONS
    for i=1:l
        for k=1:h
         if Viol(i,k)<Violbest(i,k)         
            Violbest(i,k)=Viol(i,k);
            fbest(i,k)=f(i,k);
            for j=1:m
                Pbest(i,j,k)=P(i,j,k);
            end
         elseif Viol(i,k) == Violbest(i,k)   
            if f(i,k)<fbest(i,k)
               Violbest(i,k)=Viol(i,k);
               fbest(i,k)=f(i,k);
               for j=1:m
                Pbest(i,j,k)=P(i,j,k);
               end 
            end                           
         end
        end
    end
    %упокоцислос GLOBAL BEST ле SUPERIORITY OF FEASIBLE SOLUTIONS
    for k=1:h                                 
        for i=1:l
            if Violbest(i,k)<Violg(k)
             Violg(k)=Violbest(i,k);
             fbestg(k)=fbest(i,k);
             for j=1:m
              Pbestg(k,j)=Pbest(i,j,k);
             end
            elseif Violbest(i,k)==Violg(k)   
             if fbest(i,k)<fbestg(k)
              Violg(k)=Violbest(i,k);
              fbestg(k)=fbest(i,k);
              for j=1:m
               Pbestg(k,j)=Pbest(i,j,k);
              end 
             end                                   
            end
        end
    end                                      
    %еуяесг йостоус паяацыцгс циа окг тг леяа
    ftot=0;
    for k=1:h
        ftot=ftot+fbestg(k);
    end
end
Pbestg
ftot

%---------------------------------------------------------------------------------------

%сумаятгсг упокоцислоу пеяиссеиас паяацолемгс емеяцеиас
function nonnegative = nn(x,y)
global Violmod l h 
if Violmod(x,y)>0
nonnegative=0;
else
nonnegative=-Violmod(x,y);
end
end
