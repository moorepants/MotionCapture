clear all
close all
clc

to = cputime; % record the start cpu time
directory = 'data'; % name the data directory

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
            isGearing = sum(strcmp('gearing',who));
            isGear = sum(strcmp('gear',who));
            if isGear && isGearing
                clear gear
            elseif isGear && ~isGearing
                gearing = gear;
                clear gear
            elseif ~isGear && isGearing
                % do nothing
            else
                gearing = 'none';
            end
            save([directory '\' fileName],'x','y','z','xori','yori',...
                             'zori','t','bike','condition','gearing','V','rr','rf',...
                             'd','q','xn','yn','zn','xb','yb','zb')
            clear gearing isGear isGearing x y z xori yori zori t bike condition V rr rf d q xn yn zn xb yb zb 
        end
    end
end
computeTime = cputime-to;