clear;
clc;
%---- constant defenitions ----
B = 2e9;  %2Ghz %bandwidth
%B = linspace(1e9, 5e9, 5);
N = 5%number of IoTDs
H = 5 %IoTD distance from ground ( z axis)
%pic = 0.2; %200mW communication power - built in value for each IoTD, assumed to be same for all devices
pic = linspace(0.1, 1, 7);
h0=1e-3;      %-30dB 
noise=1e-9;   %-60dBm noise
beta_zero = 1e-3; %-30dB
Pw_max = 0.2 %?? maximum power of charging
tw = 0.1 %?? charging time
M = 10; %mean distance from IoTDs to UAV

d_square = generate_iot(N, H, M); %generate d_square - only needs to be done once
L = length(pic) % number of x values

%---Generating the total data----


%h0 = 1e-3; %-30dB
Pw_max = 0.1

for j = 1:L

%----- function calls ----
rate = data_rate(N,1,d_square,pic(j),B,h0,noise); % generates ri
omega = channel_loss_power(N, beta_zero, d_square); %generates wi
tic = time_comm(N, omega, Pw_max, tw, pic(j)); %generates the communication time for each IoTD

%----- produces result, the total data amount

%sum all tic for total comm time

total_time(j) = sum(tic);

end

total_time_1 = total_time;
%tic_1 = tic;


Pw_max = 0.2

for j = 1:L

%----- function calls ----
rate = data_rate(N,1,d_square,pic(j),B,h0,noise); % generates ri
omega = channel_loss_power(N, beta_zero, d_square); %generates wi
tic = time_comm(N, omega, Pw_max, tw, pic(j)); %generates the communication time for each IoTD

%----- produces result, the total data amount

%sum all tic for total comm time

total_time(j) = sum(tic);

end

total_time_2 = total_time;
%tic_2 = tic;

Pw_max = 0.5

for j = 1:L

%----- function calls ----
rate = data_rate(N,1,d_square,pic(j),B,h0,noise); % generates ri
omega = channel_loss_power(N, beta_zero, d_square); %generates wi
tic = time_comm(N, omega, Pw_max, tw, pic(j)); %generates the communication time for each IoTD

%----- produces result, the total data amount

%sum all tic for total comm time

total_time(j) = sum(tic);

end

total_time_3 = total_time;
%tic_3 = tic;


%----plotting graphs-----
%plot(B, total_data)
plot(pic,total_time_1,'k-+',pic,total_time_2,'k-*',pic,total_time_3,'k-o','LineWidth',0.6);
xlabel('Power used in communications(W)')
ylabel('Hovering Time (s)')
legend('Max Charging Power = 0.1W', 'Max Charging Power = 0.2W', 'Max Charging Power = 0.5W', 'Location', 'best')
