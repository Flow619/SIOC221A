%% Class Code Nov 12th, 2024
close all;
clear all;
clc;
%% Add path of MySpectrum
addpath('C:\Users\Trenton\Documents\GitHub\SIOC221A\HW3')
%% Load Data
load('C:\Users\Trenton\Downloads\midterm_dataset.mat')

%% User Defined Variable for FFT
x = u;
dt = time(2) - time(1);
%% Pick the Number of segments
Num_Segment = 2;

%% Figure out how many segments fir in the time sereis.

if rem( length(time),Num_Segment) ~= 0
    disp('***User may want to pick another Num_Segment: Remainder***')
else
    Segment_Length = length(time)/Num_Segment;
end

%% Reshape your data into a matrix of segment length
x_Matrix = reshape(x,[Segment_Length,Num_Segment]);

%% calculate spectra for each segment
for i = 1:Num_Segment
    [P(:,i),freq] = MySpectrum(x_Matrix(:,i).',dt);
end

%% Average them together
Mean_P = mean(P,2);
%% Normalize Approprialty
Normalize_Mean_P = Mean_P/
%% Make approriate freq vector
