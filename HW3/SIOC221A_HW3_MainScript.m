%% SIOC221A HW3: Main Script
% Author: Trenton Saunders
% Date: Nov 10th, 2024

%%
close all;
clear all;
clc;

%% Load Data
load('C:\Users\Trenton\Downloads\oct31_inclass.mat')

%% Calculate dt
dt = time(2) - time(1);

%% Use MySpectrum Function
cd()
