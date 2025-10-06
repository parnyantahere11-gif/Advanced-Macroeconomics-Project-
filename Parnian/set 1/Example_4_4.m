% ========================================================
% Example 4.4: Plot PWT Data
% This version: 06.11.2024
% Author: Oliver Holtemoeller
% Tested: MATLAB R2024a
% ========================================================

close all;
clear all;

% Specify what is to be done
% --------------------------
LoadPWTData     = 1;
DefineMacroVars = 1;
PlotOverviewDEU = 1;
DoSavePlots     = 0;

% Check for Matlab/Octave
% -----------------------
MyEnv.Octave = exist('OCTAVE_VERSION', 'builtin') ~= 0;
MyEnv.Matlab = ~MyEnv.Octave;

% Load packages (Octave only)
% ---------------------------
if ~MyEnv.Matlab,
  pkg load io;
  pkg load dataframe;
end;

% Some useful defintions
% ----------------------
fig_counter = 0;

% Colorblind barrier-free color pallet
BfBlack        = [   0,   0,   0 ]/255;
BfOrange       = [ 230, 159,   0 ]/255;
BfSkyBlue      = [  86, 180, 233 ]/255;
BfBluishGreen  = [   0, 158, 115 ]/255;
BfYellow       = [ 240, 228,  66 ]/255;
BfBlue         = [   0, 114, 178 ]/255;
BfVermillon    = [ 213,  94,   0 ]/255;
BfRedishPurple = [ 204, 121, 167 ]/255;

% Line Properties
StdLineWidth = 2;

% Load data from Penn World Table
% -------------------------------
if LoadPWTData,
  if MyEnv.Matlab,
    PWT=readtable('../../data/pwt1001small.csv');
  end;
  if MyEnv.Octave,
    PWT=dataframe('../../data/pwt1001small.csv');
  end;
  % Set subsample for Germany
  PWT_DEU = PWT(strcmp(cellstr(PWT.countrycode),'DEU') & PWT.year>=1991,:);
end;

if DefineMacroVars,
    % Employment
    N_DEU = PWT_DEU.emp;
    % Capital
    K_DEU = PWT_DEU.rkna*PWT_DEU.rnna(PWT_DEU.year==2017);
    % Output
    Y_DEU = PWT_DEU.rgdpna;
    % Consumption
    C_DEU = PWT_DEU.rconna;
    % Labor share
    LABS_DEU = PWT_DEU.labsh;
    % Average capital share
    alpha_DEU = 1-mean(PWT_DEU.labsh);
    % Total factor productivity
    A_DEU = Y_DEU.*K_DEU.^(-alpha_DEU).*N_DEU.^(alpha_DEU-1);
    T_DEU = length(N_DEU);
end;

if PlotOverviewDEU,
    fig_counter = fig_counter + 1;
    hf = figure(fig_counter);
    subplot(2,3,1);
    plot(PWT_DEU.year, N_DEU, 'color', BfBlue, 'LineWidth', StdLineWidth);
    ylabel('Mio. Persons');
    title('Employment');
    xlim([PWT_DEU.year(1), PWT_DEU.year(end)]);
    subplot(2,3,2);
    plot(PWT_DEU.year, 100*A_DEU./A_DEU(1), 'color', BfBlue, 'LineWidth', StdLineWidth);
    ylabel('Index');
    xlim([PWT_DEU.year(1), PWT_DEU.year(end)]);
    title('Total Factor Productivity');
    subplot(2,3,3);
    plot(PWT_DEU.year, K_DEU/1000000, 'color', BfBlue, 'LineWidth', StdLineWidth);
    ylabel('Trillion USD (2017)');
    xlim([PWT_DEU.year(1), PWT_DEU.year(end)]);
    title('Capital');
    subplot(2,3,4);
    hold on;
    plot(PWT_DEU.year, ones(T_DEU)*mean(PWT_DEU.labsh)*100, 'color', BfOrange, 'LineWidth', StdLineWidth);
    plot(PWT_DEU.year, 100*LABS_DEU, 'color', BfBlue, 'LineWidth', StdLineWidth);
    hold off;
    ylabel('Percent');
    xlim([PWT_DEU.year(1), PWT_DEU.year(end)]);
    title('Labor Share');
    subplot(2,3,5);
    plot(PWT_DEU.year, Y_DEU/1000000, 'color', BfBlue, 'LineWidth', StdLineWidth);
    ylabel('Trillion USD (2017)');
    xlim([PWT_DEU.year(1), PWT_DEU.year(end)]);
    title('Output');
    subplot(2,3,6);
    plot(PWT_DEU.year, C_DEU./N_DEU/1000, 'color', BfBlue, 'LineWidth', StdLineWidth);
    ylabel('1000 USD (2017)');
    xlim([PWT_DEU.year(1), PWT_DEU.year(end)]);
    title('Consumption per Worker');

    if DoSavePlots == 1,
      saveas(1, "fig_LABS_DEU.png", "png");
    end
end

