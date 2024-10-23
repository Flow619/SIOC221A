%% Plot
figure
plot(time,Temp,'.')
xlabel('Time [hours]')
ylabel('Temp [Deg C]')
%% Fit Line

A = [ones(1,length(time));time]';
y = Temp';

x = (inv(transpose(A)*A)) * (transpose(A)*y)

%% Plot Fit Line on Top of Data

hold on
y_bar = time.*x(2) + x(1)

plot(time,y_bar)

%% Sinosoidal
omega = (2*pi)/12.4;

A = [ones(1,length(time));sin(omega.*time);cos(omega.*time)]';
y = Temp';

x = (inv(transpose(A)*A)) * (transpose(A)*y)

hold on
y_bar = x(1) + x(2)*sin(omega.*time) + x(3)*cos(omega.*time)

plot(time,y_bar)

%% Sinosoidal + linear
omega = (2*pi)/12.4;

A = [ones(1,length(time));sin(omega.*time);cos(omega.*time);time]';
y = Temp';

x = (inv(transpose(A)*A)) * (transpose(A)*y)

hold on
y_bar = x(1) + x(2)*sin(omega.*time) + x(3)*cos(omega.*time) + x(4)*time;

plot(time,y_bar,'LineWidth',1.5)
