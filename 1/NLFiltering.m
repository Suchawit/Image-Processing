function Iout = NLFiltering (OrgImgAdd,n)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
fun = @(x) median(x(:));
OrgImgAdd = im2double(OrgImgAdd);
Iout = nlfilter(OrgImgAdd,[n n],fun);
plot([Iout(:,1,1) OrgImgAdd(:,1:1)])
legend('Filter Signal','Signal with Noisy')

end

