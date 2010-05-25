clear all
close all
clc
load('data\2021.mat')
comp = [5 0 0 0 0 0 0 0 0 0];
comp = diag(comp);
n = max(size(ARider));
P = zeros(max(size(vRider)),n);
l = max(size(vRider))/3;
for i = 1:n
    P(:,i) = uRider + vRider*comp*ARider(:,i);
end
xpca = P(1:l,:);
ypca = P(l+1:2*l,:);
zpca = P(2*l+1:3*l,:);
h1 = plot3(xpca(:,1),-ypca(:,1),-zpca(:,1),'r.');
axis([-1 1 -0.5 1.5])
for i = 2:n
    set(h1,'XData',xpca(:,i),'YData',-ypca(:,i),'ZData',-zpca(:,i))
    pause(0.001)
end