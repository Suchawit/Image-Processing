%Problem 1)
%a)
I = imread("ChestXray.png");
I = imnoise(I,'salt & pepper',0.02);
imshow(I);

%b) 
denoised = myMedian(I,3);
imshowpair(I,denoised,'montage')
imwrite(I,"1-Noisy.png");
imwrite(denoised,"2-Denoised.png");

%Problem 2)
img = imread("ChestXray.png");
myHistEq(img);
[imgHE, orgHist, heHist] = myHistEq(img);
imwrite(img,"3-LowContrast.png");
imwrite(imgHE,"4-HistogramEqualized.png");

%Problem 3)

%a)
kenel = myGaussian(11,1.5);
surf(kenel);
sum(kenel);
sum(sum(kenel));
Apply = imfilter(img,kenel,'replicate');
imshowpair(img,Apply,'montage');
imwrite(Apply,"5-SmoothedwithGaussian.png");

%b)
kenel = myGaussian(5,2);
sum(kenel);
sum(sum(kenel));

%Problem 4)
kenel = myGaussian(11,1.5);
Apply = imfilter(img,kenel,'replicate');
Gmask = img - Apply;
unsharped = img+Gmask; %apply fig 3 in assignment 2
imshowpair(img,unsharped,'montage');
[imgHE, orgHist, heHist] = myHistEq(img);
[imgHE2, orgHist2, heHist2] = myHistEq(unsharped);
subplot(1,2,1),imshow(imgHE),title('histogram-equalized original');
subplot(1,2,2),imshow(imgHE2),title('sharpened');
imwrite(imgHE2,'6-SharpenedwithGaussian.png');

%Problem 5)
%a)
kernel = myLoG(19, 3);
surf(kernel);
sum(sum(kernel));

%b)
kernel = myLoG(9, 0.6);
img_LOG = imfilter(img, kernel, 'symmetric', 'conv');
img_2 = img - img_LOG; % apply figure 4 in assignment 2
[imgHE, orgHist, heHist] = myHistEq(img);
[imgHE2, orgHist2, heHist2] = myHistEq(img_2);
subplot(1,2,1),imshow(imgHE),title('histogram-equalized original');
subplot(1,2,2),imshow(imgHE2),title('LoG-sharpened');
imwrite(imgHE2,'7-SharpenedwithLoG.png');
