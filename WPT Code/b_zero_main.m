clear;
clc;
%---- constant defenitions ----
%B = 2e9;  %2Ghz %bandwidth
B = linspace(1e9, 10e9, 7);
N = 5%number of IoTDs
H = 5 %IoTD distance from ground ( z axis)
pic = 0.2; %200mW communication power - built in value for each IoTD, assumed to be same for all devices
h0=1e-3;      %-30dB 
noise=1e-9;   %-60dBm noise
beta_zero = 1e-3; %-30dB
Pw_max = 0.2 %?? maximum power of charging
tw = 0.1 %?? charging time
M = 10; %mean distance from IoTDs to UAV

d_square = generate_iot(N, H, M); %generate d_square - only needs to be done once
L = length(B) % number of x values

%---Generating the total data----


%h0 = 1e-3; %-30dB
beta_zero = 1e-3;

for j = 1:L

%----- function calls ----
rate = data_rate(N,1,d_square,pic,B(j),h0,noise); % generates ri
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
B_1 = B;


beta_zero = 1e-2; %-20dB

for j = 1:L

%----- function calls ----
rate = data_rate(N,1,d_square,pic,B(j),h0,noise); % generates ri
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
B_2 = B;

beta_zero = 1e-1; %-10dB

for j = 1:L

%----- function calls ----
rate = data_rate(N,1,d_square,pic,B(j),h0,noise); % generates ri
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
B_3 = B;


%----plotting graphs-----
%plot(B, total_data)
plot(B_1,total_data_1,'k-+',B_2,total_data_2,'k-*',B_3,total_data_3,'k-o','LineWidth',0.6);
xlabel('Bandwidth (Hz)')
ylabel('Total Data (bits)')
legend('B0 = -30dB', 'B0 = -20dB', 'B0 = -10dB', 'Location', 'best')
