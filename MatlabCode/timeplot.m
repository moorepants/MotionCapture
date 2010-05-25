%timeplot = position plot in the time for all the markers

%% Data
if 0
x=xori;
y=yori;
z=zori;
end

%% 2d
[n m]=size(x)
rate = 1/25
for i=1:4:n;
   % plot(x(i,:),z(i,:),'.')
    plot(x(i,[1:20]),z(i,[1:20]),'b.',x(i,[21:end]),z(i,[21:end]),'r.' )
    axis([-1 +1.5 0 2])
    pause(rate)
    
end

%% 3d
% [n m]=size(x)
% rate = 1/25
% for i=1:4:n;
%     plot3(y(i,[1:20]),x(i,[1:20]),z(i,[1:20]),'b.',y(i,[21:end]),x(i,[21:end]),z(i,[21:end]),'r.' )
%     axis([1 2 -1 1.5 0 2])
%     pause(rate)
%     
% end