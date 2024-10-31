function [freq,X_Shift] = MySpectrum(x,dt,T,time_string)

%%
N = length(x)-1;

freq.lowest = 1/(N*dt);
freq.highest = 1/(2*dt);
freq.series = -freq.highest:freq.lowest:freq.highest;

%%
%%
X = fft(x);
X_Shift = fftshift(X);

%%
figure
plot(freq.series,X_Shift)




end