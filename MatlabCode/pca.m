clear all
close all
clc

to = cputime; % record the start cpu time
directory = 'data'; % name the data directory

for rider = 2:2
    for k = 72:72
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
            clear gBikeRider vBikeRider ABikeRider tBikeRider
            clear gBike vBike ABike tBike
            clear gRider vRider ARider tRider
            % build the P matrix
            P = [xn(:,1:40)';yn(:,1:40)';zn(:,1:40)'];
            % clip the data if there are NaNs
            i = 1;
            while i <= max(size(P))
                if sum(isnan(P(:,i)))>0
                    P(:,i)=[];
                else
                    i = i+1;
                end
            end
            % number of data sets
            m = min(size(P));
            % number of markers
            l = m/3;
            % time steps
            n = max(size(P));
            % amount of time used for the pca calcs
            pcaTime = t(n);
            % calculate the average
            u = mean(P,2);
            % create a vector of ones
            h = ones(1,n);
            % mean subtracted data matrix
            B = P-u*h;
            % covariance matrix
            C = 1/(n-1)*B*B';
            % calculate the eigenvalues and eigenvectors
            [v,lambda]=eig(C);
            lambda=diag(lambda);
            % find the coeffiecient matrix
            A = zeros(m,n);
            for i = 1:n
                A(:,i) = real(v\(P(:,i)-u));
            end
            % take only the first 10 components
            L = 10;
            lambda = lambda(1:L);
            % calculate the cumulative energy content percentage
            lambdaBikeRider = lambda;
            gBikeRider = lambda./sum(lambda).*100;
            vBikeRider = v(1:m,1:L);
            ABikeRider = A(1:L,:);
            tBikeRider = pcaTime;
            uBikeRider = u;
            clear P m l n pcaTime u h B C v lambda A L
            % for the bicycle only
            % build the P matrix
            P = [xn(:,21:40)';yn(:,21:40)';zn(:,21:40)'];
            % clip the data if there are NaNs
            i = 1;
            while i <= max(size(P))
                if sum(isnan(P(:,i)))>0
                    P(:,i)=[];
                else
                    i = i+1;
                end
            end
            % number of data sets
            m = min(size(P));
            % number of markers
            l = m/3;
            % time steps
            n = max(size(P));
            % amount of time used for the pca calcs
            pcaTime = t(n);
            % calculate the average
            u = mean(P,2);
            % create a vector of ones
            h = ones(1,n);
            % mean subtracted data matrix
            B = P-u*h;
            % covariance matrix
            C = 1/(n-1)*B*B';
            % calculate the eigenvalues and eigenvectors
            [v,lambda]=eig(C);
            lambda=diag(lambda);
            % find the coeffiecient matrix
            A = zeros(m,n);
            for i = 1:n
                A(:,i) = real(v\(P(:,i)-u));
            end
            % take only the first 10 components
            L = 10;
            lambda = lambda(1:L);
            % calculate the cumulative energy content percentage
            lambdaBike = lambda;
            gBike = lambda./sum(lambda).*100;
            vBike = v(1:m,1:L);
            ABike = A(1:L,:);
            tBike = pcaTime;
            uBike = u;
            clear P m l n pcaTime u h B C v lambda A L
            % for the rider only
            % build the P matrix
            P = [xb';yb';zb'];
            % clip the data if there are NaNs
            i = 1;
            while i <= max(size(P))
                if sum(isnan(P(:,i)))>0
                    P(:,i)=[];
                else
                    i = i+1;
                end
            end
            % number of data sets
            m = min(size(P));
            % number of markers
            l = m/3;
            % time steps
            n = max(size(P));
            % amount of time used for the pca calcs
            pcaTime = t(n);
            % calculate the average
            u = mean(P,2);
            % create a vector of ones
            h = ones(1,n);
            % mean subtracted data matrix
            B = P-u*h;
            % covariance matrix
            C = 1/(n-1)*B*B';
            % calculate the eigenvalues and eigenvectors
            [v,lambda]=eig(C);
            lambda=diag(lambda);
            % find the coeffiecient matrix
            A = zeros(m,n);
            for i = 1:n
                A(:,i) = real(v\(P(:,i)-u));
            end
            % take only the first 10 components
            L = 10;
            lambda = lambda(1:L);
            % calculate the cumulative energy content percentage
            lambdaRider = lambda;
            gRider = lambda./sum(lambda).*100;
            vRider = v(1:m,1:L);
            ARider = A(1:L,:);
            tRider = pcaTime;
            uRider = u;
            clear P m l n pcaTime u h B C v lambda A L
            % save the variables to the new file name
            save([directory '\' fileName],'x','y','z','xori','yori',...
                'zori','t','bike','condition','gearing','V','rr','rf',...
                'd','q','xn','yn','zn','xb','yb','zb',...
                'gBikeRider','vBikeRider','ABikeRider','tBikeRider','uBikeRider',...
                'gBike','vBike','ABike','tBike','uBike',...
                'gRider','vRider','ARider','tRider','uRider',...
                'lambdaRider','lambdaBike','lambdaBikeRider')
            % erase the variables
            clear t x y z xori yori zori condition gear gearing bike V
            clear rr rf d q xn yn zn xb yb zb
            clear gBikeRider vBikeRider ABikeRider tBikeRider uBikeRider
            clear gBike vBike ABike tBike uBike
            clear gRider vRider ARider tRider uRider
            clear lambdaRider lambdaBike lambdaBikeRider
        end
    end
end
computeTime = cputime-to;