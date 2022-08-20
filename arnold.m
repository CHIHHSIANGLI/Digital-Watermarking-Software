function outimg=arnold(inimg,key) %arnold 为置乱函数,inimg 为输入图像,key 为密钥
[h,w]=size(inimg);
outimg=uint8(zeros(h,w));
tempimg=inimg; %定义中间变量
%判断密钥的合法性
if h~=w; 
 error('The cover must be a square!');
return;
elseif size(key,2)~=5;
 error('The key must be 5 numbers!');
 return;
elseif abs(key(2)*key(5)-key(3)*key(4))~=1;
 error('The Arnold Matrix is not valid!');
end;
for i=1:key(1) %执行置乱次数
 for u=1:h %将像素坐标置乱
 for v=1:w
 temp=tempimg(u,v); %获取坐标（u，v）处的像素值
 ax=mod((key(2)*(u-1)+key(3)*(v-1)),w)+1;
 ay=mod((key(4)*(u-1)+key(5)*(v-1)),w)+1;
 outimg(ax,ay)=temp; %在新的坐标中赋上原来的像素值
 end
 end
 tempimg=outimg;
end
outimg=tempimg; %输出图像
function outimg=iarnold(inimg,key)
ik=round(inv([key(2),key(3);key(4),key(5)])); %arnold 逆矩阵取整
ikey(2)=ik(1,1);
ikey(3)=ik(1,2);
ikey(4)=ik(2,1);
ikey(5)=ik(2,2);
[h,w]=size(inimg);
outimg=uint8(zeros(h,w));
tempimg=inimg;
if h~=w; 
 error('The cover must be a square!');
 return;
elseif size(key,2)~=5;
 error('The key must be 5 numbers!');
 return;
elseif (key(2)*key(5)-key(3)*key(4))~=1;
 error('The Arnold Matrix is not valid!');
end;
for i=1:key(1) %执行置乱次数
 for u=1:h %将像素坐标置乱
 for v=1:w
 temp=tempimg(u,v); %获取坐标（u，v）处的像素值
 ax=mod((ikey(2)*(u-1)+ikey(3)*(v-1)),w)+1;
 ay=mod((ikey(4)*(u-1)+ikey(5)*(v-1)),w)+1;
outimg(ax,ay)=temp; %在新的坐标中赋上原来的像素值
 end
 end
 tempimg=outimg;
end
outimg=tempimg; %输出图像