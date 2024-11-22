%% SIOC221: Homework #4
% Author: Trenton Saunders
% Date: 11/22/2024

%%
close all;
clear all;
clc;

%% 1. Load Data
load('C:\Users\Trenton\Downloads\midterm_dataset.mat')

%% FFT Function
% Function Inputs: time series, dt, and number of windows
% Function Outputs: average spectrum, freq vector, error bars
[Avg_P,freq,Error_Bars] = SpectralFunction(x,dt,Num_windows);

%%

