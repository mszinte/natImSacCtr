function [const]=constConfig(scr,const)
% ----------------------------------------------------------------------
% [const]=constConfig(scr,const)
% ----------------------------------------------------------------------
% Goal of the function :
% Define all constant configurations
% ----------------------------------------------------------------------
% Input(s) :
% scr : struct containing screen configurations
% const : struct containing constant configurations
% ----------------------------------------------------------------------
% Output(s):
% const : struct containing constant configurations
% ----------------------------------------------------------------------
% Function created by Martin SZINTE (martin.szinte@gmail.com)
% Last update : 13 / 01 / 2021
% Project :     natImSacCtr
% Version :     1.0
% ----------------------------------------------------------------------

% Randomization
rng('default');
rng('shuffle');

%% Colors
const.white              =   [255,255,255];                                                      % white color
const.black              =   [0,0,0];                                                            % black color
const.gray               =   [128,128,128];                                                      % gray color
const.dark_gray          =   [100,100,100];                                                      % dark gray color
const.background_color   =   const.gray;                                                         % background color

%% Fixation parameters for calibration
const.fix_out_rim_radVal    =   0.4;                                                                % radius of outer circle of fixation bull's eye
const.fix_rim_radVal        =   0.75*const.fix_out_rim_radVal;                                      % radius of intermediate circle of fixation bull's eye in degree
const.fix_radVal            =   0.25*const.fix_out_rim_radVal;                                      % radius of inner circle of fixation bull's eye in degrees
const.fix_out_rim_rad       =   vaDeg2pix(const.fix_out_rim_radVal,scr);                            % radius of outer circle of fixation bull's eye in pixels
const.fix_rim_rad           =   vaDeg2pix(const.fix_rim_radVal,scr);                                % radius of intermediate circle of fixation bull's eye in pixels
const.fix_rad               =   vaDeg2pix(const.fix_radVal,scr);                                    % radius of inner circle of fixation bull's eye in pixels

%% Time parameters
const.freeview_dur          =   30.0;                                                               % free viewing duration in seconds
const.freeview_num          =   (round(const.freeview_dur/scr.frame_duration));                     % free viewing duration in screen frames
const.iti_dur               =   2;                                                                % inter trial interval in seconds
const.iti_num               =   (round(const.iti_dur/scr.frame_duration));                          % inter trial interval in screen frames

%% Space parameter
const.large_img_widthVal    =   40.0;                                                               % large image width in dva
const.large_img_width       =   vaDeg2pix(const.large_img_widthVal,scr);                            % large image width in pixels
% const.small_img_widthVal    =   20.0;                                                               % small image width in dva
% const.small_img_width       =   vaDeg2pix(const.small_img_widthVal,scr);                            % small image width in pixels
% 
const.large_img_heightVal   =   30.0;                                                               % large image height in dva
const.large_img_height      =   vaDeg2pix(const.large_img_heightVal,scr);                           % large image height in pixels
% const.small_img_heightVal   =   15.0;                                                               % small image height in dva
% const.small_img_height      =   vaDeg2pix(const.small_img_heightVal,scr);                           % small image height in pixels

const.large_rect            =   [   scr.x_mid - const.large_img_width/2,...
                                    scr.y_mid - const.large_img_height/2,...
                                    scr.x_mid + const.large_img_width/2,...
                                    scr.y_mid + const.large_img_height/2    ];

% const.small_rect            =   [   scr.x_mid - const.small_img_width/2,...
%                                     scr.y_mid - const.small_img_height/2,...
%                                     scr.x_mid + const.small_img_width/2,...
%                                     scr.y_mid + const.small_img_height/2    ];


%% Contast parameters
const.contrast_val1         =   0.05;                                                               % contast value 1
const.contrast_val2         =   0.1;                                                                % contast value 2

%% block/trial parameter
const.img_tot_num           =   40;                                                                 % total number of natural images
const.img_contrast_num      =   2;                                                                  % total number of image contrast
const.trials_tot_num        =   (const.img_tot_num * const.img_contrast_num);                       % total number of trials
const.block_num             =   10;                                                                 % number of blocks
const.trial_per_block       =   const.trials_tot_num/const.block_num;
const.trial_num             =   const.trial_per_block * const.freeview_num + ...
                                (const.trial_per_block-1) * const.iti_num;                          % number of frames per trial

%% Eyelink calibration value
% Personal calibrations
rng('default');rng('shuffle');
angle = 0:pi/3:5/3*pi;
 
% compute calibration target locations
const.calib_amp_ratio  = 0.5;
[cx1,cy1] = pol2cart(angle,const.calib_amp_ratio);
[cx2,cy2] = pol2cart(angle+(pi/6),const.calib_amp_ratio*0.5);
cx = round(scr.x_mid + scr.x_mid*[0 cx1 cx2]);
cy = round(scr.y_mid + scr.x_mid*[0 cy1 cy2]);

% order for eyelink
const.calibCoord = round([  cx(1), cy(1),...   % 1.  center center
                            cx(9), cy(9),...   % 2.  center up
                            cx(13),cy(13),...  % 3.  center down
                            cx(5), cy(5),...   % 4.  left center
                            cx(2), cy(2),...   % 5.  right center
                            cx(4), cy(4),...   % 6.  left up
                            cx(3), cy(3),...   % 7.  right up
                            cx(6), cy(6),...   % 8.  left down
                            cx(7), cy(7),...   % 9.  right down
                            cx(10),cy(10),...  % 10. left up
                            cx(8), cy(8),...   % 11. right up
                            cx(11),cy(11),...  % 12. left down
                            cx(12),cy(12)]);    % 13. right down
      
% compute validation target locations (calibration targets smaller radius)
const.valid_amp_ratio = const.calib_amp_ratio*0.8;
[vx1,vy1] = pol2cart(angle,const.valid_amp_ratio);
[vx2,vy2] = pol2cart(angle+pi/6,const.valid_amp_ratio*0.5);
vx = round(scr.x_mid + scr.x_mid*[0 vx1 vx2]);
vy = round(scr.y_mid + scr.x_mid*[0 vy1 vy2]);
 
% order for eyelink
const.validCoord =round( [  vx(1), vy(1),...   % 1.  center center
                             vx(9), vy(9),...   % 2.  center up
                             vx(13),vy(13),...  % 3.  center down
                             vx(5), vy(5),...   % 4.  left center
                             vx(2), vy(2),...   % 5.  right center
                             vx(4), vy(4),...   % 6.  left up
                             vx(3), vy(3),...   % 7.  right up
                             vx(6), vy(6),...   % 8.  left down
                             vx(7), vy(7),...   % 9.  right down
                             vx(10),vy(10),...  % 10. left up
                             vx(8), vy(8),...   % 11. right up
                             vx(11),vy(11),...  % 12. left down
                             vx(12),vy(12)]);    % 13. right down

const.ppd               =   vaDeg2pix(1,scr);                                                  % get one pixel per degree

end