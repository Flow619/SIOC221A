%% SIOC221A_HW1_P3

%%
close all
clear all
clc

%%
load("SDtemp.mat")


%% Plot

Time = datetime(time,'ConvertFrom','datenum')

figure
plot(Time,temperature)

%% 
