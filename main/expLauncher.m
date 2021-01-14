%% General experimenter launcher
%  =============================
% By :      Martin SZINTE
% Projet :  natImSacContrast
% With :    Anna Montagnini, Guillaume MASSON, Jason Samonds & Nicholas Priebe
% Version:  1.0

% Version description
% ===================
% Experiment in which human participant free view natural images to 
% determine saccade and fixation statistics with low contrat images

% to do
% -----
% 1. make video
% 2. test with eyelink
% 5. test on myself/guillaume
% 3. write to Jason about design choices
% 6. make paper work for testing subjects
% 7. test subjects

% design idea
% -----------
% 10 blocks of 8 trials (?:?? min, about 1h total)
% 40 trials of 40 dva width images (large, not cropped) with 0.05 contrast
% 40 trials of 40 dva width images (large, not cropped) with 0.05 contrast
% trials of 30 seconds freeview each
% inter-trial intervals of 2 seconds each
% binocular eye recordings

% Questions
% ---------
% 1. Can we keep only the full image, not the cropped one ?
% 2. Is 40 dva width image sufficient (not 20 dva) ?
% 2. Do you think that 40 images is enough (instead of 80)?
% 3. Is the use of two contrast sufficient ? I think of 0.05 and 0.1 as Jason used ?
% 4. We preffered to play the 2 contrast in interleaved trials to avoid any specific adaptation or startegy

% First settings
% --------------
Screen('CloseAll');clear all;clear mex;clear functions;close all;home;AssertOpenGL;

% General settings
% ----------------
const.expName           =   'natImaSacCtr';     % Experiment name
const.expStart          =   1;                  % Start of a recording exp                          0 = NO  , 1 = YES
const.checkTrial        =   0;                  % Print trial conditions (for debugging)            0 = NO  , 1 = YES
const.writeLogTxt       =   0;                  % Write a log file in addition to eyelink file      0 = NO  , 1 = YES
const.mkVideo           =   0;                  % Make a video of a run                             0 = NO  , 1 = YES

% External controls
% -----------------
const.tracker           =   0;              % run with eye tracker                              0 = NO  , 1 = YES

% Run order and number per condition
% ----------------------------------
const.cond_run_order    =   [01;01;01;01;01;01;01;01;01;01];
const.cond_run_num      =   [01;02;03;04;05;06;07;08;09;10];

% Desired screen setting
% ----------------------
const.desiredFD         =   120;            % Desired refresh rate
const.desiredRes        =   [1920,1080];    % Desired resolution
% fprintf(1,'\n\n\tDon''t forget to change before testing\n');

% Path
% ----
dir                     =   (which('expLauncher'));
cd(dir(1:end-18));

% Add Matlab path
% ---------------
addpath('config','main','conversion','eyeTracking','instructions','trials','stim','stats');

% Subject configuration
% ---------------------
[const]                 =   sbjConfig(const);
                        
% Main run
% --------
main(const);
