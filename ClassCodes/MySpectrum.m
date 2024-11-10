function [P,freq] = MySpectrum(x,dt)

%% Class Prompt
% [P,freq] = myspectrum(x(t),dt)

% - Is this enough infomration to feed in?
% - Let's say you want a one-sided freq spectrum to come out.
% - Goal. Demonstrate that you can create a function such that if you put
% in x(t), you get out a spectrum that satisfies parseval's theorm.
% - Plot your spectrum on a log-log plot (why does this seem useful)?
% - What are the units for the y-axis?

%% Define Freq Vector
N = length(x); % Num of points in time series 

freq.lowest = 1/(N*dt);  % Longest Period
freq.highest = 1/(2*dt);  % Shortest Period (Nyquiest Freq)
freq.series = -freq.highest:freq.lowest:freq.highest;

%%
%%
X = fft(x);  % MATLAB outputs the zero freq, positive freq, and then neg freq
X_Shift = fftshift(X);    % shift the values so it goes negatvie, zero, and then positive freq

%%  ONE SIDED

if mod(N,2) ~= 0 % Odd (Nyquiest freq skipped!)
X_onesided =  X( 1: ceil(N/2) );
freq.onesided = 0:freq.lowest:(length(X_onesided)-1)*freq.lowest;

elseif mod(N,2) == 0  % Even (Nyquist freq included)
X_onesided = X( 1: (N/2) + 1);
freq.onesided = 0:freq.lowest:(length(X_onesided)-1)*freq.lowest;

end

figure
plot(freq.onesided,abs(X_onesided))


figure
loglog([freq.onesided(1),freq.onesided(2:end)],[abs(X_onesided(1)), abs(X_onesided(2:end)).^2 ] )
xlabel('freq [days^{-1}]')
ylabel('Amplitude Squared [m^{2}/s^{2}]')
title(' Fourier transform of Nordic Sea Velocity Data (amplitude squared)')
set(gca,'FontSize',22)
%% Satisfty Parseval's Theorem
LeftSide = sum(abs(x).^2)
RightSide = sum((abs(X_onesided)).^2) / N
P = (LeftSide/RightSide).*abs(X_onesided);

%%
figure
loglog(freq.onesided,P)

end