%class percentage plot program
nrx=1                                       %1 = pedaling, 2 = towing 3 = no hands
% speeds in the different measurements
speed=[5 10 15 20 25 30 30 25 20 15 10 5 4 3 2];
speednh=[30 25 20 18 16 15 14];

%Transforming the different modes into classes for each run

%1 = longitudenal / lateral
%2 = pedaling + upper body steer
%3 = steer + yaw + roll
%4 = bounce
%5 = knees
%6 = Other

%       1 2 3 4 5 6                    component
r3052= [1 0 0 0 0 0;...                 %1
        0 1 0 0 0 0;...                 %2
        1 0 0 0 0 0;...                 %3
        0 1 0 0 0 0;...                 %4
        0 0 0 0 0 1;...                 %5
        0 0 1 0 0 0;...                 %6
        0 0 1 0 0 0;...                 %7
        0 0 0 0 0 1;...                 %8
        0 0 0 1 0 0;...                 %9
        0 0 0 1 0 0];                   %10
    
r3053= [1 0 0 0 0 1;...                 %1
        0 1 0 0 0 0;...                 %2
        0 1 0 0 0 0;...                 %3
        0 1 0 0 0 0;...                 %4
        1 0 0 0 0 1;...                 %5
        0 0 1 0 0 0;...                 %6
        1 0 0 0 0 1;...                 %7
        0 0 0 0 0 1;...                 %8
        0 0 1 0 0 0;...                 %9
        0 0 0 1 0 0];                   %10

r3054= [1 0 0 0 0 0;...                 %1
        0 1 0 0 0 0;...                 %2
        0 1 0 0 0 0;...                 %3
        1 0 0 0 0 0;...                 %4
        0 0 1 0 0 0;...                 %5
        0 0 1 0 0 0;...                 %6
        0 0 0 1 0 0;...                 %7
        0 0 0 0 0 1;...                 %8
        0 0 0 0 0 1;...                 %9
        1 0 0 0 0 1];                   %10
    
r3055= [1 0 0 0 0 0;...                 %1
        0 1 0 0 0 0;...                 %2
        1 0 0 0 0 0;...                 %3
        0 1 0 0 0 0;...                 %4
        0 0 1 0 0 0;...                 %5
        0 0 1 0 0 0;...                 %6
        0 0 0 0 0 1;...                 %7
        0 0 0 1 0 0;...                 %8
        0 0 1 0 0 1;...                 %9
        0 0 0 0 0 1] ;                  %10
    
r3056= [0 1 0 0 0 0;...                 %1
        1 0 0 0 0 0;...                 %2
        0 1 0 0 0 0;...                 %3
        1 0 0 0 0 0;...                 %4
        0 0 1 0 0 0;...                 %5
        0 0 0 1 0 0;...                 %6
        0 0 0 1 0 0;...                 %7
        0 0 0 1 0 0;...                 %8
        0 0 0 0 0 1;...                 %9
        0 0 0 0 0 1] ;                  %10
    
r3057= [0 1 0 0 0 0;...                 %1
        0 1 0 0 0 0;...                 %2
        0 1 0 0 0 0;...                 %3
        1 0 0 0 0 0;...                 %4
        0 0 1 0 0 0;...                 %5
        0 0 1 1 0 0;...                 %6
        0 0 0 1 0 0;...                 %7
        0 0 0 1 0 0;...                 %8
        0 0 0 0 0 1;...                 %9
        0 0 0 0 0 1];                   %10
    
r3058= [1 0 0 0 0 0;...                 %1
        0 1 0 0 0 0;...                 %2
        0 1 0 0 0 0;...                 %3
        0 1 0 0 0 0;...                 %4
        0 0 0 0 0 1;...                 %5
        1 0 0 0 0 1;...                 %6
        0 0 1 0 0 0;...                 %7
        0 0 0 1 0 0;...                 %8
        0 0 0 1 0 0;...                 %9
        0 0 1 1 0 0];                   %10
    
r3059= [1 0 0 0 0 0;...                 %1
        0 1 0 0 0 0;...                 %2
        0 1 0 0 0 0;...                 %3
        1 0 0 0 0 0;...                 %4
        0 0 1 0 0 0;...                 %5
        0 0 1 0 0 0;...                 %6
        0 0 0 1 0 0;...                 %7
        0 0 0 1 0 0;...                 %8
        0 0 0 0 0 1;...                 %9
        0 0 0 0 0 1];                   %10
    
r3060= [1 0 0 0 0 0;...                 %1
        0 1 0 0 0 0;...                 %2
        0 1 0 0 0 0;...                 %3
        1 0 0 0 0 0;...                 %4
        0 0 1 0 0 0;...                 %5
        0 0 1 0 0 0;...                 %6
        0 0 0 1 0 0;...                 %7
        0 0 0 1 0 0;...                 %8
        0 0 0 0 0 1;...                 %9
        0 0 0 1 0 0];                   %10
    
r3061= [1 1 0 0 0 0;...                 %1
        0 1 0 0 0 0;...                 %2
        0 1 0 0 0 0;...                 %3
        1 0 0 0 0 0;...                 %4
        0 0 1 0 0 0;...                 %5
        0 0 1 0 0 0;...                 %6
        0 0 0 1 0 0;...                 %7
        0 0 0 1 0 0;...                 %8
        0 0 0 0 1 0;...                 %9
        0 0 0 1 0 0];                   %10
  
r3062= [1 0 0 0 0 0;...                 %1
        1 0 0 0 0 0;...                 %2
        0 1 0 0 0 0;...                 %3
        0 1 0 0 0 0;...                 %4
        0 0 1 0 0 0;...                 %5
        0 0 1 0 0 1;...                 %6
        0 0 1 0 0 0;...                 %7
        0 0 0 1 0 0;...                 %8
        1 0 0 0 0 0;...                 %9
        0 0 0 0 0 1];                   %10
    
r3063= [1 0 0 0 0 0;...                 %1
        0 1 0 0 0 0;...                 %2
        1 0 0 0 0 0;...                 %3
        0 1 0 0 0 0;...                 %4
        0 0 1 0 0 0;...                 %5
        0 0 1 0 1 0;...                 %6
        0 0 0 1 0 0;...                 %7
        0 0 0 0 1 0;...                 %8
        0 0 0 0 1 0;...                 %9
        0 0 0 0 0 1];                   %10
 
r3064= [1 0 0 0 0 0;...                 %1
        1 0 0 0 0 0;...                 %2
        0 1 0 0 0 0;...                 %3
        0 1 0 0 0 0;...                 %4
        0 0 1 0 1 0;...                 %5
        0 0 1 0 1 0;...                 %6
        0 0 0 0 1 0;...                 %7
        0 0 0 1 0 0;...                 %8
        0 0 0 0 0 1;...                 %9
        0 0 0 0 0 1];                   %10

r3065= [1 0 0 0 0 0;...                 %1
        1 0 0 0 0 0;...                 %2
        0 1 1 0 0 0;...                 %3
        0 1 1 0 0 0;...                 %4
        0 1 1 0 0 0;...                 %5
        0 0 1 0 1 0;...                 %6
        0 0 0 0 0 1;...                 %7
        0 0 0 0 1 0;...                 %8
        0 0 0 1 0 0;...                 %9
        0 0 0 1 0 0];                   %10
    
r3066= [0 0 1 0 0 0;...                 %1
        0 0 1 0 0 0;...                 %2
        1 0 0 0 0 0;...                 %3
        0 1 0 0 1 0;...                 %4
        0 0 1 0 0 0;...                 %5
        0 1 0 0 0 0;...                 %6
        0 0 0 0 0 1;...                 %7
        0 0 0 0 0 1;...                 %8
        0 0 1 0 1 0;...                 %9
        0 0 0 0 0 1];                   %10

%Towing    
%       1 2 3 4 5 6                    component
r3067= [1 0 0 0 0 0;...                 %1
        0 0 1 0 0 0;...                 %2
        0 0 1 0 0 0;...                 %3
        1 0 0 0 0 0;...                 %4
        0 0 0 0 0 1;...                 %5
        0 0 0 0 1 0;...                 %6
        0 0 0 0 1 0;...                 %7
        0 0 0 0 0 1;...                 %8
        0 0 0 0 0 1;...                 %9
        0 0 0 0 0 1];                   %10
    
r3068= [1 0 0 0 0 0;...                 %1
        0 0 1 0 0 0;...                 %2
        0 0 1 0 0 0;...                 %3
        0 0 0 0 1 0;...                 %4
        0 0 0 0 0 1;...                 %5
        1 0 0 0 0 0;...                 %6
        0 0 0 0 1 0;...                 %7
        0 0 0 0 0 1;...                 %8
        0 0 0 0 0 1;...                 %9
        0 0 0 0 0 1];                   %10

r3069= [1 0 0 0 0 0;...                 %1
        0 0 1 0 0 0;...                 %2
        0 0 1 0 0 0;...                 %3
        0 0 0 0 0 1;...                 %4
        0 0 0 0 1 0;...                 %5
        0 0 0 0 0 1;...                 %6
        0 0 1 0 0 0;...                 %7
        0 0 0 0 0 1;...                 %8
        0 0 0 0 0 1;...                 %9
        1 0 0 0 0 1];                   %10
    
r3070= [1 0 0 0 0 0;...                 %1
        0 0 1 0 0 0;...                 %2
        0 0 1 0 0 0;...                 %3
        1 0 0 1 0 0;...                 %4
        0 0 0 0 1 0;...                 %5
        1 0 0 1 0 0;...                 %6
        0 0 0 0 0 1;...                 %7
        1 0 0 1 0 0;...                 %8
        0 0 0 0 0 1;...                 %9
        0 0 0 0 1 0] ;                  %10
    
r3071= [1 0 0 0 0 0;...                 %1
        0 0 1 0 0 0;...                 %2
        0 0 1 0 0 0;...                 %3
        0 0 0 1 0 0;...                 %4
        1 0 0 0 0 0;...                 %5
        0 0 0 1 0 0;...                 %6
        0 0 0 0 0 1;...                 %7
        0 0 0 0 0 1;...                 %8
        0 0 0 0 0 1;...                 %9
        0 0 0 0 0 1] ;                  %10
    
r3072= [1 0 0 0 0 0;...                 %1
        0 0 1 0 0 0;...                 %2
        0 0 1 0 0 0;...                 %3
        0 0 0 0 1 0;...                 %4
        0 0 0 0 0 1;...                 %5
        0 0 0 0 0 1;...                 %6
        0 0 0 0 0 1;...                 %7
        0 0 0 0 1 0;...                 %8
        0 0 0 0 0 1;...                 %9
        0 0 0 0 0 1];                   %10
    
r3073= [1 0 0 0 0 0;...                 %1
        0 0 1 0 0 0;...                 %2
        0 0 1 0 0 0;...                 %3
        1 0 0 0 0 0;...                 %4
        1 0 0 0 0 0;...                 %5
        0 0 0 0 0 1;...                 %6
        0 0 0 0 1 0;...                 %7
        0 0 0 0 1 0;...                 %8
        0 0 0 0 0 1;...                 %9
        0 0 0 0 0 1];                   %10
    
r3074= [1 0 0 0 0 0;...                 %1
        0 0 1 0 0 0;...                 %2
        0 0 1 0 0 0;...                 %3
        0 0 1 0 0 0;...                 %4
        0 0 0 0 0 1;...                 %5
        0 0 0 0 0 1;...                 %6
        0 0 0 0 0 1;...                 %7
        0 0 0 0 0 1;...                 %8
        0 0 0 0 0 1;...                 %9
        0 0 0 0 0 1];                   %10
    
r3075= [1 0 0 0 0 0;...                 %1
        0 0 1 0 0 0;...                 %2
        1 0 0 0 0 0;...                 %3
        0 0 1 0 0 0;...                 %4
        1 0 0 0 0 0;...                 %5
        1 0 0 0 0 0;...                 %6
        0 0 0 0 1 0;...                 %7
        1 0 0 0 1 0;...                 %8
        0 0 0 0 1 0;...                 %9
        1 0 0 0 0 0];                   %10
    
r3076= [1 0 0 0 0 0;...                 %1
        0 0 1 0 0 0;...                 %2
        0 0 1 0 0 0;...                 %3
        1 0 0 0 0 0;...                 %4
        1 0 0 0 0 0;...                 %5
        1 0 0 0 0 0;...                 %6
        0 0 0 0 0 1;...                 %7
        0 0 0 0 0 1;...                 %8
        0 0 0 0 0 1;...                 %9
        0 0 0 0 0 1];                   %10
  
r3077= [1 0 0 0 0 0;...                 %1
        0 0 1 0 0 0;...                 %2
        1 0 0 0 0 0;...                 %3
        0 0 1 0 0 0;...                 %4
        1 0 0 0 0 0;...                 %5
        0 0 0 0 1 0;...                 %6
        0 0 0 0 1 0;...                 %7
        0 0 0 1 1 0;...                 %8
        0 0 0 0 1 0;...                 %9
        0 0 0 0 0 1];                   %10
    
r3078= [1 0 1 0 0 0;...                 %1
        0 0 1 0 0 0;...                 %2
        1 0 1 0 0 0;...                 %3
        0 0 1 0 0 0;...                 %4
        0 0 0 0 0 1;...                 %5
        0 0 0 0 1 0;...                 %6
        0 0 1 0 1 0;...                 %7
        0 0 1 0 1 0;...                 %8
        0 0 1 0 0 0;...                 %9
        0 0 0 0 0 1];                   %10
 
r3079= [1 0 1 0 0 0;...                 %1
        0 0 1 0 0 0;...                 %2
        0 0 1 0 0 0;...                 %3
        1 0 1 0 0 0;...                 %4
        1 0 0 0 0 0;...                 %5
        1 0 0 0 0 0;...                 %6
        0 0 1 0 0 0;...                 %7
        0 0 1 0 0 0;...                 %8
        0 0 1 0 0 0;...                 %9
        0 0 0 0 1 0];                   %10

r3080= [1 0 1 0 0 0;...                 %1
        1 0 1 0 0 0;...                 %2
        0 0 1 0 0 0;...                 %3
        0 0 1 0 0 0;...                 %4
        1 0 1 0 0 0;...                 %5
        0 0 0 1 0 0;...                 %6
        0 0 1 0 1 0;...                 %7
        0 0 0 0 1 0;...                 %8
        0 0 0 0 1 0;...                 %9
        0 0 1 0 0 0];                   %10
    
r3081= [1 0 1 0 0 0;...                 %1
        0 0 1 0 0 0;...                 %2
        0 0 1 0 0 0;...                 %3
        1 0 0 0 1 0;...                 %4
        0 0 1 0 0 0;...                 %5
        0 0 0 0 0 1;...                 %6
        0 0 0 0 1 0;...                 %7
        0 0 0 0 1 0;...                 %8
        0 0 1 0 1 0;...                 %9
        0 0 0 0 1 0];                   %10

%PEDALING NO HANDS
%1 = longitudenal / lateral
%2 = pedaling + upper body steer
%3 = steer + yaw + roll
%4 = bounce
%5 = knees
%6 = Other
%7 = bicycle lateral lean /upper body counter lean

%       1 2 3 4 5 6 7
r3082= [1 0 0 0 0 0 0;...                 %1
        1 0 0 0 0 0 1;...                 %2
        0 1 1 0 0 0 0;...                 %3
        0 1 1 0 0 0 0;...                 %4
        0 0 0 0 0 0 1;...                 %5
        0 0 0 1 0 0 0;...                 %6
        0 0 0 0 0 0 1;...                 %7
        0 0 0 1 0 0 0;...                 %8
        0 0 0 0 0 1 0;...                 %9
        0 0 0 0 1 0 0];                   %10
    
r3083= [1 0 0 0 0 0 0;...                 %1
        0 1 1 0 0 0 0;...                 %2
        1 0 0 0 0 0 0;...                 %3
        0 1 1 0 0 0 0;...                 %4
        0 0 1 1 0 0 0;...                 %5
        0 0 1 1 0 0 0;...                 %6
        0 0 0 1 1 0 0;...                 %7
        0 0 1 1 0 0 0;...                 %8
        0 0 0 0 0 1 0;...                 %9
        0 0 0 0 0 1 0];                   %10
    
r3084= [1 0 0 0 0 0 0;...                 %1
        0 1 1 0 0 0 1;...                 %2
        0 1 1 0 0 0 0;...                 %3
        1 1 0 0 0 0 0;...                 %4
        0 0 1 1 0 0 0;...                 %5
        0 0 0 0 0 1 0;...                 %6
        0 0 0 0 0 0 1;...                 %7
        0 0 0 1 0 0 0;...                 %8
        0 0 0 1 0 0 0;...                 %9
        0 0 0 1 0 0 0];                   %10
    
r3085= [1 0 0 0 0 0 0;...                 %1
        0 1 1 0 0 0 1;...                 %2
        1 1 0 0 0 0 0;...                 %3
        0 1 1 0 0 0 0;...                 %4
        0 0 1 0 0 0 0;...                 %5
        0 0 1 0 1 0 1;...                 %6
        0 0 0 1 0 0 0;...                 %7
        0 0 0 0 0 1 0;...                 %8
        0 0 0 1 0 0 0;...                 %9
        0 0 0 0 1 0 1];                   %10
    
r3086= [1 0 1 0 0 0 1;...                 %1
        0 1 1 0 0 0 0;...                 %2
        0 1 1 0 0 0 0;...                 %3
        1 0 0 0 0 0 0;...                 %4
        0 0 1 0 1 0 1;...                 %5
        0 0 1 0 1 0 1;...                 %6
        0 0 0 1 0 0 0;...                 %7
        0 0 1 0 1 0 1;...                 %8
        0 0 0 1 0 0 0;...                 %9
        0 0 0 0 1 0 1];                   %10

r3087= [1 0 0 0 0 0 0;...                 %1
        1 0 0 0 0 0 0;...                 %2
        0 1 1 0 0 0 0;...                 %3
        0 1 1 0 0 0 0;...                 %4
        0 0 1 0 1 0 1;...                 %5
        0 0 1 0 1 0 1;...                 %6
        1 0 0 0 0 0 0;...                 %7
        0 0 0 0 1 0 1;...                 %8
        0 1 0 0 0 0 0;...                 %9
        0 0 0 1 0 0 0];                   %10
    
r3088= [1 0 0 0 0 0 0;...                 %1
        1 0 0 0 0 0 0;...                 %2
        0 1 1 0 0 0 0;...                 %3
        0 1 1 0 0 0 0;...                 %4
        0 0 1 0 0 0 1;...                 %5
        0 0 1 0 1 0 0;...                 %6
        0 0 0 1 0 0 0;...                 %7
        0 0 1 0 1 0 1;...                 %8
        0 0 1 0 1 0 1;...                 %9
        0 0 0 1 0 0 0];                   %10
    
%*********************** NO HANDS PEDALING ********************************
if nrx==3
 %make a big matrix with percentages for each component of each run
AA=zeros(10,7);                        %[(components) (nr of runs)]
p=1;
for i=3082:3088                         %NO HANDS pedaling Browser
    load(sprintf('%d',i));
    AA(:,p)=gBikeRider;
    p=p+1;
end

%percentages for each class for each run
percentclass=zeros(7,7);               %[(nr of classes) (nr of runs)]
for i=1:7
    for j = 1:7        
        percentclass(j,i)= (eval(sprintf('r%d(:,%d)',3081+i,j)))'*AA(:,i);
    end 
end

[AX,H1,H2]=plotyy(speednh,percentclass([1 2 3 6 7],:),speednh,percentclass([4 5],:))
axis(AX(2),[14 30 0 1])
set(H1,'LineStyle','-')
set(H1(1),'marker','s')
set(H1(2),'marker', 'o')
set(H1(3),'marker', 'd');
set(H1(4),'marker', 'v')
set(H1(5),'marker', 'h');
set(H2,'LineStyle',':')
set(H2(1),'marker','s')
set(H2(2),'marker','o')


legend(AX(1),'long/lat','pedaling','steer/yaw/rol','other','upperbody lean')
legend(AX(2),'bounce','knees')
xlabel('Speed [km/h]')
ylabel('percentage [%]')
title('Browser No Hands Pedaling, All Classes')


%remove the lateral/longitudenal and other results from the percentages.
percentminus16=zeros(5,7);
for i=1:7;
    total=sum(percentclass([2:5 7],i));
    percentminus16(:,i)=percentclass([2:5 7],i)./total*100;
end
figure
fu = percentminus16(1,:)+percentminus16(5,:);
percentminus16=[percentminus16; fu];
[AX1,H3,H4]=plotyy(speednh,percentminus16([1 2 5 6],:),speednh,percentminus16([3 4],:))
set(H3,'LineStyle','-')
set(H3(1),'marker','s')
set(H3(2),'marker', 'o')
set(H3(3),'marker', 'd');
set(H3(4),'marker', 'v')
set(H4,'LineStyle',':')
set(H4(1),'marker','s')
set(H4(2),'marker','o')

Aleg=legend(H3,'Pedaling','Steer Yaw Roll','Upper body lean')
bleg=legend(H4,'Knee Bounce','Lateral Knee')
axis(AX1(2),[14 30 0 10])
%set(Aleg, 'Box', 'off')
%set(Bleg, 'Box', 'off')
set(H3,'LineStyle','-')
set(H4,'LineStyle',':')
xlabel('Speed [km/h]')
ylabel('percentage [%]')
title('Browser No Hands Pedaling, Longitudenal/Lateral and Other removed ')   

end
%*********************** NORMAL PEDALING **********************************
if nrx == 1
 %make a big matrix with percentages for each component of each run
AA=zeros(10,15);                        %[(components) (nr of runs)]
p=1;
for i=3052:3066                         %normal pedaling Browser
%for i=3067:3081                        %Towing Browser
    load(sprintf('%d',i));
    AA(:,p)=gBikeRider;
    p=p+1;
end

%percentages for each class for each run
percentclass=zeros(6,15);               %[(nr of classes) (nr of runs)]
for i=1:15
    for j = 1:6        
        percentclass(j,i)= (eval(sprintf('r%d(:,%d)',3051+i,j)))'*AA(:,i);
    end 
end

[AX,H1,H2]=plotyy(speed,percentclass([1 2 3 6],:),speed,percentclass([4 5],:));
axis(AX(2),[0 30 0 1])
set(H1,'LineStyle','-')
set(H1(1),'marker','s')
set(H1(2),'marker', 'o','Color',[0.6 0.6 0.6])
set(H1(3),'marker', 'd');
set(H1(4),'marker', 'v')
set(H2,'LineStyle',':')
%set(H2(1),'Color','[0.7 0.7 0.7]')
set(H2(1),'marker','s')
set(H2(2),'marker','o')


luit=legend([H1(1), H1(2), H1(3), H1(4), H2(1), H2(2)],'long/lat','pedaling','steer/yaw/rol','other','bounce','knees')
set(luit,'Box','off')
%legend(AX(2),'bounce','knees')
xlabel('Speed [km/h]')
ylabel(AX(1),'Percentage [%]')
ylabel(AX(2),'Percentage [%]','Color',[0.6 0.6 0.6])
%title('Browser Normal Pedaling, All Classes')


%remove the lateral/longitudenal and other results from the percentages.
percentminus16=zeros(4,15);
for i=1:15;
    total=sum(percentclass([2:5],i));
    percentminus16(:,i)=percentclass([2:5],i)./total*100;
end
figure
[AX1,H3,H4]=plotyy(speed,percentminus16([1 2],:),speed,percentminus16([3 4],:));
set(H3,'LineStyle','-')
set(H3(1),'marker','s','Color',[0 0 0],'linewidth',2)
set(H3(2),'marker', 'o','Color',[0 0 0],'linewidth',2)
%set(H3(3),'marker', 'd');
%set(H3(4),'marker', 'v')
set(H4,'LineStyle',':')
set(H4(1),'marker','s','Color',[0.6 0.6 0.6],'linewidth',2)
set(H4(2),'marker','o','Color',[0.6 0.6 0.6],'linewidth',2)

Aleg=legend([H3(1),H3(2),H4(1), H4(2)],'Pedaling','Steer Yaw Roll','Knee Bounce','Lateral Knee','Location','East')
%bleg=legend(H4,'Knee Bounce','Lateral Knee','boxoff')
axis(AX1(2),[0 30 0 10])
set(AX1(2),'YColor',[0.6 0.6 0.6])
set(Aleg, 'Box', 'off')
%set(Bleg, 'Box', 'off')
set(H3,'LineStyle','-')
set(H4,'LineStyle',':')
xlabel('Speed [km/h]')
ylabel(AX1(1),'Percentage [%]')
ylabel(AX1(2),'Percentage [%]','Color',[0.6 0.6 0.6])
%title('Browser Normal Pedaling, Longitudenal/Lateral and Other removed ')   

end
%*********************** TOWING *******************************************
if nrx==2
%make a big matrix with percentages for each component of each run
AA=zeros(10,15);                        %[(components) (nr of runs)]
p=1;
%for i=3052:3066                         %normal pedaling
for i=3067:3081
    load(sprintf('%d',i));
    AA(:,p)=gBikeRider;
    p=p+1;
end

%percentages for each class for each run
percentclass=zeros(6,15);               %[(nr of classes) (nr of runs)]
for i=1:15
    for j = 1:6        
        percentclass(j,i)= (eval(sprintf('r%d(:,%d)',3066+i,j)))'*AA(:,i);
    end 
end
figure;
[AX2,H5,H6]=plotyy(speed,percentclass([1 2 3 6],:),speed,percentclass([4 5],:))
axis(AX2(2),[0 30 0 1])
set(H5,'LineStyle','-')
set(H5(1),'marker','s','Color',[0 0 0],'linewidth',2)
set(H5(2),'marker', 'o')
set(H5(3),'marker', 'd');
set(H5(4),'marker', 'v')
set(H6,'LineStyle',':')
set(H6(1),'marker','s')
set(H6(2),'marker','o')
legend(H5,'long/lat','pedaling','steer/yaw/rol','other')
legend(H6,'bounce','knees')
xlabel('Speed [km/h]')
ylabel('percentage [%]')
title('Browser Towing, All Classes')

%remove the lateral/longitudenal and other results from the percentages.
percentminus16=zeros(3,15);
for i=1:15;
    total=sum(percentclass([3:5],i));
    percentminus16(:,i)=percentclass([3:5],i)./total*100;
end
figure
[AX3,H7,H8]=plotyy(speed,percentminus16([1],:),speed,percentminus16([2 3],:))
set(H7,'LineStyle','-')
set(H7(1),'marker','s','Color',[0 0 0],'linewidth',2)
set(H8,'LineStyle',':')
set(H8(1),'marker','s','Color',[0.6 0.6 0.6],'linewidth',2)
set(H8(2),'marker','o','Color',[0.6 0.6 0.6],'linewidth',2)
aleg=legend([H7(1),H8(1),H8(2)],'Steer Yaw Roll','Knee Bounce','Lateral Knee','Location','West')
%legend(H8,'Knee Bounce','Lateral Knee')
set(aleg, 'Box', 'off')
axis(AX3(1),[0 30 0 100])
axis(AX3(2),[0 30 0 20])
xlabel('Speed [km/h]')
ylabel(AX3(1),'Percentage [%]','Color',[0 0 0])
ylabel(AX3(2),'Percentage [%]','Color',[0.6 0.6 0.6])
%title('Browser Towing, Longitudenal/Lateral and Other removed ')
end
