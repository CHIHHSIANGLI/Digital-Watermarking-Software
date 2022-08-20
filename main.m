clc;
clear;
close;
global pathfile1;%Carrier picture address
global pathfile2;%Watermark image address
global pathfile3;%The carrier picture address with the watermarked picture
global pathfile4;%Extract watermark image address
global pathfile5;%The address of the watermarked carrier picture after the attack
global pathfile6;%Scrambling watermark image address
global pathfre;%Prefix of pictures' name
global k1;
k1=randn(1,8);
global k2;
k2=randn(1,8);
test();