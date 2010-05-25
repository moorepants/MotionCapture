directory = 'data'; % name the data directory

for rider = 2:2 % for riders 1 through 3
    i = 1;
    for k = 52:66 % for trial numbers 1 through 110
        if k < 10 % then the filname needs two zeros
            fileName = [num2str(rider) '00' num2str(k)];
        elseif k > 99 % the the file name needs no zeros
            fileName = [num2str(rider) num2str(k)];
        else % the filename needs one zero
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
            
            pBikeRider(i,:) = gBikeRider';
            pRider(i,:) = gRider';
            i = i+1;
        end
    end
end
speed = [5 10 15 20 25 30 30 25 20 15 10 5 4 3 2];
plot(speed,pRider)