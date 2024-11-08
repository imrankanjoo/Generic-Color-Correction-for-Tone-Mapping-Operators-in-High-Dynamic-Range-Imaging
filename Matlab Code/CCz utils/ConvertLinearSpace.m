function imgOut = ConvertLinearSpace(img, mtx)
%
%       imgOut = ConvertLinearSpace(img, mtx)
%
%
%        Input:
%           -img: image to convert into a new color space
%           -mtx: a 3x3 matrix that defines a linear color transformation
%
%        Output:
%           -imgOut: converted image


%Is it a three color channels image?
check3Color(img);

%Is it a 3x3 matrix?
[r, c]=size(mtx);
if(r ~= 3 || c ~= 3)
    error('The matrix for color transformation is not 3x3.');
end

imgOut = zeros(size(img));
for i=1:3
    imgOut(:,:,i) = img(:,:,1) * mtx(i,1) + img(:,:,2) * mtx(i,2) + img(:,:,3) * mtx(i,3);
end

end