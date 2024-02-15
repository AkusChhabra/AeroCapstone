clc; clear; close all;

range = 1000;

figure(1)
line([0, 1], [0, 0], 'Color', 'black') % Takeoff
line([1, 5], [0, 1000], 'Color', 'red') % Climb to 1000 ft
line([5, 20], [1000, 10000], 'Color', 'black') % Climb to 10000 ft
line([20, 40], [10000, 35000], 'Color', 'red') % Climb to 35000 ft
line([40, 80], [35000, 35000], 'Color', 'black') % Cruise at 35000 ft
line([80, 100], [35000, 10000], 'Color', 'red') % Descend to 10000 ft
line([100, 110], [10000, 5000], 'Color', 'black') % Descend to 5000 ft
line([110, 120], [5000, 2000], 'Color', 'red') % Descend to 2000 ft
line([120, 130], [2000, 0], 'Color', 'black') % Landing
grid on
grid minor
xlabel('')
ylabel('Altitude (ft)')
title('Mission Profile')
ylim([0 40000])

% Diversion Segment