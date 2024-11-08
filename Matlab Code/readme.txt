README.txt

Color Correction for HDR Images
================================

This project provides a MATLAB script for performing color correction on high dynamic range (HDR) images using tone-mapped images. The script utilizes the CCz_RGB function to achieve the desired color correction based on specified conditions.

Prerequisites
-------------
- MATLAB (R2017 or later recommended)
- Image Processing Toolbox

Installation
------------
1. Clone or download this repository.
2. Add the required directories to the MATLAB path:
   clearvars
   addpath('CCz utils')
   addpath('HDR')
   addpath('Tone Mapped Images')

Usage
-----
1. Set the save path for the output images:
   savePath = 'Color Corrected Images\';

2. Define the surround conditions:
   cond.XYZwt = [0.9505, 1, 1.089];
   cond.XYZwd = [0.9505, 1, 1.089];
   cond.Yb = 20;
   cond.surround = 'avg';
   cond.Lwt = 500; 
   cond.Lwd = 500; 
   cond.Lat = cond.Lwt * cond.Yb / 100;  
   cond.Lad = cond.Lwd * cond.Yb / 100; 

3. Load and preprocess the HDR and tone-mapped images:
   hdrImgName = 'Flamingo.hdr';
   hdrImg = hdrread(hdrImgName);
   hdrImg = double(hdrImg);

   tmoImgName = 'Flamingo_Meylan.jpg';
   tmoImg = imread(tmoImgName);
   tmoImg = double(tmoImg) ./ 255;

4. Perform color correction:
   imgTCz = CCz_RGB(hdrImg, tmoImg, cond);

5. Save and display the color-corrected image:
   figure, imshow([tmoImg imgTCz], 'border', 'tight');
   savestr = [savePath tmoImgName '_CCz.jpg'];
   imwrite(imgTCz, savestr);

Function Description
---------------------
CCz_RGB(imgHDR, imgTMO, cond)
- Input: 
  - imgHDR: HDR image (RGB format).
  - imgTMO: Tone-mapped image (RGB format).
  - cond: Structure with color correction conditions.
  
- Output: 
  - CcImg: Color-corrected image (RGB format).

Citation
--------
Mehmood, I., Khan, M. U., & Luo, M. R. (2024). Generic color correction for tone mapping operators in high dynamic range imaging. Optics Express, 32(16), 27849-27866.

For questions or issues, please contact the project author.
