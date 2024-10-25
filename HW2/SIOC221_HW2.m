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

%% Plot Time Series

figure
subplot(4,1,1)
plot([Data.h2022.Datetime;Data.h2023.Datetime],[Data.h2022.WSPD;Data.h2023.WSPD])
ylabel('Wind Speed []')

subplot(4,1,2)
plot([Data.h2022.Datetime;Data.h2023.Datetime],[Data.h2022.WVHT;Data.h2023.WVHT])
ylabel('Wave Height []')

subplot(4,1,3)
plot([Data.h2022.Datetime;Data.h2023.Datetime],[Data.h2022.WTMP;Data.h2023.WTMP])
ylabel('Water Temp [deg C]')

subplot(4,1,4)
plot([Data.h2022.Datetime;Data.h2023.Datetime],[Data.h2022.ATMP;Data.h2023.ATMP])
ylabel('Air Temp [deg C]')

%% QC Plot Time Series

figure
subplot(4,1,1)
Mask2022 = Data.h2022.WSPD < 90;
Mask2023 = Data.h2023.WSPD < 90;

plot([Data.h2022.Datetime(Mask2022);Data.h2023.Datetime(Mask2023)],[Data.h2022.WSPD(Mask2022);Data.h2023.WSPD(Mask2023)],'.')
ylabel('Wind Speed []')

subplot(4,1,2)
Mask2022 = Data.h2022.WVHT < 90;
Mask2023 = Data.h2023.WVHT < 90;

plot([Data.h2022.Datetime(Mask2022);Data.h2023.Datetime(Mask2023)],[Data.h2022.WVHT(Mask2022);Data.h2023.WVHT(Mask2023)],'.')
ylabel('Wave Height []')

subplot(4,1,3)
Mask2022 = Data.h2022.WTMP < 900;
Mask2023 = Data.h2023.WTMP < 900;

plot([Data.h2022.Datetime(Mask2022);Data.h2023.Datetime(Mask2023)],[Data.h2022.WTMP(Mask2022);Data.h2023.WTMP(Mask2023)],'.')
ylabel('Water Temp [deg C]')

subplot(4,1,4)
Mask2022 = Data.h2022.ATMP < 900;
Mask2023 = Data.h2023.ATMP < 900;

plot([Data.h2022.Datetime(Mask2022);Data.h2023.Datetime(Mask2023)],[Data.h2022.ATMP(Mask2022);Data.h2023.ATMP(Mask2023)],'.')
ylabel('Air Temp [deg C]')


%% Average the Data to Provide Monthly Means
Data.Monthly.WSPD = cell(24,6); % Columns: monthly Datetime values, monthly data, mean, std dev, length, standard error
Data.Monthly.WVHT = cell(24,6);
Data.Monthly.WTMP = cell(24,6);
Data.Monthly.ATMP = cell(24,6);

%% Create an Array of Datetime for plotting
YearMonth = datenum([2022*ones(12,1);2023*ones(12,1)],[[1:12]';[1:12]'],15*ones(24,1));
YearMonth = datetime(YearMonth,'ConvertFrom','datenum');

%% Write Function to Calculate Average (Write function to do this)

for i = 1:24
    if i <= 12
        Data.Monthly.WSPD{i,1} = Data.h2022.Datetime( Data.h2022.MM == i & Data.h2022.WSPD < 90 );
        Data.Monthly.WSPD{i,2} = Data.h2022.WSPD ( Data.h2022.MM == i & Data.h2022.WSPD < 90 ) ;
        Data.Monthly.WSPD{i,3} = mean(Data.Monthly.WSPD{i,2});
        Data.Monthly.WSPD{i,4} = std(Data.Monthly.WSPD{i,2});
        Data.Monthly.WSPD{i,5} = length(Data.Monthly.WSPD{i,2} );
        Data.Monthly.WSPD{i,6} = Data.Monthly.WSPD{i,4} / (sqrt( Data.Monthly.WSPD{i,5} / (7*24*6) ));

        % plot( Data.Mean.WSPD{i,1},Data.Mean.WSPD{i,2},'.')
    else
        Data.Monthly.WSPD{i,1} = Data.h2023.Datetime( Data.h2023.MM == (i-12) & Data.h2023.WSPD < 90 );
        Data.Monthly.WSPD{i,2} = Data.h2023.WSPD ( Data.h2023.MM == (i-12) & Data.h2023.WSPD < 90 ) ;
        Data.Monthly.WSPD{i,3} = mean(Data.Monthly.WSPD{i,2});
        Data.Monthly.WSPD{i,4} = std(Data.Monthly.WSPD{i,2});
        Data.Monthly.WSPD{i,5} = length(Data.Monthly.WSPD{i,2} );
        Data.Monthly.WSPD{i,6} = Data.Monthly.WSPD{i,4} / (sqrt( Data.Monthly.WSPD{i,5} / (7*24*6) ));

        % plot( Data.Mean.WSPD{i,1},Data.Mean.WSPD{i,2},'.')
    end

end

figure
errorbar(YearMonth,[Data.Monthly.WSPD{:,3}],[Data.Monthly.WSPD{:,6}])

%% Plot Monthly Mean and Std. dev



figure
plot(YearMonth,[Data.Monthly.WSPD{:,3}],'.')