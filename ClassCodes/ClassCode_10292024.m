close all
clear all
clc

%%
load('C:\Users\Trenton\Downloads\oct29_inclass.mat')

%% 
figure
plot(time,x)

%% FFT
X = fft(x);
X_shift = fftshift(fft(x))  % useful for visualizing the Fouriser transfrom with the zero-frew component in the middle of the spectrum

%%  Freq Vector
dt = 0.1;
T = time(end) - time(1);
fn = (1/(2*dt));
df = 1/T;

f = -fn:df:fn;

figure
plot(f,abs(X_shift))
