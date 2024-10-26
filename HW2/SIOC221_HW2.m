%% SIOC 221A - HW2
% Author: Trenton Saunders
% Date: 10/22/2024

%%
close all;
clear all;
clc;

%% Load: National Data Buoy Center Buoy 46047
opts = detectImportOptions("DATA\46047h2022.txt\46047h2022.txt")
opts.SelectedVariableNames = {opts.VariableNames{1:5},opts.VariableNames{7},opts.VariableNames{9},opts.VariableNames{14:15}}
Data.h2022 = readtable("DATA\46047h2022.txt\46047h2022.txt",opts,"ReadVariableNames",true);

opts = detectImportOptions("DATA\46047h2023.txt\46047h2023.txt")
opts.SelectedVariableNames = {opts.VariableNames{1:5},opts.VariableNames{7},opts.VariableNames{9},opts.VariableNames{14:15}}
Data.h2023 = readtable("DATA\46047h2023.txt\46047h2023.txt",opts,"ReadVariableNames",true);
%% Plot Time Series
% Visual evaluation. Plot the time series of wind speed, wave height, water temperature, and air temperature for both years.
Data.h2022.Datenum = datenum(Data.h2022.x_YY,Data.h2022.MM,Data.h2022.DD,Data.h2022.hh,Data.h2022.mm, zeros(length(Data.h2022.mm),1) )
Data.h2023.Datenum = datenum(Data.h2023.x_YY,Data.h2023.MM,Data.h2023.DD,Data.h2023.hh,Data.h2023.mm, zeros(length(Data.h2023.mm),1) )

Data.h2022.Datetime = datetime(Data.h2022.Datenum,'ConvertFrom','datenum')
Data.h2023.Datetime = datetime(Data.h2023.Datenum,'ConvertFrom','datenum')

%% Plot Time Series (including bad data)

figure
subplot(4,1,1)
plot([Data.h2022.Datetime;Data.h2023.Datetime],[Data.h2022.WSPD;Data.h2023.WSPD],'.','MarkerSize',10)
ylabel('Wind Speed [m/s]','FontSize',12,'FontWeight','bold')

subplot(4,1,2)
plot([Data.h2022.Datetime;Data.h2023.Datetime],[Data.h2022.WVHT;Data.h2023.WVHT],'.','MarkerSize',10)
ylabel('Wave Height [m]','FontSize',12,'FontWeight','bold')

subplot(4,1,3)
plot([Data.h2022.Datetime;Data.h2023.Datetime],[Data.h2022.WTMP;Data.h2023.WTMP],'.','MarkerSize',10)
ylabel('Water Temp [deg C]','FontSize',12,'FontWeight','bold')

subplot(4,1,4)
plot([Data.h2022.Datetime;Data.h2023.Datetime],[Data.h2022.ATMP;Data.h2023.ATMP],'.','MarkerSize',10)
ylabel('Air Temp [deg C]','FontSize',12,'FontWeight','bold')

sgtitle('NDBC Buoy 46047','FontSize',20)

%% QC Plot Time Series

fig = figure
subplot(4,1,1)
hold on
Mask2022 = Data.h2022.WSPD < 90;
Mask2023 = Data.h2023.WSPD < 90;

plot([Data.h2022.Datetime(Mask2022);Data.h2023.Datetime(Mask2023)],[Data.h2022.WSPD(Mask2022);Data.h2023.WSPD(Mask2023)],'.')
ylabel('Wind Speed [m/s]','FontSize',12,'FontWeight','bold')

subplot(4,1,2)
hold on
Mask2022 = Data.h2022.WVHT < 90;
Mask2023 = Data.h2023.WVHT < 90;

plot([Data.h2022.Datetime(Mask2022);Data.h2023.Datetime(Mask2023)],[Data.h2022.WVHT(Mask2022);Data.h2023.WVHT(Mask2023)],'.')
ylabel('Wave Height [m]','FontSize',12,'FontWeight','bold')

subplot(4,1,3)
hold on
Mask2022 = Data.h2022.WTMP < 900;
Mask2023 = Data.h2023.WTMP < 900;

plot([Data.h2022.Datetime(Mask2022);Data.h2023.Datetime(Mask2023)],[Data.h2022.WTMP(Mask2022);Data.h2023.WTMP(Mask2023)],'.')
ylabel('Water Temp [deg C]','FontSize',12,'FontWeight','bold')

subplot(4,1,4)
hold on
Mask2022 = Data.h2022.ATMP < 900;
Mask2023 = Data.h2023.ATMP < 900;

plot([Data.h2022.Datetime(Mask2022);Data.h2023.Datetime(Mask2023)],[Data.h2022.ATMP(Mask2022);Data.h2023.ATMP(Mask2023)],'.')
ylabel('Air Temp [deg C]','FontSize',12,'FontWeight','bold')

sgtitle('NDBC Buoy 46047','FontSize',20)

%% Average the Data to Provide Monthly Means
Data.Monthly.WSPD = cell(24,6); % Columns: monthly Datetime values, monthly data, mean, std dev, length, standard error
Data.Monthly.WVHT = cell(24,6);
Data.Monthly.WTMP = cell(24,6);
Data.Monthly.ATMP = cell(24,6);

%% Create an Array of Datetime for plotting
YearMonth = datenum([2022*ones(12,1);2023*ones(12,1)],[[1:12]';[1:12]'],15*ones(24,1));
YearMonth = datetime(YearMonth,'ConvertFrom','datenum');

%% Write Function to Calculate Average (Write function to do this) (Question 3)
[Data.Monthly.WSPD,fig] = Monthly_NDBC_function(Data,Data.Monthly.WSPD,Data.h2022.WSPD,Data.h2023.WSPD,YearMonth,90,fig,1);
[Data.Monthly.WVHT,fig] = Monthly_NDBC_function(Data,Data.Monthly.WVHT,Data.h2022.WVHT,Data.h2023.WVHT,YearMonth,90,fig,2);
[Data.Monthly.WTMP,fig] = Monthly_NDBC_function(Data,Data.Monthly.WTMP,Data.h2022.WTMP,Data.h2023.WTMP,YearMonth,900,fig,3);
[Data.Monthly.ATMP,fig] = Monthly_NDBC_function(Data,Data.Monthly.ATMP,Data.h2022.ATMP,Data.h2023.ATMP,YearMonth,900,fig,4);


%% Least-squares fit (Q4) - Write this out as a function! Check with Classmates.
omega_2022 = (2*pi)/(size(Data.h2022,1));
omega_2023 = (2*pi)/(size(Data.h2023,1));


time_2022 = 1:size(Data.h2022,1);
time_2023 = 1:size(Data.h2023,1);

y_2022 = Data.h2022.ATMP;
y_2023 = Data.h2023.ATMP;

time_2022(y_2022 > 90) = [];
time_2023(y_2023 > 90) = [];

Temp2022_Datetime = Data.h2022.Datetime;
Temp2023_Datetime = Data.h2023.Datetime;

Temp2022_Datetime(y_2022 > 90) = [];
Temp2023_Datetime(y_2023 > 90) = [];

y_2022(y_2022 > 90) = [];
y_2023(y_2023 > 90) = [];


A_2022 = [ones(1,length(time_2022));sin(omega_2022.*time_2022);cos(omega_2022.*time_2022)]';
x_2022 = (inv(transpose(A_2022)*A_2022)) * (transpose(A_2022)*y_2022);

A_2023 = [ones(1,length(time_2023));sin(omega_2023.*time_2023);cos(omega_2023.*time_2023)]';
x_2023 = (inv(transpose(A_2023)*A_2023)) * (transpose(A_2023)*y_2023);

y_bar_2022 = x_2022(1) + x_2022(2)*sin(omega_2022.*time_2022) + x_2022(3)*cos(omega_2022.*time_2022);
y_bar_2023 = x_2023(1) + x_2023(2)*sin(omega_2023.*time_2023) + x_2023(3)*cos(omega_2023.*time_2023);


%% Least-squares fit a semi-annual cycle (Q5)