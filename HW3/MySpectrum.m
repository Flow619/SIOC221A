function [P,freq] = MySpectrum(x,dt)

    %% Class Prompt
    % [P,freq] = myspectrum(x(t),dt)
    
    %% FFT
    % 1. First Step in your function should be to fft the x(t) time series, and fftshift it to a sensible order.
    X = fft(x);  % MATLAB outputs the zero freq, positive freq, and then neg freq
    X_Shift = fftshift(X);    % shift the values so it goes negatvie, zero, and then positive freq
    
    %% Define Freq Vector
    % 2. Next create a frequency vector. What we walked about in class is that an
    % initialfrequency vector that goes with your fftshifted fft would look
    % something like -fn:df:fn
    % fn is the nyquist frequency and df is the spacing between frequency
    % points (and also the lowest frequency you can fit to the time series).
    
    N = length(x); % Num of points in time series 
    
    frequency.lowest = 1/(N*dt);  % Longest Period (full time-series); smallest frequency
    frequency.highest = 1/(2*dt);  % Shortest Period; highest frequency (Nyquiest Freq)
    frequency.series = -frequency.highest:frequency.lowest:frequency.highest;
    
    %%  ONE & TWO SIDED Freq
    % 3. Depending on whether your time series is odd or even, you may need to
    % eliminate one of the endpoints (making it fn - df)
    % This Code is written based on example/explanation in
    % (https://www.youtube.com/watch?v=QmgJmh2I3Fw&ab_channel=MATLAB)
    
    if mod(N,2) ~= 0 % Time Series is Odd (Nyquiest freq skipped!)
    X_onesided =  X( 1: ceil(N/2) );
    frequency.onesided = 0:frequency.lowest:(length(X_onesided)-1)*frequency.lowest;
    frequency.twosided = 0:frequency.lowest:(length(X)-1)*frequency.lowest;
    
    elseif mod(N,2) == 0  % Time Series is Even (Nyquist freq included)
    X_onesided = X( 1: ((N/2) + 1) );
    frequency.onesided = 0:frequency.lowest:(length(X_onesided)-1)*frequency.lowest;
    frequency.twosided = 0:frequency.lowest:(length(X)-1)*frequency.lowest;
    
    end
    
    %% Square the Absolute Value of the Coefficients
    % 4. Calculate your spectrum by squaring the absolute value of the coefficient of your fft-ed time series and normalizing as discussed in class
    Abs_Squared_X = abs(X).^2;
    
    %% Combine the Positive and Negative Frequnecies
    % 5. parts of the specrtrum that correspond to positive and negative
    % frequencies has amplitudes that are complex conjugates of each other,
    % meaning they have the same magnitude.
    
    if mod(N,2) ~= 0 % Time Series is Odd (Nyquiest freq skipped!)
    X_PostiveFreq = Abs_Squared_X(2:ceil(N/2));
    Temp = fliplr(Abs_Squared_X);
    X_NegativeFreq = Temp(1:ceil(N/2)-1);
    
    Abs_Squared_X_Onesided = [Abs_Squared_X(1) , (X_PostiveFreq + X_NegativeFreq)];
    
    elseif mod(N,2) == 0  % Time Series is Even (Nyquist freq included)
    X_PostiveFreq = Abs_Squared_X(2: (N/2) );
    Temp = fliplr(Abs_Squared_X);
    X_NegativeFreq = Temp(1:(N/2)-1);
    
    Abs_Squared_X_Onesided = [Abs_Squared_X(1) , (X_PostiveFreq + X_NegativeFreq),  Abs_Squared_X((N/2) + 1) ];
    
    end
    
    %% Parseval's Theorem
    % 7. Once your function is working, check that is satisfies Parseval's
    % Theorem
    Parseval.LeftSide = mean(x.^2);
    Parseval.RightSide = sum(Abs_Squared_X_Onesided)/(N*N);

    fprintf('Parseval Left Side = %0.10f (units of x(t))^{2} \n',Parseval.LeftSide)
    fprintf('Parseval Right Side =  = %0.10f (units of x(t))^{2} \n',Parseval.RightSide )


    P = Abs_Squared_X_Onesided./(N*N);
    freq = frequency.onesided;
    
    %% LogLog Plot
    % 8. Make a log-log plot of your spectrum versus frequency. 
    figure
    loglog(freq,P,'LineWidth',1)
    grid on
    xlabel('Frequncy [Hz?]')
    ylabel('Power [$\frac{(units of x(t))^{2}}{Hz}$]','Interpreter','latex')
    set(gca,'FontSize',22,'FontName','Courier')
end