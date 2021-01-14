function [expDes] = runTrials(scr,const,expDes,my_key)
% ----------------------------------------------------------------------
% [expDes]=runTrials(scr,const,expDes,my_key)
% ----------------------------------------------------------------------
% Goal of the function :
% Draw stimuli of each indivual trial and waiting for inputs
% ----------------------------------------------------------------------
% Input(s) :
% scr : struct containing screen configurations
% const : struct containing constant configurations
% expDes : struct containg experimental design
% my_key : structure containing keyboard configurations
% ----------------------------------------------------------------------
% Output(s):
% resMat : experimental results (see below)
% expDes : struct containing all the variable design configurations.
% ----------------------------------------------------------------------
% Function created by Martin SZINTE (martin.szinte@gmail.com)
% Last update : 13 / 01 / 2021
% Project :     natImSacCtr
% Version :     1.0
% ----------------------------------------------------------------------


% Block loop
% ----------
for t = 1:const.trial_per_block
    
    % Write in log/edf
    log_txt                     =   sprintf('trial %i started at %f\n',t,GetSecs);
    if const.writeLogTxt
        fprintf(const.log_file_fid,log_txt);
    end
    if const.tracker
        Eyelink('message','%s',log_txt);
    end
    
    % Compute and simplify var and rand
    % ---------------------------------
    
    % Var 1 : image contrast
    var1 = expDes.blockMat(t,3);
    if var1 == 1
        im_contrast_txt = 'c1';
    elseif var1 == 2
        im_contrast_txt = 'c2';
    end
    
    % Var 2 : image number
    var2 = expDes.blockMat(t,4);
    
    % Load image
    dirImage                =   sprintf('stim/im/im%i_%s.jpg',var2,im_contrast_txt);
    [imageToDraw]           =   imread(dirImage);
    t_handle                =   Screen('MakeTexture',scr.main,imageToDraw);
    texrect                 =   Screen('Rect', t_handle);
    
    
    if const.checkTrial && const.expStart == 0
        fprintf(1,'\n\n\t========================  TRIAL %3.0f ========================\n',t);
        fprintf(1,'\n\tImage contrast               =\t%s',expDes.txt_var1{var1});
        fprintf(1,'\n\tImage number                 =\t%s',expDes.txt_var2{var2});
    end
    
    % Trial loop
    % ----------
    
    % Write on eyelink screen
    if const.tracker
        drawTrialInfoEL(scr,const,expDes,t);
    end
    
    if t == const.trial_per_block
        trial_num = const.freeview_num;
    else
        trial_num = const.freeview_num + const.iti_num;
    end
    
    nbf = 0;
    missed_all = [];
    while nbf <= trial_num
        
        % flip count
        nbf = nbf + 1;
        
        % Draw background
        Screen('FillRect',scr.main,const.background_color);
        
        % Draw image
        if nbf > 0 && nbf <= const.freeview_num
            Screen('DrawTexture',scr.main,t_handle,texrect,const.large_rect);
        end
        
        % Screen flip
        [~,~,~,missed]    =   Screen('Flip',scr.main);
        
        if sign(missed) == 1
            missed_val              =   1;
            missed_all              =   [missed_all;missed,missed_val];
        else
            missed_val              =   0;
            missed_all              =   [missed_all;missed,missed_val];
        end
        
        % Create movie
        % ------------
        if const.mkVideo
            open(const.vid_obj);
            expDes.vid_num          =   expDes.vid_num + 1;
            image_vid               =   Screen('GetImage', scr.main);
            imwrite(image_vid,sprintf('%s_frame_%i.png',const.movie_image_file,expDes.vid_num));
            writeVideo(const.vid_obj,image_vid);
        end
        
        % Save trials times
        if nbf == 1
            % trial onset
            log_txt                 =   sprintf('stim %i onset at %f',t,GetSecs);
            if const.writeLogTxt
                fprintf(const.log_file_fid,'%s\n',log_txt);
            end
            if const.tracker
                Eyelink('message','%s',log_txt);
            end
            expDes.blockMat(t,5) = GetSecs;
        end
        
        if nbf == const.freeview_num+1
            % inter trial interval onset
            log_txt                 =   sprintf('stim %i offset at %f',t,GetSecs);
            if const.writeLogTxt
                fprintf(const.log_file_fid,'%s\n',log_txt);
            end
            if const.tracker
                Eyelink('message','%s',log_txt);
            end
        end
        
        if nbf == const.freeview_num + 1
            % inter trial interval onset
            log_txt                 =   sprintf('iti %i onset at %f',t,GetSecs);
            if const.writeLogTxt
                fprintf(const.log_file_fid,'%s\n',log_txt);
            end
            if const.tracker
                Eyelink('message','%s',log_txt);
            end
        end
        
        % Check keyboard
        % --------------
        keyPressed              =   0;
        keyCode                 =   zeros(1,my_key.keyCodeNum);
        for keyb = 1:size(my_key.keyboard_idx,2)
            [keyP, keyC]            =   KbQueueCheck(my_key.keyboard_idx(keyb));
            keyPressed              =   keyPressed+keyP;
            keyCode                 =   keyCode+keyC;
        end
        
        if keyPressed
            if keyCode(my_key.escape)
                if const.expStart == 0
                    overDone(const,my_key)
                end
            end
        end
    end
    
    % Get number of stim and probe played
    %  -----------------------------------
    % write in log/edf
    log_txt                 =   sprintf('trial %i - %i missed sync on %i frames, %1.1f%% (mean/median delay = %1.1f/%1.1f ms)',...
        t,sum(missed_all(:,2)>0),size(missed_all,1),sum(missed_all(:,2)>0)/size(missed_all,1)*100,...
        mean(missed_all(missed_all(:,2)==1))*1000,median(missed_all(missed_all(:,2)==1))*1000);
    if const.writeLogTxt
        fprintf(const.log_file_fid,'%s\n',log_txt);
    end
    if const.tracker
        Eyelink('message','%s',log_txt);
    end
    
    % write in log/edf
    log_txt                     =   sprintf('trial %i stopped at %f',t,GetSecs);
    if const.writeLogTxt
        fprintf(const.log_file_fid,'%s\n',log_txt);
    end
    if const.tracker
        Eyelink('message', '%s',log_txt);
    end
    expDes.blockMat(t,6)  =   GetSecs;  
    
end

end