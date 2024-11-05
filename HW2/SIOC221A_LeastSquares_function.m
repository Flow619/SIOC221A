function [x_2022,x_2023,fig] = SIOC221A_LeastSquares_function(omega_2022,omega_2023,Data,Var_2022,Var_2023,Threshold,fig,Subplot_Number)

time_2022 = 1:size(Data.h2022,1);
time_2023 = 1:size(Data.h2023,1);

y_2022 = Var_2022;
y_2023 = Var_2023;

time_2022(y_2022 > Threshold) = [];  % Remove bad data
time_2023(y_2023 > Threshold) = [];

Temp2022_Datetime = Data.h2022.Datetime;
Temp2023_Datetime = Data.h2023.Datetime;

Temp2022_Datetime(y_2022 > Threshold) = [];  % remove bad data
Temp2023_Datetime(y_2023 > Threshold) = [];

y_2022(y_2022 > Threshold) = [];   % remove bad data
y_2023(y_2023 > Threshold) = [];

%%
if length(fieldnames(omega_2022)) == 1

A_2022 = [ones(1,length(time_2022));sin(omega_2022.annual.*time_2022);cos(omega_2022.annual.*time_2022)]'; % [1 sin(omega*t1) cos(omega*t1)]
x_2022 = (inv(transpose(A_2022)*A_2022)) * (transpose(A_2022)*y_2022);

A_2023 = [ones(1,length(time_2023));sin(omega_2023.annual.*time_2023);cos(omega_2023.annual.*time_2023)]';
x_2023 = (inv(transpose(A_2023)*A_2023)) * (transpose(A_2023)*y_2023);  % x = inv(transpose(A)*A) * transpose(A)*y

y_bar_2022 = x_2022(1) + x_2022(2)*sin(omega_2022.annual.*time_2022) + x_2022(3)*cos(omega_2022.annual.*time_2022);  % Predicted Values (i.e., A*x)
y_bar_2023 = x_2023(1) + x_2023(2)*sin(omega_2023.annual.*time_2023) + x_2023(3)*cos(omega_2023.annual.*time_2023);


figure(fig)
subplot(4,1,Subplot_Number)
hold on
plot(Temp2022_Datetime,y_bar_2022,'r','LineWidth',3)
plot(Temp2023_Datetime,y_bar_2023,'r','LineWidth',3)

%%
elseif length(fieldnames(omega_2022)) == 2

A_2022 = [ones(1,length(time_2022)); sin(omega_2022.annual.*time_2022); cos(omega_2022.annual.*time_2022); sin(omega_2022.semiannual.*time_2022); cos(omega_2022.semiannual.*time_2022)]'; % [1 sin(omega1*t1) cos(omega1*t1) sin(omega2*t1) cos(omega2*t1)]
x_2022 = (inv(transpose(A_2022)*A_2022)) * (transpose(A_2022)*y_2022);

A_2023 = [ones(1,length(time_2023)); sin(omega_2023.annual.*time_2023); cos(omega_2023.annual.*time_2023); sin(omega_2023.semiannual.*time_2023); cos(omega_2023.semiannual.*time_2023)]';
x_2023 = (inv(transpose(A_2023)*A_2023)) * (transpose(A_2023)*y_2023);

y_bar_2022 = x_2022(1) + x_2022(2)*sin(omega_2022.annual.*time_2022) + x_2022(3)*cos(omega_2022.annual.*time_2022) + x_2022(4)*sin(omega_2022.semiannual.*time_2022) + x_2022(5)*cos(omega_2022.semiannual.*time_2022);
y_bar_2023 = x_2023(1) + x_2023(2)*sin(omega_2023.annual.*time_2023) + x_2023(3)*cos(omega_2023.annual.*time_2023) + x_2023(4)*sin(omega_2023.semiannual.*time_2023) + x_2023(5)*cos(omega_2023.semiannual.*time_2023);

figure(fig)
subplot(4,1,Subplot_Number)
hold on
plot(Temp2022_Datetime,y_bar_2022,'g','LineWidth',3)
plot(Temp2023_Datetime,y_bar_2023,'g','LineWidth',3)


end
%% Plot



end