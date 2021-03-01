function drawTrialInfoEL(scr,const,expDes,t)
% ----------------------------------------------------------------------
% drawTrialInfoEL(scr,const,expDes,t)
% ----------------------------------------------------------------------
% Goal of the function :
% Draw on the eyelink display the experiment configuration
% ----------------------------------------------------------------------
% Input(s) :
% scr : struct containing screen configurations
% const : struct containing constant configurations
% expDes : struct containg experimental design
% t : trial number
% ----------------------------------------------------------------------
% Output(s):
% none
% ----------------------------------------------------------------------
% Function created by Martin SZINTE (martin.szinte@gmail.com)
% Last update : 22 / 02 / 2021
% Project :     natImSac
% Version :     1.0
% ----------------------------------------------------------------------
% o--------------------------------------------------------------------o
% | EL Color index                                                     |
% o----o----------------------------o----------------------------------o
% | Nb |  Other(cross,box,line)     | Clear screen                     |
% o----o----------------------------o----------------------------------o
% |  0 | black                      | black                            |
% o----o----------------------------o----------------------------------o
% |  1 | dark blue                  | dark dark blue                   |
% o----o----------------------------o----------------------------------o
% |  2 | dark green                 | dark blue                        |
% o----o----------------------------o----------------------------------o
% |  3 | dark turquoise             | blue                             |
% o----o----------------------------o----------------------------------o
% |  4 | dark red                   | light blue                       |
% o----o----------------------------o----------------------------------o
% |  5 | dark purple                | light light blue                 |
% o----o----------------------------o----------------------------------o
% |  6 | dark yellow (brown)        | turquoise                        |
% o----o----------------------------o----------------------------------o
% |  7 | light gray                 | light turquoise                  | 
% o----o----------------------------o----------------------------------o
% |  8 | dark gray                  | flashy blue                      |
% o----o----------------------------o----------------------------------o
% |  9 | light purple               | green                            |
% o----o----------------------------o----------------------------------o
% | 10 | light green                | dark dark green                  |
% o----o----------------------------o----------------------------------o
% | 11 | light turquoise            | dark green                       |
% o----o----------------------------o----------------------------------o
% | 12 | light red (orange)         | green                            |
% o----o----------------------------o----------------------------------o
% | 13 | pink                       | light green                      |
% o----o----------------------------o----------------------------------o
% | 14 | light yellow               | light green                      |
% o----o----------------------------o----------------------------------o
% | 15 | white                      | flashy green                     |
% o----o----------------------------o----------------------------------o

% Color config
ftCol                   =   15;
bgCol                   =   0;

% Clear screen
eyeLinkClearScreen(bgCol);

% draw box of stimuli
var1 = expDes.blockMat(t,3);
if var1 == 1
    frameCol                =   7;
elseif var1 == 2
    frameCol                =   8;
end
eyeLinkDrawBox(scr.x_mid,scr.y_mid,const.large_img_width,const.large_img_height,2,frameCol,ftCol);
WaitSecs(0.1);

end