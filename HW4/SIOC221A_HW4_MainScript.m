%% SIOC221: Homework #4
% Author: Trenton Saunders
% Date: 11/22/2024

%%
close all;
clear all;
clc;

%% 1. Load Data
load('C:\Users\Trenton\Downloads\midterm_dataset.mat')

%%
dt = time(2)-time(1);

%% Plot Full FFT
[FullFFT,Freq_Full] = MySpectrum(u,dt,'ON');
hold on

%% FFT Function
% Function Inputs: time series, dt, and number of windows
% Function Outputs: average spectrum, freq vector, error bars
Num_Windows = [6,18,40];
Colors = [0 0 1;1 0 0; 0 1 0];

for i = 1:3


    [Mean_P,freq,Error_Bars] = SpectralFunction_2(u,dt,Num_Windows(i));
    sum(Mean_P)*(freq(2)-freq(1))  % Parsevals
    
    
    %%  Plot
    plot( freq , Mean_P ,'linewidth',2, 'Color' , [Colors(i,:)] ,'DisplayName', ['Num Windows = ',num2str(Num_Windows(i))] ) % plot Mean Spectra
    errorbar(freq(end) + 30*(freq(2)-freq(1)) , Mean_P(end), ( 1 - Error_Bars(1)) * Mean_P(end) , (Error_Bars(2) - 1) * Mean_P(end),'Color',Colors(i,:),'LineWidth',2,'HandleVisibility','off') % Plot Error Bars

end

legend