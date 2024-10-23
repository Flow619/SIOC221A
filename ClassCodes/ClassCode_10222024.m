%% Import Data
close all
clear all
clc

load('C:\Users\Trenton\Downloads\oct22_inclass.mat')

%% Plot
figure
plot(time,Temp,'.')
xlabel('Time [hours]')
ylabel('Temp [Deg C]')
%% Fit Line

%% Plot Fit Line on Top of Data


%% Sinosoidal
omega = (2*pi)/12.4;
omega2 = (2*pi)/12;

A = [ones(1,length(time));sin(omega.*time);cos(omega.*time);sin(omega2.*time);cos(omega2.*time)]';
y = Temp';

x = (inv(transpose(A)*A)) * (transpose(A)*y)

hold on
y_bar = x(1) + x(2)*sin(omega.*time) + x(3)*cos(omega.*time) + x(4)*sin(omega2.*time) + x(5)*cos(omega2.*time)

plot(time,y_bar)

