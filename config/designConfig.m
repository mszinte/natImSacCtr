function [expDes]=designConfig(const)
% ----------------------------------------------------------------------
% [expDes]=designConfig(const)
% ----------------------------------------------------------------------
% Goal of the function :
% Define experimental design
% ----------------------------------------------------------------------
% Input(s) :
% const : struct containing constant configurations
% ----------------------------------------------------------------------
% Output(s):
% expDes : struct containg experimental design
% ----------------------------------------------------------------------
% Function created by Martin SZINTE (martin.szinte@gmail.com)
% Last update : 13 / 01 / 2021
% Project :     natImSacCtr
% Version :     1.0
% ----------------------------------------------------------------------

%% Experimental random variables
% Var 1 : image contrast (40 modalities)
% ======
expDes.oneV             =   [1:2]';
expDes.nb_var1          =   2;
expDes.txt_var1         =   {'c0.05','c0.10'};

% Var 2 : image number (40 modalities)
% ======
expDes.twoV             =   [1:40]';
expDes.nb_var2          =   40;
expDes.txt_var2         =   {'img_01','img_02','img_03','img_04','img_05','img_06','img_07','img_08','img_09','img_10',...
                             'img_11','img_12','img_13','img_14','img_15','img_16','img_17','img_18','img_19','img_20',...
                             'img_21','img_22','img_23','img_24','img_25','img_26','img_27','img_28','img_29','img_30',...
                             'img_31','img_32','img_33','img_34','img_35','img_36','img_37','img_38','img_39','img_40'};
% 01 = image 01
% 02 = image 02
% ...
% 40 = image 40

%% Experimental configuration :
expDes.nb_var           =   2;
expDes.nb_trials        =   expDes.nb_var1 * expDes.nb_var2;

if const.runNum == 1
    %% Experimental loop
    rng('default');rng('shuffle');
    rand('state',sum(100*clock));
    
    trialMat = zeros(expDes.nb_trials,expDes.nb_var);
    ii = 0;
    for var1 = 1:expDes.nb_var1
        for var2 = 1:expDes.nb_var2
            ii = ii + 1;
            trialMat(ii, 1) = var1;
            trialMat(ii, 2) = var2;
        end
    end
    
    trialMat = trialMat(randperm(expDes.nb_trials)',:);
    runT = 1;
    for t_trial = 1:expDes.nb_trials
        
        rand_var1   = expDes.oneV(trialMat(t_trial,1),:);
        rand_var2   = expDes.twoV(trialMat(t_trial,2),:);
        
        % Processing experimental matrix
        expMat(t_trial,:)= [ runT, t_trial, rand_var1, rand_var2, NaN, NaN];
        
        % col 01:   Run number
        % col 02:   Trial number
        % col 03:   image contrast
        % col 04:   image number
        % col 05:   trial onset time
        % col 06:   trial offset time
        if ~mod(t_trial,const.trial_per_block)
            runT = runT + 1;
        end
    end
    save(const.expMat_file,'expMat');
    
else
    % load design
    load(const.expMat_file);

end

% Experimental matrix for the block
expDes.blockMat = expMat(expMat(:,1)==const.runNum,:);

end