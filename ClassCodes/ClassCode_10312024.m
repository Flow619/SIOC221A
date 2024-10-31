close all;
clear all;
clc;

%% Load in Data
load('C:\Users\Trenton\Downloads\oct31_inclass.mat')

%% Plot Time Series
figure
plot(time,x)

%%
dt = time(2)-time(1);
T = time(end) - time(1);

[freq,X_Shift] = MySpectrum(x,dt,[],[]);


figure
plot(freq.series,X_Shift)