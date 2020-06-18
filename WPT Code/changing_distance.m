clear;
clc;
%---- constant defenitions ----
B = 2e9;  %2Ghz %bandwidth
%B = linspace(1e9, 5e9, 5);
N = 50%number of IoTDs
H = 5 %IoTD distance from ground m ( z axis)
pic = 0.2; %200mW communication power - built in value for each IoTD, assumed to be same for all devices
h0=1e-3;      %-30dB 
noise=1e-9;   %-60dBm noise
beta_zero = 1e-3; %-30dB
Pw_max = 0.2 %?? maximum power of charging
tw = 0.1 %?? charging time
%M = 10; %mean distance from IoTDs to UAV
M = linspace(1, 50, 100);
%M = 0;


L = length(M) % number of x values

%---Generating the total data----


%h0 = 1e-3; %-30dB
B = 1e9;

for j = 1:L

%----- function calls ----
d_square = generate_iot(N, H, M(j)); 
rate = data_rate(N,1,d_square,pic,B,h0,noise); % generates ri
omega = channel_loss_power(N, beta_zero, d_square); %generates wi
tic = time_comm(N, omega, Pw_max, tw, pic); %generates the communication time for each IoTD

%----- produces result, the total data amount

%loop to generate di, the data amount for the ith IoTD
d = zeros(N,1)
for i = 1:N
    d(i) = rate(i) * tic(i);
 
end
total_data(j) = sum(d);

end

total_data_1 = total_data;



B = 2e9;

for j = 1:L

%----- function calls ----
d_square = generate_iot(N, H, M(j)); 
rate = data_rate(N,1,d_square,pic,B,h0,noise); % generates ri
omega = channel_loss_power(N, beta_zero, d_square); %generates wi
tic = time_comm(N, omega, Pw_max, tw, pic); %generates the communication time for each IoTD

%----- produces result, the total data amount

%loop to generate di, the data amount for the ith IoTD
d = zeros(N,1)
for i = 1:N
    d(i) = rate(i) * tic(i);
 
end
total_data(j) = sum(d);

end

total_data_2 = total_data;


B = 5e9;

for j = 1:L

%----- function calls ----
d_square = generate_iot(N, H, M(j));
rate = data_rate(N,1,d_square,pic,B,h0,noise); % generates ri
omega = channel_loss_power(N, beta_zero, d_square); %generates wi
tic = time_comm(N, omega, Pw_max, tw, pic); %generates the communication time for each IoTD

%----- produces result, the total data amount

%loop to generate di, the data amount for the ith IoTD
d = zeros(N,1)
for i = 1:N
    d(i) = rate(i) * tic(i);
 
end
total_data(j) = sum(d);

end

total_data_3 = total_data;


%----plotting graphs-----
%plot(B, total_data)
plot(M,total_data_1,'k-+',M,total_data_2,'k-*',M,total_data_3,'k-o','LineWidth',0.6);
xlabel('Average distance of IoTD from UAV (meters)')
ylabel('Total Data (bits)')
legend('B = 1GHz', 'B = 2GHz', 'B = 5GHz', 'Location', 'best')
