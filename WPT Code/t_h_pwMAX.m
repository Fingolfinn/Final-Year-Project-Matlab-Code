clear;
clc;
%---- constant defenitions ----
B = 2e9;  %2Ghz %bandwidth
%B = linspace(1e9, 5e9, 5);
N = 5%number of IoTDs
H = 5 %IoTD distance from ground ( z axis)
pic = 0.2; %200mW communication power - built in value for each IoTD, assumed to be same for all devices
%pic = linspace(0.1, 0.5, 5);
h0=1e-3;      %-30dB 
noise=1e-9;   %-60dBm noise
beta_zero = 1e-3; %-30dB
%Pw_max = 0.2 %?? maximum power of charging
Pw_max = linspace(0, 1, 7);
tw = 0.1 %?? charging time
M = 10; %mean distance from IoTDs to UAV

d_square = generate_iot(N, H, M); %generate d_square - only needs to be done once
L = length(Pw_max) % number of x values

%---Generating the total data----


%h0 = 1e-3; %-30dB
pic = 1;

for j = 1:L

%----- function calls ----
rate = data_rate(N,1,d_square,pic,B,h0,noise); % generates ri
omega = channel_loss_power(N, beta_zero, d_square); %generates wi
tic = time_comm(N, omega, Pw_max(j), tw, pic); %generates the communication time for each IoTD

%----- produces result, the total data amount

%sum all tic for total comm time

total_time(j) = sum(tic);

end

total_time_1 = total_time;
%tic_1 = tic;


pic = 2;

for j = 1:L

%----- function calls ----
rate = data_rate(N,1,d_square,pic,B,h0,noise); % generates ri
omega = channel_loss_power(N, beta_zero, d_square); %generates wi
tic = time_comm(N, omega, Pw_max(j), tw, pic); %generates the communication time for each IoTD

%----- produces result, the total data amount

%sum all tic for total comm time

total_time(j) = sum(tic);

end

total_time_2 = total_time;
%tic_2 = tic;

pic = 5;

for j = 1:L

%----- function calls ----
rate = data_rate(N,1,d_square,pic,B,h0,noise); % generates ri
omega = channel_loss_power(N, beta_zero, d_square); %generates wi
tic = time_comm(N, omega, Pw_max(j), tw, pic); %generates the communication time for each IoTD

%----- produces result, the total data amount

%sum all tic for total comm time

total_time(j) = sum(tic);

end

total_time_3 = total_time;
%tic_3 = tic;


%----plotting graphs-----
%plot(B, total_data)
plot(Pw_max,total_time_1,'k-+',Pw_max,total_time_2,'k-*',Pw_max,total_time_3,'k-o','LineWidth',0.6);
xlabel('Maximum Charging Power')
ylabel('Required Hovering Time (s)')
legend('Communication Power = 1W', 'Communication Power = 2W', 'Communication Power = 5W', 'Location', 'best')

hello = [400 0;0 400]
