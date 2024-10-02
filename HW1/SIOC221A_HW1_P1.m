%% SIOC 221A
%% Homework #1

%%
close all
clear all
clc
%%

addpath('C:\Users\Trenton\Documents\MATLAB\Packages\rbr-rsktools-7a76410a599a\rbr-rsktools-7a76410a599a\')

%% Load Data
file = 'HW1Q1.rsk';
ClassData = RSKopen(file);


%%

DATA = RSKreaddata(ClassData)


%%
Temperature = DATA.data.values;


%%
figure
TIME_UTC = datetime(DATA.data.tstamp,'ConvertFrom','datenum','TimeZone','UTC')

plot(TIME_UTC,Temperature)
xlabel('TIME - UTC')
ylabel('Temperature [Deg C]')



%%
TIME_Local = TIME_UTC
TIME_Local.TimeZone = 'America/Los_Angeles'

figure
plot(TIME_Local,Temperature)

%%
Mean_Temperature = mean(Temperature)
Std_Temperature= std(Temperature)

%%
Bins = linspace(min(Temperature),max(Temperature),11)

Temp_Binned = discretize(Temperature,Bins)

counts = [sum(Temp_Binned == 1),sum(Temp_Binned == 2),sum(Temp_Binned == 3),sum(Temp_Binned == 4),sum(Temp_Binned == 5)...
    sum(Temp_Binned == 6),sum(Temp_Binned == 7),sum(Temp_Binned == 8),sum(Temp_Binned == 9),sum(Temp_Binned == 10)]

probability = counts./sum(counts);


figure
histogram('BinEdges',Bins,'BinCounts',probability)
ylabel('Empirical Proability Distribution Function')
xlabel('Temperature [deg C]')