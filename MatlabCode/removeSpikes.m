% File: removeSpikes.m
% Date: March 4, 2008
% Author: Jason Moore
% Description: Removes the spikes from the video coordinate data and
% replaces them with gaps (NaN).

load('data\1002.mat')

for i = 1:3 % for the x, y and z vectors
    if i == 1
        data = x;
    elseif i == 2
        data = y;
    else
        data = z;
    end
    for j = 1:min(size(data))
        lastGoodValue = mean(data(:,j));
        for k = 2:max(size(data))
            if isnan(data(k-1,j))== 0
                lastGoodValue = data(k-1,j);
            end
            diff = abs(data(k,j)-lastGoodValue);
            if diff > abs(.1*lastGoodValue)
                data(k,j) = NaN;
            end
        end
    end
    if i == 1
        datax = data;
    elseif i == 2
        datay = data;
    else
        dataz = data;
    end
end
