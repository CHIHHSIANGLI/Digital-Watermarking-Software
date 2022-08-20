function [ after_attack ] = attack(choice ,pathfile3)

watermark = imread(pathfile3);
switch choice
% Direct extraction
case 1
after_attack = watermark;

% Noise attack
case 2
result=watermark;
noise=10*randn(size(result));
result=double(result)+noise;
after_attack=uint8(result);

% Shear attack
case 3
result=watermark;
A=result(:,:,1);
B=result(:,:,2);
C=result(:,:,3);
A(1:64,1:64)=512;
B(1:64,1:64)=512;
C(1:64,1:64)=512; 
after_attack=cat(3,A,B,C);

% Compression attack
case 4
[cA1,cH1,cV1,cD1]=dwt2(watermark,'Haar');
cA1=HYASUO(cA1);
cH1=HYASUO(cH1);
cV1=HYASUO(cV1);
cD1=HYASUO(cD1);
result=idwt2(cA1,cH1,cV1,cD1,'Haar');
after_attack=uint8(result);

% Rotate attack
case 5
result=watermark;
after_attack=imrotate(result,10,'bilinear','crop');

case 6
result=watermark;
result = double(result);
h=[-1 -1 -1;-1 9 -1;-1 -1 -1];
after_attack=uint8(imfilter(result,h,'same'));

case 7
result=watermark;
result = double(result);
h = fspecial('gaussian',[5,5],1); 
after_attack=uint8(imfilter(result,h,'same'));

end

end

