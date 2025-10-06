

% ===============================================
% Answer 2: Simulates how the steady-state investment share (I/Y) depends on ρ
% This version: 27.07.2025
% dynare file:ramsey_ishare.mod 
% Author: Tahereh Parnian
% Tested: MATLAB_R2024b 
% ===============================================


clear; close all; clc;

% Load initial Dynare model to set up structures
dynare ramsey_ishare noclearall;

% Settings
II = 20;
rho_start = 0.01;
rho_step = 0.005;

rho_vec = zeros(1, II);
ishare_vec = zeros(1, II);
y_vec = zeros(1, II);

% Loop through rho values
for ii = 1:II
    rho = rho_start + (ii - 1) * rho_step;
    rho_vec(ii) = rho;

    % Update parameter
    set_param_value('rho', rho);

    % Recalculate steady state
    steady;

    % Extract steady-state values
    ishare_vec(ii) = oo_.steady_state(strmatch('ishare', M_.endo_names, 'exact'));
    y_vec(ii) = oo_.steady_state(strmatch('y', M_.endo_names, 'exact'));
end

% Plot I/Y vs rho
figure;
plot(rho_vec, ishare_vec, 'b-o', 'LineWidth', 2);
xlabel('\rho (Time Preference Rate)', 'FontSize', 12);
ylabel('Investment Share (I/Y)', 'FontSize', 12);
title('Steady-State Investment Share vs. \rho', 'FontWeight', 'bold');
grid on;

% Plot Y vs rho
figure;
plot(rho_vec, y_vec, 'r-s', 'LineWidth', 2);
xlabel('\rho (Time Preference Rate)', 'FontSize', 12);
ylabel('Output (Y)', 'FontSize', 12);
title('Steady-State Output vs. \rho', 'FontWeight', 'bold');
grid on;

disp('Simulation complete.');
