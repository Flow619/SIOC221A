function [Avg_P,freq,Error_Bars] = SpectralFunction(x,dt,Num_windows);

%%
% Author: Trenton Saunders
% Date: 11/22/2024
%% 3. Now within the function - break into m segments of length N_seg of your choosing. The data set is unlikely to be exactly m * N_seg long, so you may have to cut out the last bit.

Num_Series = length(x);

Num_per_Seg = floor(Num_Series/Num_windows);

Num_Series = Num_per_Seg * Num_windows;
x = x(1:Num_Series);


if rem(Num_per_Seg,2) ~= 0
    error('N_seg is not even. This will create issues with generating equally sized chunks. Please choose a new Num_windows.')
end

X = reshape(x,[Num_per_Seg Num_windows]);

%% 4. Now make more segments which are half-overlapping between the first set of segments. You will probably have 2*m - 1 segments totaL
X_chunks = nan( Num_per_Seg , ((2*Num_windows)-1) );
FFT_chunks = nan( (Num_per_Seg/2) + 1 , ((2*Num_windows)-1) );

Hanning = hann(Num_per_Seg);
Hanning = length(Hanning)/sum(Hanning).*Hanning;

for i = 1:((2*Num_windows)-1)
    X_chunks(:,i) = x( ((i-1)*(Num_per_Seg/2)) + 1 : (((i-1)*(Num_per_Seg/2))) + Num_per_Seg );

    X_chunks(:,i) =  detrend(X_chunks(:,i)); % 4.a Detrend

    X_chunks(:,i) = Hanning.* (X_chunks(:,i)); % 4.b Apply a window to each segment. The "Hanning" windo is a decent all around choice

    [FFT_chunks(:,i),freq] = MySpectrum(X_chunks(:,i).',dt); % 4.c FFT each segment

end

%% 5 Average the spectra from each segment together
Mean_P = mean(FFT_chunks,2);

end