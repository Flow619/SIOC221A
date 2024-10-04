%% SIOC221A_HW1_P2

% Author: Trenton Saunders
% Date: 10-02-2024


%%
close all
clear all
clc

%%  NCTOOLBOX
addpath('C:\Users\Trenton\Documents\MATLAB\Packages\nctoolbox-master\nctoolbox-master')

%% Inspect netCDF file
NetCDF_info = ncinfo('scripps-pier-automated-shore-sta-1_72eb_9b4d_09fa.nc');

%%  Pull Relevant Data from netCDF file
SST = ncread("scripps-pier-automated-shore-sta-1_72eb_9b4d_09fa.nc",'sea_water_temperature');
Time = ncread("scripps-pier-automated-shore-sta-1_72eb_9b4d_09fa.nc",'time');

%% Convert to Fahrenheit
SST_Fahrenheit = (SST .* (9/5)) + 32;

%% Convert Time
Time = datetime(Time,'ConvertFrom','epochtime');

%% Plot Time Series (2d)
figure
subplot(2,1,1)
plot(Time, SST)
xlabel('Time [Pacific Time Zone]')
ylabel('SST [deg C]')
set(gca,'fontsize',18)
grid on

subplot(2,1,2)
plot(Time, SST_Fahrenheit)
xlabel('Time [Pacific Time Zone]')
ylabel('SST [deg F]')
set(gca,'fontsize',18)
grid on



%% Probability Distribution Function - Fahrenheit (2e)
Histogram_Function(SST_Fahrenheit,'SST [deg F]',40,1,"NEWFIG")
%% Probability Distribution Function - Celsius (2e)
Histogram_Function(SST,'SST [deg C]',40,1,"NEWFIG")
