clearvars
addpath('CCz utils')
addpath('HDR')
addpath(('Tone Mapped Images'))
savePath='Color Corrected Images\';
%% Sorround Conditions
cond.XYZwt=[0.9505            1        1.089];
cond.XYZwd=[0.9505            1        1.089];

cond.Yb=20;
cond.surround='avg';

cond.Lwt=500; cond.Lwd=500;
cond.Lat=cond.Lwt*cond.Yb/100;  cond.Lad=cond.Lwd*cond.Yb/100; 
%% Load HDR image and pre-process

hdrImgName='Flamingo.hdr';
hdrImg=hdrread(hdrImgName);
hdrImg=double(hdrImg);

tmoImgName='Flamingo_Meylan.jpg';
tmoImg=imread(tmoImgName);
tmoImg=double(tmoImg)./255;



%% Colour correction
imgTCz=CCz_RGB(hdrImg, tmoImg, cond);



%% save sRGB images
figure,imshow([tmoImg imgTCz] ,'border','tight')
savestr=[savePath  tmoImgName '_CCz.jpg'];
imwrite(imgTCzG,savestr)





