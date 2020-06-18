clear;
clc;
%---- constant defenitions ----
% B = 2e9;  %2Ghz %bandwidth
%B = linspace(1e9, 5e9, 5);
%N = 5%number of IoTDs
%N = [5, 12, 19, 26, 33, 40, 50, 1000];
N = linspace(1, 20, 20);
H = 5; %IoTD distance from ground m ( z axis)
pic = 0.2; %200mW communication power - built in value for each IoTD, assumed to be same for all devices
h0=1e-3;      %-30dB 
noise=1e-9;   %-60dBm noise
beta_zero = 1e-3; %-30dB
Pw_max = 0.2; %?? maximum power of charging
tw = 0.1; %?? charging time
M = 10; %mean distance from IoTDs to UAV
%M = linspace(0, 50, 7);
L = length(N); % number of x values
total_data_1 = zeros(1,L);
total_data_2 = zeros(1,L);
total_data_3 = zeros(1,L);
%---Generating the total data----
K=500;

%h0 = 1e-3; %-30dB
B = 1e9;

for j = 1:L
for k=1:K
%----- function calls ----
d_square = generate_iot(N(j), H, M); 
rate = data_rate(N(j),1,d_square,pic,B,h0,noise); % generates ri
omega = channel_loss_power(N(j), beta_zero, d_square); %generates wi
tic = time_comm(N(j), omega, Pw_max, tw, pic); %generates the communication time for each IoTD

%----- produces result, the total data amount

%loop to generate di, the data amount for the ith IoTD
d = zeros(N(j),1);
for i = 1:N(j)
    d(i) = rate(i) * tic(i);
end
total_data_1(j) = total_data_1(j) + sum(d);
end
end

total_data_1 = total_data_1/K;



B = 2e9;

for j = 1:L
for k=1:K
%----- function calls ----
d_square = generate_iot(N(j), H, M); 
rate = data_rate(N(j),1,d_square,pic,B,h0,noise); % generates ri
omega = channel_loss_power(N(j), beta_zero, d_square); %generates wi
tic = time_comm(N(j), omega, Pw_max, tw, pic); %generates the communication time for each IoTD

%----- produces result, the total data amount

%loop to generate di, the data amount for the ith IoTD
d = zeros(N(j),1);
for i = 1:N(j)
    d(i) = rate(i) * tic(i);
 
end
total_data_2(j) = total_data_2(j) + sum(d);
end
end

total_data_2 = total_data_2/K;


B = 5e9;

for j = 1:L
for k=1:K
%----- function calls ----
d_square = generate_iot(N(j), H, M);
rate = data_rate(N(j),1,d_square,pic,B,h0,noise); % generates ri
omega = channel_loss_power(N(j), beta_zero, d_square); %generates wi
tic = time_comm(N(j), omega, Pw_max, tw, pic); %generates the communication time for each IoTD

%----- produces result, the total data amount

%loop to generate di, the data amount for the ith IoTD
d = zeros(N(j),1);
for i = 1:N(j)
    d(i) = rate(i) * tic(i);
 
end
total_data_3(j) = total_data_3(j) + sum(d);
end
end

total_data_3 = total_data_3/K;



%----plotting graphs-----
%plot(B, total_data)
plot(N,total_data_1/1024,'k-+',N,total_data_2/1024,'k-*',N,total_data_3/1024,'k-o','LineWidth',0.6);
xlabel('Number of IoTDs')
ylabel('Total Data Transferred (Mbits)')
legend('B = 1GHz', 'B = 2GHz', 'B = 5GHz', 'Location', 'best')
