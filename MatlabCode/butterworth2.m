% Filename: butterworth2.m
% Date: Friday, March 7, 2008
% Author: Jason Moore
% Description: A 2nd order low pass Butterworth filter. Takes a data 
% vector, sample rate and cutoff frequency and filters the data.
function filtered_data = butterworth2(raw_data,sample_rate,cutoff)
y = raw_data;
% calucate the coefficients
cutoff2 = cutoff/.802;
delta_x = 1/sample_rate;
Sv = 1/cutoff2/delta_x;
if Sv > 4 % Sv must be less than 4 for the filter to be valid
    disp('Filter not valid!')
end
z = pi*cutoff2*delta_x;
z1 = sin(z);
z2 = cos(z);
wc = z1/z2;
a = 2*wc*sqrt(0.5);
b = 0.5*a^2;
c1 = b/(1+a+b);
c2 = 2*c1;
c3 = c1;
c4 = 2*(1-b)/(1+a+b);
c5 = (a-b-1)/(1+a+b);
% calculate the length of the data vector
len = length(y);
% initialize vectors
y_for  = zeros(len,1);
y2     = zeros(len,1);
y_bac  = zeros(len,1);
y_bac2 = zeros(len,1);
% flip the data
for i = 1:len
    y2(i,1) = y(len+1-i);
end
% filter the data
for i=1:len
    if i < 3 % don't filter the first 3 data points
        y_for(i,1)=y(i);
        y_bac(i,1)=y2(i);
    else
        y_for(i,1) = c1*y(i)+c2*y(i-1)+c3*y(i-2)+c4*y_for(i-1)+...
            c5*y_for(i-2); % filter forward
        y_bac(i,1) = c1*y2(i)+c2*y2(i-1)+c3*y2(i-2)+c4*y_bac(i-1)+...
            c5*y_bac(i-2); % filter backward
    end
end
% flip backward data
for i = 1:len
    y_bac2(i,1) = y_bac(len+1-i);
end
% calculate the average of the forward and backward filtered data
y_fil = (y_bac2+y_for)./2;
% output the filitered data
filtered_data = y_fil;
    