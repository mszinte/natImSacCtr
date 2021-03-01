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
% 10 first run => large image
% 10 last run => small images (code was adapted after running participant
% first 10 runs to add small size images)

% to do
% -----
% 1. test with eyelink + test convert_results
% 1. test subjects (Emma, Kevin, Jeremy, Guillaume, Marine, Theophyle)

% design idea
% -----------
% 10 first block:
% 10 blocks of 8 trials (4:14 min, less than 1h in total)
% 40 trials of 40 dva width images (large, not cropped) with 0.05 contrast
% 40 trials of 40 dva width images (large, not cropped) with 0.05 contrast
% 5% and 10% images are different and randomly picked between participants

% 10 last block: 
% 10 blocks of 8 trials (4:14 min, less than 1h in total)
% 40 trials of 20 dva width images (large, not cropped) with 0.05 contrast
% 40 trials of 20 dva width images (large, not cropped) with 0.05 contrast
% 5 and 10% images are the images seen at 10 and 5% contrast within the  first 10 blocks

% trials of 30 seconds freeview each
% inter-trial intervals of 2 seconds each
% binocular eye recordings

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
const.cond_run_order    =   [01;01;01;01;01;01;01;01;01;01;...
                             01;01;01;01;01;01;01;01;01;01];
const.cond_run_num      =   [01;02;03;04;05;06;07;08;09;10;...
                             11;12;13;14;15;16;17;18;19;20];

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
