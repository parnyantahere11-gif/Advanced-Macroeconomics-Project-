
% ===============================================
% Answer 2_c: Consumption levels Plot
% This version: 24.07.2025
% Author: Tahereh Parnian
% Tested: MATLAB_R2024b 
% ===============================================

% Parameters
w = 0.7;
r = 0.2;
p = 1;
I = w + r;

% Generate a sequence of omega values from 0.01 to 0.99
omega = 0.01:0.01:0.99;

% Compute c1 and c2 for each omega
c1 = (1 - omega) * I;
c2 = omega * I / p;

% Plot the results
plot(omega, c1, 'b', 'LineWidth', 2); hold on;
plot(omega, c2, 'r', 'LineWidth', 2);
xlabel('\omega');
ylabel('Consumption');
title('Consumption Levels as a Function of \omega');
legend('c_1 (Durable Goods)', 'c_2 (Non-Durables & Services)');
grid on;

