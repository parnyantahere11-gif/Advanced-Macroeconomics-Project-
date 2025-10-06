
% ===============================================
% Answer 1: Real GDP and Investment Share India
% Data Source: Penn World Tables (PWT, Version 10.01)(pwt1001_IND.csv)
% This version: 24.07.2025
% Author: Tahereh Parnian
% Tested: MATLAB_R2024b 
% ===============================================


% Load data

data = readtable('/Users/taherehehsan/Desktop/new/pwt1001_IND.csv');

% Extract variables
year = data.year;
rgdpe = data.rgdpe;
csh_i = data.csh_i;

% Compute average investment share (ignoring NaNs)
avg_csh_i = mean(csh_i, 'omitnan');

% Scale factor to match GDP scale
scale_factor = max(rgdpe) / max(csh_i);

% Scaled investment share
scaled_csh_i = csh_i * scale_factor;
avg_line = avg_csh_i * scale_factor;

% Plot
plot(year, rgdpe, 'b', 'LineWidth', 1.5); hold on;
plot(year, scaled_csh_i, 'r', 'LineWidth', 1.2);
yline(avg_line, '--', 'Color', [0.5 0 0]); % dashed dark red

% Labels and second y-axis
yyaxis left
ylabel('Real GDP (blue)')
yyaxis right
ylabel('Investment Share (red)')

title('India – Real GDP and Investment Share (PWT 10.01)')
xlabel('Year')
grid on
