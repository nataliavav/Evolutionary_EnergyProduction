clear all
clc
global Violmod l h 
l=50;  %���������
m=10;  %����������
h=24;  %���� �����������
sum = [ 1036 1110 1258 1406 1480 1628 1702 1776 1924 2072 2146 2220 2072 1924 1776 1554 1480 1628 1776 2072 1924 1628 1332 1184 ];
pmax = [ 470 460 340 300 243 160 130 120 80 55 ];
pmin = [ 150 135 73 60 73 57 20 47 20 55 ];
Vmax = 20*.01*(pmax-pmin);
phi = [ 2 2 ];
e = 10^-6;
EPANAL=1000;
%������� ������� �,V, �� ������� �����
for i=1:l           
    for k=1:h
        for j=1:m
         P(i,j,k)=(pmax(j)-pmin(j))*rand+pmin(j);
         V(i,j,k)=(Vmax(j)+Vmax(j))*rand-Vmax(j);
        end
    end
end
%����������� ������� ����������
for i=1:l
    for k=1:h
    Viol(i,k)=sum(k);
        for j=1:m
         Viol(i,k)=Viol(i,k)-P(i,j,k);
        end
        if abs(Viol(i,k))<e
            Viol(i,k)=0;
        end
        if Viol(i,k)<0                  %��� ������� �
            Violmod(i,k)=Viol(i,k);     %
            Viol(i,k)=0;                %
        else                            %
            Violmod(i,k)=Viol(i,k);     %
        end                             %
    end
end
%����������� ������� ��������� ������� ���������
for i=1:l
    ftot(i)=0;
    for k=1:h
    f(i,k)=(0.00043*P(i,1,k)^2+21.60*P(i,1,k)+958.20)+(0.00063*P(i,2,k)^2+21.05*P(i,2,k)+1131.60)+(0.00039*P(i,3,k)^2+20.81*P(i,3,k)+604.97)+(0.00070*P(i,4,k)^2+23.90*P(i,4,k)+471.60)+(0.00079*P(i,5,k)^2+21.62*P(i,5,k)+480.29)+(0.00056*P(i,6,k)^2+17.87*P(i,6,k)+601.75)+(0.00211*P(i,7,k)^2+16.51*P(i,7,k)+502.70)+(0.00480*P(i,8,k)^2+23.23*P(i,8,k)+639.40)+(0.10908*P(i,9,k)^2+19.58*P(i,9,k)+455.60)+(0.00951*P(i,10,k)^2+22.54*P(i,10,k)+692.40)+10000*nn(i,k);
    ftot(i)=f(i,k)+ftot(i);
    end
end
%����������� ARXIKOY PERSONAL BEST
for i=1:l
    for k=1:h
        for j=1:m
         Pbest(i,j,k)=P(i,j,k);
        end
        fbest(i,k)=f(i,k);
        Violbest(i,k)=Viol(i,k);
    end
end
%����������� ARXIKOY GLOBAL BEST �� SUPERIORITY OF FEASIBLE SOLUTIONS
for k=1:h
    [Violg(k),n(k)]=min(Violbest(:,k));
    fbestg(k)=fbest(n(k),k);
end
for j=1:m
    for k=1:h
     Pbestg(k,j)=Pbest(n(k),j,k);
    end
end
%���� ������������� �����������
for count=1:EPANAL
    %����������� ��������� ��� ���� ������ P
     for i=1:l
        for j=1:2
        U(i,j)=rand;
        end
    end
    for i=1:l
        for j=1:m
            for k=1:h
             V(i,j,k)=V(i,j,k)+phi(1)*U(i,1)*(Pbest(i,j,k)-P(i,j,k))+phi(2)*U(i,2)*(Pbestg(k,j)-P(i,j,k));
             %������� ���������� ����������� ���������
             if V(i,j,k)>Vmax(j) 
              V(i,j,k)= Vmax(j);
             end
             if V(i,j,k)<-Vmax(j)
              V(i,j,k)= -Vmax(j); 
             end
             P(i,j,k)=P(i,j,k)+V(i,j,k);
             %�������� ��� ����� ����� ������
             if P(i,j,k)>pmax(j)     %%%%%%%%%%%%%%%%%%%%
              P(i,j,k)=pmax(j);
             end
             if P(i,j,k)<pmin(j)
              P(i,j,k)=pmin(j);
             end               
            end
        end
    end
    %����������� ����������
    for i=1:l
        for k=1:h
         Viol(i,k)=sum(k);
            for j=1:m
             Viol(i,k)=Viol(i,k)-P(i,j,k);
            end
            if abs(Viol(i,k))<e
                Viol(i,k)=0;
            end
            if Viol(i,k)<0                 %��� ������� �
             Violmod(i,k)=Viol(i,k);       %
             Viol(i,k)=0;                  %
            else                           %
             Violmod(i,k)=Viol(i,k);       %
            end                            %
        end
    end
   %����������� ��������� ������� ���������
    for i=1:l
        ftot(i)=0;
        for k=1:h
         f(i,k)=(0.00043*P(i,1,k)^2+21.60*P(i,1,k)+958.20)+(0.00063*P(i,2,k)^2+21.05*P(i,2,k)+1131.60)+(0.00039*P(i,3,k)^2+20.81*P(i,3,k)+604.97)+(0.00070*P(i,4,k)^2+23.90*P(i,4,k)+471.60)+(0.00079*P(i,5,k)^2+21.62*P(i,5,k)+480.29)+(0.00056*P(i,6,k)^2+17.87*P(i,6,k)+601.75)+(0.00211*P(i,7,k)^2+16.51*P(i,7,k)+502.70)+(0.00480*P(i,8,k)^2+23.23*P(i,8,k)+639.40)+(0.10908*P(i,9,k)^2+19.58*P(i,9,k)+455.60)+(0.00951*P(i,10,k)^2+22.54*P(i,10,k)+692.40)+10000*nn(i,k);
         ftot(i)=f(i,k)+ftot(i);
        end
    end
    %����������� PERSONAL BEST �� SUPERIORITY OF FEASIBLE SOLUTIONS
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
    %����������� GLOBAL BEST �� SUPERIORITY OF FEASIBLE SOLUTIONS
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
    %������ ������� ��������� ��� ��� �� ����
    ftot=0;
    for k=1:h
        ftot=ftot+fbestg(k);
    end
end
Pbestg
ftot

%---------------------------------------------------------------------------------------

%��������� ����������� ���������� ����������� ���������
function nonnegative = nn(x,y)
global Violmod l h 
if Violmod(x,y)>0
nonnegative=0;
else
nonnegative=-Violmod(x,y);
end
end
