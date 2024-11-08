function [C, h ]=NewCH(J,  XYZ,XYZw,La,Yb,Surround)


if nargin>2
else La=2000/(5*pi);
end % luminance of adapted white point
if nargin>3;
else Yb=20;end % luminance of background (typically 20)
if nargin>4;
   if strcmp(Surround,'avg'); c=0.69;  Nc=1;    F=1;   end % average surround
   if strcmp(Surround,'dim'); c=0.59;  Nc=0.9;  F=0.9; end % dim surround
   if strcmp(Surround,'dark');c=0.525; Nc=0.8;  F=0.8; end % dark surround
   if strcmp(Surround,'T1');  c=0.46;  Nc=0.9;  F=0.9; end % ISO 3664 T1 surround
else                          c=0.69;  Nc=1;    F=1; % ISO 3664 P1, average surround
end

% step 0
M_CAT16 =     [0.401288 0.650173 -0.051461; -0.250268 1.204414 0.045854; -0.002079 0.048952 0.953127];
RGBw = M_CAT16*XYZw';

D_pre =  F * (1- (1/3.6)*exp((-La-42)/92)); % D is degree of adoptation; If D is greater than one or less than zero,set it to one or zero accordingly.
if D_pre<0
    D = 0;
elseif D_pre>1
    D = 1;
else
    D = D_pre;
end

Dr = D*(XYZw(2)/RGBw(1)) + 1 - D;
Dg = D*(XYZw(2)/RGBw(2)) + 1 - D;
Db = D*(XYZw(2)/RGBw(3)) + 1 - D;

k = 1/(5*La+1);
Fl = 0.2*(k^4)*(5*La) + 0.1*((1-k^4)^2)*((5*La)^(1/3));
n = Yb/XYZw(2);
% z = 1.48+sqrt(n);
Nbb = 0.725*(1/n)^0.2;
Ncb = Nbb;

% 

% step 1; Calculate cone responses
RGB = M_CAT16*XYZ';

% step 2; Complete the color adaptation
RGBc(1,:) = Dr*RGB(1,:);
RGBc(2,:) = Dg*RGB(2,:);
RGBc(3,:) = Db*RGB(3,:);
indxg=RGBc>= 0;
indxl=~indxg;
div100=0.01;

RGBa(indxg)=( 400*( Fl*RGBc(indxg)*div100).^0.42)./(27.13+( Fl*RGBc(indxg)*div100).^0.42)+0.1;
RGBa(indxl) = (-400*(-Fl*RGBc(indxl)*div100).^0.42)./(27.13+(-Fl*RGBc(indxl)*div100).^0.42)+0.1;
RGBa=reshape(RGBa,size(RGBc));

% step 4; Calculate hue angle (h)
a = RGBa(1,:) - 12*RGBa(2,:)/11 + RGBa(3,:)/11;
b = (RGBa(1,:) + RGBa(2,:) - 2*RGBa(3,:))/9;

[h] = cart2pol(a, b);
h = h*180/pi;
h=h+360*(h<0);

 % step 5; Calculate eccentricity

et = (cos(2+h*pi/180)+3.8)/4;

    
% step 9; Calculate  chroma (C)

t = ((Nc*Ncb*50000/13)*(et.*(a.^2+b.^2).^0.5)) ./ (RGBa(1,:)+ RGBa(2,:)+21*RGBa(3,:)/20);
C = 1.0*(t.^0.9).*((J./100).^0.5).*(1.64-0.29^n)^0.73;

C=real(C);





