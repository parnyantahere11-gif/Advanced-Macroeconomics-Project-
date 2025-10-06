% ===========================================================
% Answer 2: Simulates IRFs under different habit persistence levels (h = 0, 0.4, 0.7)
% This version: 02.08.2025
% Dynare files: moncomp_stoch_h0_0.mod, moncomp_stoch_h0_4.mod, moncomp_stoch_h0_7.mod
% Output: IRFs for Output (Y), Inflation (π), Interest Rate (R), Consumption (C), Labor (N), TFP Shock (a)
% Author: Tahereh Parnian
% Tested: MATLAB_R2025a + Dynare 6.4
% ===========================================================

% Clear workspace and set Dynare path
clear all;
close all;
clc;

% Add Dynare to MATLAB path if needed
% addpath 'C:\dynare\6.4\matlab'  

%% ========== Run Dynare Simulations for Different h ==========
% h = 0
dynare moncomp_stoch_h0_0.mod noclearall
irf_h0_0 = oo_.irfs;

% h = 0.4
dynare moncomp_stoch_h0_4.mod noclearall
irf_h0_4 = oo_.irfs;

% h = 0.7
dynare moncomp_stoch_h0_7.mod noclearall
irf_h0_7 = oo_.irfs;

% Keep only first 20 periods
T = 1:20;

%% ========== Plot Output ==========
figure;
plot(T, irf_h0_0.Y_e(T), 'r', ...
     T, irf_h0_4.Y_e(T), 'g', ...
     T, irf_h0_7.Y_e(T), 'b', 'LineWidth', 2);
legend('h = 0', 'h = 0.4', 'h = 0.7');
title('Impulse Response of Output (Y)');
xlabel('Periods');
ylabel('Y response');
grid on;
print('IRF_Output', '-dpng', '-r300');

%% ========== Plot Inflation ==========
figure;
plot(T, irf_h0_0.PI_e(T), 'r', ...
     T, irf_h0_4.PI_e(T), 'g', ...
     T, irf_h0_7.PI_e(T), 'b', 'LineWidth', 2);
legend('h = 0', 'h = 0.4', 'h = 0.7');
title('Impulse Response of Inflation (\pi)');
xlabel('Periods');
ylabel('\pi response');
grid on;
print('IRF_Inflation', '-dpng', '-r300');

%% ========== Plot Interest Rate ==========
figure;
plot(T, irf_h0_0.R_e(T), 'r', ...
     T, irf_h0_4.R_e(T), 'g', ...
     T, irf_h0_7.R_e(T), 'b', 'LineWidth', 2);
legend('h = 0', 'h = 0.4', 'h = 0.7');
title('Impulse Response of Interest Rate (R)');
xlabel('Periods');
ylabel('R response');
grid on;
print('IRF_InterestRate', '-dpng', '-r300');

%% ========== Plot Consumption ==========
figure;
plot(T, irf_h0_0.C_e(T), 'r', ...
     T, irf_h0_4.C_e(T), 'g', ...
     T, irf_h0_7.C_e(T), 'b', 'LineWidth', 2);
legend('h = 0', 'h = 0.4', 'h = 0.7');
title('Impulse Response of Consumption (C)');
xlabel('Periods');
ylabel('C response');
grid on;
print('IRF_Consumption', '-dpng', '-r300');

%% ========== Plot Labor ==========
figure;
plot(T, irf_h0_0.N_e(T), 'r', ...
     T, irf_h0_4.N_e(T), 'g', ...
     T, irf_h0_7.N_e(T), 'b', 'LineWidth', 2);
legend('h = 0', 'h = 0.4', 'h = 0.7');
title('Impulse Response of Labor (N)');
xlabel('Periods');
ylabel('N response');
grid on;
print('IRF_Labor', '-dpng', '-r300');

%% ========== Plot TFP Shock (AR(1)) ==========
% This is the same across all models

% Parameters of AR(1) process
rho_a = 0.95;
sigma_a = 0.008;

a_shock = zeros(1, 20);
a_shock(1) = sigma_a;
for t = 2:20
    a_shock(t) = rho_a * a_shock(t-1);
end

% Plot TFP shock for all h (identical)
figure;
plot(T, a_shock, 'Color', [1, 0.6, 0], 'LineWidth', 2); hold on;  % h = 0
plot(T, a_shock, 'Color', [1, 0.4, 0], 'LineWidth', 2);          % h = 0.4
plot(T, a_shock, 'Color', [0.9, 0, 0.4], 'LineWidth', 2);        % h = 0.7
legend('h = 0', 'h = 0.4', 'h = 0.7');
title('Impulse Response of TFP Shock (identical across h)');
xlabel('Periods');
ylabel('TFP shock a_t');
grid on;
print('IRF_TFP_Shock', '-dpng', '-r300');
