clear all
close all
clc

to = cputime; % record the start cpu time
directory = 'data'; % name the data directory
i = 1;
for rider = 2:3
    for k = 1:110
        if k < 10
            fileName = [num2str(rider) '00' num2str(k)];
        elseif k > 99
            fileName = [num2str(rider) num2str(k)];
        else
            fileName = [num2str(rider) '0' num2str(k)];
        end
        % see what files are in the directory
        s = what(directory);
        % is the current file name in the directory?
        isThere = strcmp([fileName '.mat'],s.mat);
        % if not, don't do anything
        if isThere==0
        else % if so, load the data and process
            load([directory '\' fileName]); % load the mat file
            gBikeTot(i,1) = sum(gBike(1:4));
            gRiderTot(i,1) = sum(gRider(1:4));
            gBikeRiderTot(i,1) = sum(gBikeRider(1:4));
            i = i+1;
        end
    end
end
computeTime = cputime-to;

gBikeMean = nanmean(gBikeTot);
gRiderMean = nanmean(gRiderTot);
gBikeRiderMean = nanmean(gBikeRiderTot);

gBikeSTD = nanstd(gBikeTot);
gRiderSTD = nanstd(gRiderTot);
gBikeRiderSTD = nanstd(gBikeRiderTot);