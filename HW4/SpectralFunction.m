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

reshape(x,[Num_per_Seg Num_windows])

end