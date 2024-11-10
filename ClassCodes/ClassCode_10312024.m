close all;
clear all;
clc;

%% Load in Data
load('C:\Users\Trenton\Downloads\oct31_inclass.mat')

cd('C:\Users\Trenton\Documents\GitHub\SIOC221A\ClassCodes')
%% Plot Time Series
figure
plot(time,x)

%% Run myspectrum function

dt = time(2) - time(1);

[~,freq] = MySpectrum(x,dt)

%% 

time = 0:.0001:100;

x = 3* sin( 2.*time ) + 4*sin(time./2) + 3*sin(10.*time);

