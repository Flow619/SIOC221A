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
%% Plot Time Series
figure
subplot(2,1,1)
plot(Time, SST)


subplot(2,1,2)
plot(Time, SST_Fahrenheit)


%% Probability Distribution Function - Fahrenheit
Bins = linspace(min(SST_Fahrenheit),max(SST_Fahrenheit),11)

Temp_Binned = discretize(SST_Fahrenheit,Bins)

counts = [sum(Temp_Binned == 1),sum(Temp_Binned == 2),sum(Temp_Binned == 3),sum(Temp_Binned == 4),sum(Temp_Binned == 5)...
    sum(Temp_Binned == 6),sum(Temp_Binned == 7),sum(Temp_Binned == 8),sum(Temp_Binned == 9),sum(Temp_Binned == 10)]

probability = counts./sum(counts);

%% Probability Distribution Function - Celsius
Bins = linspace(min(SST),max(SST),11)

Temp_Binned = discretize(SST,Bins)

counts = [sum(Temp_Binned == 1),sum(Temp_Binned == 2),sum(Temp_Binned == 3),sum(Temp_Binned == 4),sum(Temp_Binned == 5)...
    sum(Temp_Binned == 6),sum(Temp_Binned == 7),sum(Temp_Binned == 8),sum(Temp_Binned == 9),sum(Temp_Binned == 10)]

probability = counts./sum(counts);


figure
histogram('BinEdges',Bins,'BinCounts',probability)
ylabel('Empirical Proability Distribution Function')
xlabel('Temperature [deg C]')