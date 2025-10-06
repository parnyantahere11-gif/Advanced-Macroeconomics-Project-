
% ===============================================
% Answer 1_a: Czech Household Consumption Plot
% Data Source: Eurostat (cz_clean_consumption.csv)
% This version: 24.07.2025
% Author: Tahereh Parnian
% Tested: MATLAB_R2024b 
% ===============================================

close all;
fig_counter = 0;

% Specify what is to be done
% --------------------------
LoadData     = 1;
DefineVars   = 1;
PlotOverview = 1;

% Check for Matlab/Octave
% -----------------------
MyEnv.Octave = exist('OCTAVE_VERSION', 'builtin') ~= 0;
MyEnv.Matlab = ~MyEnv.Octave;

% Load packages (Octave only)
% ---------------------------
if ~MyEnv.Matlab
    pkg load io;
    pkg load dataframe;
end

% Colorblind barrier-free color palette
BfBlack        = [   0,   0,   0 ] / 255;
BfOrange       = [ 230, 159,   0 ] / 255;
BfSkyBlue      = [  86, 180, 233 ] / 255;
BfBluishGreen  = [   0, 158, 115 ] / 255;
BfYellow       = [ 240, 228,  66 ] / 255;
BfBlue         = [   0, 114, 178 ] / 255;
BfVermillon    = [ 213,  94,   0 ] / 255;
BfRedishPurple = [ 204, 121, 167 ] / 255;

% Line Properties
StdLineWidth = 2;
data = readtable('/Users/taherehehsan/Desktop/new/cz_clean_consumption.csv');


% Define variables
% --------------------------------------------------
if DefineVars == 1
    % Convert "time" (e.g., "2010-Q1") to datetime format
    split_time = split(data.time, '-Q');
    year = str2double(split_time(:,1));
    quarter = str2double(split_time(:,2));
    month = 3 * (quarter - 1) + 1; % Jan, Apr, Jul, Oct
    data.date = datetime(year, month, 1);

    % Extract relevant series
    food_bev = data.P311_S14_food_bev;
    non_durable = data.P312N_S14_non_durable_excl_food;
    time_axis = data.date;
end

% Plot time series overview
% --------------------------------------------------
if PlotOverview
    fig_counter = fig_counter + 1;
    hf = figure(fig_counter);
    
    plot(time_axis, food_bev, 'Color', BfBlue, 'LineWidth', StdLineWidth); hold on;
    plot(time_axis, non_durable, 'Color', BfOrange, 'LineWidth', StdLineWidth);
    
    title('Household Consumption in Czech Republic');
    subtitle('2010-Q1 to Latest, Real Values (CLV10_MEUR)');
    xlabel('Quarter');
    ylabel('Million EUR (2010 Prices)');
    legend({'Durable Goods', 'Non-Durables & Services'}, 'Location', 'best');
    grid on;
    box on;

    % Save figure (optional)
    DoSavePlots = 1;
    if DoSavePlots
        saveas(hf, 'CZ_Consumption_Overview', 'png');
    end
end
