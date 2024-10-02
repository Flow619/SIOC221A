%% SIOC221A_HW1_P2


%%
close all
clear all
clc

%%
addpath('C:\Users\Trenton\Documents\MATLAB\Packages\nctoolbox-master\nctoolbox-master')

%%
NetCDF_info = ncinfo('scripps-pier-automated-shore-sta-1_72eb_9b4d_09fa.nc')

%%
SST = ncread("scripps-pier-automated-shore-sta-1_72eb_9b4d_09fa.nc",'sea_water_temperature');
Time = ncread("scripps-pier-automated-shore-sta-1_72eb_9b4d_09fa.nc",'time');

SST_Fahrenheit = (SST .* (9/5)) + 32;


%% Convert Time
Time = datetime(Time,'ConvertFrom','epochtime')
%%
figure
subplot(2,1,1)
plot(Time, SST)


subplot(2,1,2)
plot(Time, SST_Fahrenheit)