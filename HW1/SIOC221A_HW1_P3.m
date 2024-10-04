%% SIOC221A_HW1_P3

% Author: Trenton Saunders
% Date: 10-02-2024

%%
close all
clear all
clc

%%
load("SDtemp.mat")


%% Convert Time

Time = datetime(time,'ConvertFrom','datenum');

%% Calculate Temp in Deg F

temperature_degF = (temperature .* (9/5)) + 32;


%% Plot Time Series (3a)
figure
subplot(2,1,1)
plot(Time,temperature,'LineWidth',1)

xlabel('Time')
ylabel('Temperature [deg C]')
set(gca,'FontSize',18)

subplot(2,1,2)
plot(Time,temperature_degF,'LineWidth',1)

xlabel('Time')
ylabel('Temperature [deg F]')
set(gca,'FontSize',18)

%%  Plot Probability Distribution (3b)
Histogram_Function(temperature,'Temperature [Deg C]',100,1,"NEWFIG")
Histogram_Function(temperature_degF,'Temperature [Deg F]',100,1,"NEWFIG")

%% Return Interval: Day Above 40 degC (3c)
Prob_greater_40C = sum(temperature > 40) / ( ( sum(~isnan(temperature)) ) * (1/365) )

Return_Interval = (1/Prob_greater_40C)  %[years]

% 40 deg C = 104 F

%% Shifted pdf 
Histogram_Function(temperature+2,'Temperature [Deg C]',100,.5,"NEWFIG")
hold on
Histogram_Function(temperature,'Temperature [Deg C]',100,0,"NO_NEWFIG")

%% Shifted pdf - Return Inverval

Prob_greater_40C_Shifted = sum( (temperature + 2) > 40) / ( ( sum(~isnan(temperature)) ) * (1/365) ) 

Return_Interval_Shifted = (1/Prob_greater_40C_Shifted)  %[years]