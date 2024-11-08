function imgOut = ConvertRGBtoXYZ(img, inverse)
%
%       imgOut = ConvertRGBtoXYZ(img, inverse)
%
%       This function assumes REC.709 primaries for the RGB color space
%
%        Input:
%           -img: image to convert from RGB to XYZ or from XYZ to RGB.
%           -inverse: takes as values 0 or 1. If it is set to 0 the
%                     transformation from linear RGB to XYZ is applied,
%                     otherwise the transformation from XYZ to linear RGB
%                     is applied.
%
%        Output:
%           -imgOut: converted image in XYZ or RGB.
%


%ITU-R BT.709 matrix conversion from RGB to XYZ
mtxRGBtoXYZ = [ 0.4124, 0.3576, 0.1805;...
                0.2126, 0.7152, 0.0722;...
                0.0193, 0.1192, 0.9505];
% mtxRGBtoXYZ = [0.412424    0.212656    0.0193324;  
%      0.357579    0.715158    0.119193;   
%      0.180464    0.0721856   0.950444];

if(inverse == 0)
    imgOut = ConvertLinearSpace(img, mtxRGBtoXYZ);
end

if(inverse == 1)
    imgOut = ConvertLinearSpace(img, inv(mtxRGBtoXYZ));
end
            
end
