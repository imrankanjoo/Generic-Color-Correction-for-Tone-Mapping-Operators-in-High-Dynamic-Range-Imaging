function CcImg = CCz_RGB(imgHDR, imgTMO, cond)
    % Input:
    % imgHDR - HDR image
    % imgTMO - Tone-mapped image (RGB format)
    % cond - Structure containing color correction conditions

    % Output:
    % CcImg - Color-corrected image (RGB format)
    
    % Mehmood, I., Khan, M. U., & Luo, M. R. (2024). Generic color correction for tone mapping operators in high dynamic range imaging. Optics Express, 32(16), 27849-27866.

    if (size(imgHDR) ~= size(imgTMO))
        error('The sizes are different');
    end

    %% Linearize the tone-mapped image
    imgTMO = GammaTMO(imgTMO, 1/2.2, 0, 0);
    imgTMO = real(imgTMO);

    sz = size(imgTMO);

    %% Convert images from RGB to XYZ color space
    imgTMO_XYZ = ConvertRGBtoXYZ(imgTMO, 0);
    imgHDR_XYZ = ConvertRGBtoXYZ(imgHDR, 0);

    TMO_XYZ = reshape(imgTMO_XYZ, [sz(1) * sz(2), sz(3)]);
    HDR_XYZ = reshape(imgHDR_XYZ, [sz(1) * sz(2), sz(3)]);

    %% Perform color correction in XYZ space
    TMO_c_XYZ = CCz_XYZ(TMO_XYZ, HDR_XYZ, cond);
    imgTMO_c_XYZ = reshape(TMO_c_XYZ, [sz(1), sz(2), sz(3)]);

    %% Convert corrected XYZ back to RGB
    CcImg = ConvertRGBtoXYZ(imgTMO_c_XYZ, 1);

    % Clip values to ensure they are non-negative
    CcImg(CcImg < 0) = 0;

    % Apply gamma correction to the final color-corrected image
    CcImg = GammaTMO(CcImg, 2.2, 0, 0);
end
