clear;
clc;
%---- constant defenitions ----
B = 2e9;  %2Ghz %bandwidth
%B = linspace(1e9, 5e9, 5);
N = 5%number of IoTDs
H = 5 %IoTD distance from ground m ( z axis)
pic = 0.2; %200mW communication power - built in value for each IoTD, assumed to be same for all devices
h0=1e-3;      %-30dB 
%noise=1e-9;   %-90dBm noise
%noise = linspace(1e-9, 1e-6, 7);
noise = [1e-9, 5e-9, 1e-8, 5e-8, 1e-7, 5e-7, 1e-6];
beta_zero = 1e-3; %-30dB
Pw_max = 0.2 %?? maximum power of charging
tw = 0.1 %?? charging time
M = 10; %mean distance from IoTDs to UAV

d_square = generate_iot(N, H, M); %generate d_square - only needs to be done once
L = length(noise) % number of x values

%---Generating the total data----


%h0 = 1e-3; %-30dB
B = 1e9;

for j = 1:L

%----- function calls ----
rate = data_rate(N,1,d_square,pic,B,h0,noise(j)); % generates ri
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
rate = data_rate(N,1,d_square,pic,B,h0,noise(j)); % generates ri
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
rate = data_rate(N,1,d_square,pic,B,h0,noise(j)); % generates ri
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
plot(10*log10(noise),total_data_1,'k-+',10*log10(noise),total_data_2,'k-*',10*log10(noise),total_data_3,'k-o','LineWidth',0.6);
xlabel('Noise (dB)')
ylabel('Total Data (bits)')
legend('B = 1GHz', 'B = 2GHz', 'B = 5GHz', 'Location', 'best')
