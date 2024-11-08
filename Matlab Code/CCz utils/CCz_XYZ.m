function xyzo=CCz_XYZ (XYZtmo, XYZhdr,cond)
% Mehmood, I., Khan, M. U., & Luo, M. R. (2024). Generic color correction for tone mapping operators in high dynamic range imaging. Optics Express, 32(16), 27849-27866.

[XYZwt,XYZwd,Lat,Lad,Yb,surround]= getvars(cond);
 
[Jt] = TMLightness(XYZtmo,XYZwt,Lat,Yb,surround); 

[Co, h]=NewCH(Jt,  XYZhdr,XYZwd,Lad,Yb,surround);

JCh=[Jt.' Co.'  h.' ];

xyzo = CAM16UCS2XYZ(JCh,XYZwd,Lad,Yb,surround);


end
function [XYZwt,XYZwd,Lat,Lad,Yb,surround]= getvars(cond)

XYZwt=cond.XYZwt;
XYZwd=cond.XYZwd;
Yb=cond.Yb;
surround=cond.surround;

Lat=cond.Lat;  
Lad=cond.Lad;
end