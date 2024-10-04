%% SIOC 221A
%% Homework #1

% Author: Trenton Saunders
% Date: 10-02-2024

%%
close all
clear all
clc
%% RBR Toolbox Path

addpath('C:\Users\Trenton\Documents\MATLAB\Packages\rbr-rsktools-7a76410a599a\rbr-rsktools-7a76410a599a\')

%% Load Data
file = 'HW1Q1.rsk';
ClassData = RSKopen(file);


%%

DATA = RSKreaddata(ClassData)


%%  Pull Temperature Data
Temperature = DATA.data.values;


%% Plot (1.b)
figure
TIME_UTC = datetime(DATA.data.tstamp,'ConvertFrom','datenum','TimeZone','UTC')

plot(TIME_UTC,Temperature,'LineWidth',2.5)
xlabel('Time [UTC]')
ylabel('Temperature [Deg C]')
set(gca,'fontsize',20)
grid on


%%  Plot in Local Time (Not for HW)
% TIME_Local = TIME_UTC
% TIME_Local.TimeZone = 'America/Los_Angeles'
% 
% figure
% plot(TIME_Local,Temperature)

%% Calculate Mean and Std. Dev (1c)
Mean_Temperature = mean(Temperature)
Std_Temperature= std(Temperature)

disp(['Mean Temperature = ',num2str(Mean_Temperature)])
disp(['Stand. Dev Temperature = ',num2str(Std_Temperature)])


%% Create Probability Distribution Function (1d)

Histogram_Function(Temperature,'Temperature [deg C]',40,1,"NEWFIG")