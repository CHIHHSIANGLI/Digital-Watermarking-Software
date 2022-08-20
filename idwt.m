function [ water ] = idwt( path1,path2,path3 )

carry = imread(path1);
water = imread(path2);
watermark = water;
ori_pic_trans = double(carry); 
watermark_trans = double(watermark);
[Cwr,Swr] = wavedec2(watermark_trans,1,'haar');
[Cr,Sr] = wavedec2(ori_pic_trans,2,'haar');
a = 0.06;

ori_pic_trans = imread(path3);
% Watermark extraction
[Ca,Sa] = wavedec2(ori_pic_trans,2,'haar');
% ori_pic0 = imread('ori_pic.jpg','jpg');
ori_pic = carry;
ori_pic01 = double(ori_pic(:,:,1));
[Ca1,Sa1] = wavedec2(ori_pic01,2,'haar');
Cwr(1:size(Cwr,2)/4) = (Ca(1:size(Cwr,2)/4) - Ca1(1:size(Cwr,2)/4))/a;
watermark_trans = waverec2(Cwr,Swr,'haar');
output = uint8(round(watermark_trans));
water = output;
global pathfile4;
global pathfre;
pathfile4=fullfile(pathfre, 'randmark_dwt.bmp');
imwrite(water,pathfile4)
end
