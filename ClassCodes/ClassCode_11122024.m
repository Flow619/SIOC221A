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
Num_Segment = 8;

%% Figure out how many segments fit in the time sereis.

if rem( length(time),Num_Segment ) ~= 0
    disp('***User may want to pick another Num_Segment: Remainder***')
    Segment_Length = floor(length(time)/Num_Segment);
    Remainder = rem( length(time),Num_Segment);
else
    Segment_Length = length(time)/Num_Segment;
end

%% Override Time Series if Necessary
if exist('Remainder') == 1
    x_old = x;
    x = x(1:end-(Remainder));
end

%% Reshape your data into a matrix of segment length
x_Matrix = reshape(x,[Segment_Length,Num_Segment]);

%% calculate spectra for each segment
for i = 1:Num_Segment
    [P(:,i),freq] = MySpectrum(x_Matrix(:,i).',dt);
end

%% Average them together
Mean_P = mean(P,2);

%% Check Parseval's Theorem
Parseval.LeftSide = mean(x.^2);  % Full Time-Series
Parseval.RightSide = sum(Mean_P); % Why does this Work?!

%% Make approriate freq vector


%% figure
figure
loglog(freq,Mean_P,'c')