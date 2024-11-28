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

%% FFT Function
% Function Inputs: time series, dt, and number of windows
% Function Outputs: average spectrum, freq vector, error bars
[Mean_P,freq,Error_Bars] = SpectralFunction_2(u,dt,10);
sum(Mean_P)*(freq(2)-freq(1))  % Parsevals


%%  Plot
hold on
plot(freq,Mean_P,'r') % plot Mean Spectra
errorbar(freq(end) + 10*(freq(2)-freq(1)) , Mean_P(end), ( 1 - Error_Bars(1)) * Mean_P(end) , (Error_Bars(2) - 1) * Mean_P(end),'r','LineWidth',2) % Plot Error Bars
