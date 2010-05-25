function [x,y,z] = pcaPlotData(a,V,u,c)

comp = diag(c);
P = u + V*comp*a;
l = max(size(V))/3;
x = P(1:l,:);
y = P(l+1:2*l,:);
z = P(2*l+1:3*l,:);