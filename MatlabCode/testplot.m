% h = plot(xn(1,1:20),-zn(1,1:20),'r.',xn(1,21:41),-zn(1,21:41),'b.')
h1 = plot(xn(1,1:40),-zn(1,1:40),'r.')
% lines = [36
%          26
%          36
%          38
%          38
%          26
%          38
%          33
%          32
%          33
%          33
%          39
%          39
%          29
%          39
%          23
%          26
%          33];
% hold on
% h2=plot(xn(1,lines(:,1)),-zn(1,lines(:,1)));
% hold off
axis([-0.4 1.4 0 2])
for i = 2:6000
    set(h1,'XData',xn(i,1:40),'YData',-zn(i,1:40))
%     set(h2,'XData',xn(i,lines(:,1)),'YData',-zn(i,lines(:,1)))
    pause(0.001)
end