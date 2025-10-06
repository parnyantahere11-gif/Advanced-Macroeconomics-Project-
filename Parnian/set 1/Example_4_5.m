% ===============================================
% Octxmpl 4.5:
% General Equilibrium in the One-Period Model
% This version: 06.11.2024
% Author: Oliver Holtemoeller
% Tested: MATLAB R2024a
% ===============================================

clear all;
close all;

% Check for Matlab/Octave
% -----------------------
MyEnv.Octave = exist('OCTAVE_VERSION', 'builtin') ~= 0;
MyEnv.Matlab = ~MyEnv.Octave;

disp('==========================================');
disp('General Equilibrium in the One-Priod-Model');
if MyEnv.Octave
    disp(['Start: ', strftime("%Y-%m-%d %H:%M", localtime(time()))]);
else
    disp(datetime('now','TimeZone','local','Format','yyyy-MM-dd HH:mm'));
end
disp('');

% Parameters
params.alpha = 0.4;               % output elasticity of capital

% Exogenous variables
exog.A = 1;                       % total factor productivity
exog.k = 1;                       % capital endowment
exog.n = 1;                       % labor endowment

% Compute equilibrium given exogenous variables and parameters
endog = oneperiodequilibrium(exog, params);

Laborshare = endog.w*exog.n/endog.y;

% Display endogenous equilibrium values
disp(endog);
disp('');
disp('Labor share:');
disp(['    ', num2str(Laborshare)]);

disp('');
if MyEnv.Octave
    disp(['End: ', strftime("%Y-%m-%d %H:%M", localtime(time()))]);
else
    disp(datetime('now','TimeZone','local','Format','yyyy-MM-dd HH:mm'));
end
disp('==========================================');
