function [waterimage] = dwt( path1,path2 )
carry = imread(path1);
water = imread(path2);
watermark = water;
ori_pic_trans = double(carry); 
watermark_trans = double(watermark);
[Cwr,Swr] = wavedec2(watermark_trans,1,'haar');
[Cr,Sr] = wavedec2(ori_pic_trans,2,'haar');

a = 0.06;

for k = 0:1:size(Cr,2)/size(Cwr,2)-1
Cr(1+size(Cr,2)/4+k*size(Cwr,2)/4 : size(Cr,2)/4+(k+1)*size(Cwr,2)/4) = Cr(1+size(Cr,2)/4+k*size(Cwr,2)/4 : size(Cr,2)/4+(k+1)*size(Cwr,2)/4)+a*Cwr(1+size(Cwr,2)/4:size(Cwr,2)/2);
Cr(1+size(Cr,2)/2+k*size(Cwr,2)/4 : size(Cr,2)/2+(k+1)*size(Cwr,2)/4) = Cr(1+size(Cr,2)/2+k*size(Cwr,2)/4 : size(Cr,2)/2+(k+1)*size(Cwr,2)/4)+a*Cwr(1+size(Cwr,2)/2:3*size(Cwr,2)/4);
Cr(1+3*size(Cr,2)/4+k*size(Cwr,2)/4 : 3*size(Cr,2)/4+(k+1)*size(Cwr,2)/4) = Cr(1+3*size(Cr,2)/4+k*size(Cwr,2)/4 : 3*size(Cr,2)/4+(k+1)*size(Cwr,2)/4)+a*Cwr(1+3*size(Cwr,2)/4:size(Cwr,2));
end
Cr(1:size(Cwr,2)/4) = Cr(1:size(Cwr,2)/4) + a*Cwr(1:size(Cwr,2)/4);

% Image reconstruction using wavelet basis
ori_pic_trans = waverec2(Cr,Sr,'haar');
output = uint8(round(ori_pic_trans));
waterimage = output;
global pathfile3;
global pathfre;
pathfile3=fullfile(pathfre, 'waterimage_dwt.bmp');
imwrite(waterimage,pathfile3); 
end