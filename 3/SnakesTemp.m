clear all
clc

% Minimization Parameters
alpha=0.2;
beta= 0.2;
gamma=0.1000;
max_itr      = 100;
GaussWinSize = 5;
GradT        = 0.3;

% Loading the image and converting that to a grey-level image if needed
img = imread("CTImage.png");

% Denoising by Gaussian filter
I = imgaussfilt(img);

% Edge Detection using Sobel kernels
BW1 = edge(I,'sobel');
% Seed points selection
figure, imshow(BW1); [y,x] = getpts;
P=[x(:) y(:)];

% optimization loop

N = max_itr; 
smth = I;
% Calculating size of image
[row, col] = size(I);
%Computing external forces
eline = smth; %eline is simply the image intensities
[grady,gradx] = imgradientxy(I);
%[grady,gradx] = BWI(x,y);
eedge = -1 * sqrt ((gradx .* gradx + grady .* grady)); %eedge is measured by gradient in the image
%masks for taking various derivatives
m1 = [-1 1];
m2 = [-1;1];
m3 = [1 -2 1];
m4 = [1;-2;1];
m5 = [1 -1;-1 1];
cx = conv2(smth,m1,'same');
cy = conv2(smth,m2,'same');
cxx = conv2(smth,m3,'same');
cyy = conv2(smth,m4,'same');
cxy = conv2(smth,m5,'same');
eterm  = smth;
for i = 1:row
    for j= 1:col

        eterm(i,j) = (cyy(i,j)*cx(i,j)*cx(i,j) -2 *cxy(i,j)*cx(i,j)*cy(i,j) + cxx(i,j)*cy(i,j)*cy(i,j))/((1+cx(i,j)*cx(i,j) + cy(i,j)*cy(i,j))^1.5);
    end
end
eedge = uint8(eedge);
eext = (eline+eedge-eterm);
[fx, fy] = imgradientxy(eext); %computing the gradient
x=x';
y=y';
[~,m] = size(x);
[mm, nn] = size(fx);
A = zeros(m,m);
b = [(2*alpha + 6 *beta) -(alpha + 4*beta) beta];
brow = zeros(1,m);
brow(1,1:3) = brow(1,1:3) + b;
brow(1,m-1:m) = brow(1,m-1:m) + [beta -(alpha + 4*beta)]; % populating a template row
for i=1:m
    A(i,:) = brow;
    brow = circshift(brow',1)'; % Template row being rotated to egenrate different rows in pentadiagonal matrix
end
[L, U] = lu(A + gamma .* eye(m,m));
Ainv = inv(U) * inv(L); % Computing Ainv using LU factorization
 for i=1:N
    
    ssx = gamma*x - kappa*interp2(fx,x,y);
    ssy = gamma*y - kappa*interp2(fy,x,y);
    
    %calculating the new position of snake
    xs = Ainv .* ssx;
    ys = Ainv .* ssy;
    
    
    %Displaying the snake in its new position
    imshow(I,[]);

    hold on;
    plot([xs;xs(1)],[ys;ys(1)],'-','Color',[c 1-c 0]);
    plot(xs(:,:),ys(:,:),'r-');
%    plot([xs; xs(1)], [ys; ys(1)], 'r--');
    hold off;
    pause(0.001)    
end