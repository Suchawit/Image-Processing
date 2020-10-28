function [Iout,MSE_pre,MSE_post]= GaussianFiltering(OrgImgAdd,NoisyImgAdd,n,sigma)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
original = im2double(OrgImgAdd);
NsI = im2double(NoisyImgAdd);

MSE_pre = immse(original,NsI);
filter = fspecial('gaussian',[n n],sigma);
s = size(NsI);
filImg = zeros(s);
for i = 2:s(1)-1
    for j = 2:s(2)-1
        temp = NsI(i-1:i+1,j-1:j+1).*filter;
        filImg(i,j) = sum(temp(:));
    end
end
MSE_post = immse(original,filImg);
Iout = filImg;
plot([filImg(:,1,1) NsI(:,1:1)])
legend('filter Signal','Signal with Noisy')
end

