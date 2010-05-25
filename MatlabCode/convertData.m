% File: convertData.m
% Creation Date: March 17, 2009
% Author: Jason Moore
% Description: Calculates additional marker locations on the bicycle for
% plotting purposes and calculates the rigid body motion of the bicycle.
clear all
close all
clc

to = cputime; % record the start cpu time
directory = 'data'; % name the data directory

for rider = 2:3 % for riders 1 through 3
    for k = 1:110 % for trial numbers 1 through 110
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

            % erase the variables that are created in this file
            clear rr rf d q xn yn zn xb yb zb

            % get the number of time steps
            numTimeSteps = length(t);

            % initialize output vectors
            q  = zeros(numTimeSteps, 9); % generalized coordinates
            d  = zeros(numTimeSteps, 3); % bicycle geometry
            rr = zeros(numTimeSteps, 1); % rear wheel radius
            rf = zeros(numTimeSteps, 1); % front wheel radius
            xn = zeros(numTimeSteps,40); % x marker coord. wrt newtonian
            yn = zeros(numTimeSteps,40); % y marker coord. wrt newtonian
            zn = zeros(numTimeSteps,40); % z marker coord. wrt newtonian
            xb = zeros(numTimeSteps,20); % x marker coord. wrt bike frame
            yb = zeros(numTimeSteps,20); % y marker coord. wrt bike frame
            zb = zeros(numTimeSteps,20); % z marker coord. wrt bike frame

            % set the proper constants depending on which bike was used
            if strcmp(bike,'stratos')
                LAMBDA = 0.2967; % steer axis angle
                LCS = 0.44; % chainstay length
                HBB = 0.29; % bottom bracket height
            elseif strcmp(bike,'browser')
                LAMBDA = 0.4058; % steer axis angle
                LCS = 0.46; % chainstay length
                HBB = 0.295; % bottom bracket height
            else
                display('Missing bike description!')
                display(fileName)
            end
            
            % initialize the indice vector used to adjust the crank angle
            indice = [];
            
            for i=1:numTimeSteps % for each time step do these calculations
                % define the newtonian unit vectors (benchmark ref frame)
                n1 = [1 0 0]';
                n2 = [0 1 0]';
                n3 = [0 0 1]';

                % define the marker reference frame (optotrack frame)
                m1 =  n1;
                m2 = -n2;
                m3 = -n3;

                % define the original marker positions
                r = zeros(3,40); % initialize the position matrix
                for j = 1:31 % for 31 original markers
                    r(1:3,j) = x(i,j)*m1 + y(i,j)*m2 + z(i,j)*m3;
                end

                % calculate the midpoint virtual markers
                r(1:3,32) = (r(1:3,21)+r(1:3,27))./2; % front wheel center
                r(1:3,33) = (r(1:3,22)+r(1:3,28))./2; % headtube center
                r(1:3,34) = (r(1:3,23)+r(1:3,29))./2; % handlebar center
                r(1:3,35) = (r(1:3,24)+r(1:3,30))./2; % seat stay center
                r(1:3,36) = (r(1:3,25)+r(1:3,31))./2; % rear wheel center 

                % define the normal to a plane through m26, m33 and m36
                b2 = cross(r(1:3,36)-r(1:3,26),r(1:3,33)-r(1:3,26));
                b2 = b2./norm(b2);
                b1 = cross(b2,n3); % rear frame heading vector
                b1 = b1./norm(b1);
                b3 = cross(b1,b2);
                b3 = b3./norm(b3);

                a1 = b1;
                a3 = n3;
                a2 = cross(a3,a1);
                a2 = a2./norm(a2);

                % use the measured steer axis tilt to find the steer axis,
                % this assumes q6 = 0 (pitch = 0)
                d1 = cos(LAMBDA)*b1-sin(LAMBDA)*b3;
                d1 = d1./norm(d1);
                d2 = b2;
                d3 = cross(d1,d2);
                d3 = d3./norm(d3);
                
                % define a vector from the front left wheel center to the
                % front right wheel center
                e2 = r(1:3,21)-r(1:3,27);
                e2 = e2./norm(e2);
                e3 = d3;
                e1 = cross(e3,e2);
                e1 = e1./norm(e1);

                % calculate the rear wheel radius
                rr(i,1) = -dot(r(1:3,36),n3)/dot(b3,n3);
                % calculate the front wheel radius
                rf(i,1)=dot(-r(1:3,32),n3)/sin(acos(dot(e2,n3)));
                
                % calculate the bottom bracket virtual marker
                r_m36_m37 = LCS*cos(LAMBDA+asin((rr(i,1)-HBB)/LCS))*d1+...
                            LCS*sin(LAMBDA+asin((rr(i,1)-HBB)/LCS))*d3;
                r(1:3,37) = r(1:3,36)+r_m36_m37;
                
                % define a handlebar marker on the steer axis
                r_m33_m38 = -abs(dot(r(1:3,34)-r(1:3,33),e3))*e3;
                r(1:3,38) = r(1:3,33)+r_m33_m38;
                
                % define a marker at the rear wheel contact point
                r(1:3,39) = r(1:3,36)+rr(i,1)*b3;
                % define a marker at the front wheel contact point
                rfvec = cross(cross(e2,n3),e2);
                r_m32_m40 = rf(i,1)*rfvec./norm(rfvec);
                r(1:3,40) = r(1:3,32)+r_m32_m40;
                
                % calculate the bicycle geometry
                d(i,1) = norm(cross(r_m33_m38,r(1:3,33)-r(1:3,36)))/...
                         norm(r_m33_m38);
                d(i,2) = norm(cross(r_m33_m38,r(1:3,33)-r(1:3,32)))/...
                         norm(r_m33_m38);
                d(i,3) = dot(e3,(-d(i,2)*e1-d(i,1)*d1-(r(1:3,36)-...
                         r(1:3,39))-r_m32_m40-(r(1:3,39)-r(1:3,40))));

                % calculate the states
                q(i,1) = dot(n1,r(1:3,39));
                q(i,2) = dot(n2,r(1:3,39));
                q(i,3) = sign(dot(a1,n2))*acos(dot(a1,n1));
                q(i,4) = sign(dot(b2,a3))*acos(dot(b3,a3));
                q(i,6) = sign(dot(d3,b1))*acos(dot(b1,d1));
                q(i,7) = sign(dot(e1,d2))*acos(dot(d2,e2));

                % calculate the crank angle
                % create a vector between the feet markers
                r_m5_m1 = r(1:3,1) - r(1:3,5);
                % project the vector onto the b1b3 plane
                proj_rm5m1 = r_m5_m1 - dot(r_m5_m1,b2)*b2;
                % make it a unit vector
                proj_rm5m1 = proj_rm5m1./norm(proj_rm5m1);
                % calculate the crank angle
                q(i,9) = -sign(dot(proj_rm5m1,b3))*...
                         acos(dot(proj_rm5m1,b1));
                % shift the data at every revolution
                if i > 1 && sign(q(i-1,9))<0 && sign(q(i,9))~=sign(q(i-1,9))
                    indice = [indice; i];
                end
                pies = 1;
                for j = 1:length(indice)-1
                    q(indice(j):indice(j+1)-1,9)=q(indice(j):indice(j+1)-1,9)-2*pies*pi;
                    pies = pies + 1;
                end
%                 q(indice(length(indice)):length(q(:,1)),9)=q(indice(length(indice)):length(q(:,1)),9)-2*pies*pi;
                % indice = [];
                % 				for j=1:40
                % 					xn(i,j)=dot(r(1:3,j),n1);
                % 					yn(i,j)=dot(r(1:3,j),n2);
                % 					zn(i,j)=dot(r(1:3,j),n3);
                % 				end
                %
                % 				for j=1:20
                % 					xb(i,j)=dot(r(1:3,j)-r(1:3,36),b1);
                % 					yb(i,j)=dot(r(1:3,j)-r(1:3,36),b2);
                % 					zb(i,j)=dot(r(1:3,j)-r(1:3,36),b3);
                % 				end

            end
            % save the variables to the new file name
            % 			save([directory '\' fileName],'x','y','z','xori','yori',...
            %                  'zori','t','bike','condition','gearing','V','rr','rf',...
            %                  'd','q','xn','yn','zn','xb','yb','zb')
            % erase the variables
            % 			clear t x y z xori yori zori condition gear gearing bike V rr rf d q xn yn zn xb yb zb
        end
    end
end
computeTime = cputime-to;
