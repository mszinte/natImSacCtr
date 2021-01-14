% ----------------------------------------------------------------------
% lower_contrast(const,my_key)
% ----------------------------------------------------------------------
% Goal of the function :
% Create lower contrast jpg images from large pictures
% ----------------------------------------------------------------------
% Input(s) :
% none
% ----------------------------------------------------------------------
% Output(s):
% /img/*_c1.jpg and /img/*_c2.jpg
% ----------------------------------------------------------------------
% Function created by Martin SZINTE (martin.szinte@gmail.com)
% Last update : 14 / 01 / 2021
% Project :     natImSacCtr
% Version :     1.0
% ----------------------------------------------------------------------

imdir = '~/Dropbox/Data/Martin/Experiments/natImSacCtr/stim/im';
images = dir(fullfile(imdir, '*_large.jpg'));

c1_val= .05;
for im_num = 1:size(images,1)
    fnamein = sprintf('%s/%s',imdir,images(im_num).name);
    I = imread(fnamein);
    Ilc = (I-127)*c1_val+127;
    fnameout = sprintf('%s/%s_c1.jpg',imdir,images(im_num).name(1:end-10));
    imwrite(Ilc,fnameout);
end

c2_val= .1;
for im_num = 1:size(images,1)
    fnamein = sprintf('%s/%s',imdir,images(im_num).name);
    I = imread(fnamein);
    Ilc = (I-127)*c2_val+127;
    fnameout = sprintf('%s/%s_c2.jpg',imdir,images(im_num).name(1:end-10));
    imwrite(Ilc,fnameout);
end