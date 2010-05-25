clear all
close all
clc

load('data\3013.mat')
s = who;
v1 = vRider;
for i = 1:length(s)
    clear(s{i})
end
clear s i
load('data\3021.mat')
s = who;
v2 = vRider;
for i = 1:length(s)
    if strcmp('v1',s{i})
    else
        clear(s{i})
    end
end
clear s i
tol = 0.2;
matches = [];
for i = 1:min(size(v1))
    for j = 1:min(size(v2))
        diff = 1 - abs(dot(v1(:,i),v2(:,j)));
        if diff <= tol
            matches = [matches;i j abs(dot(v1(:,i),v2(:,j)))];
        end
    end
end
matches        
