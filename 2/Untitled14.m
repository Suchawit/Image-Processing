[imgHE, orgHist, heHist] = myHistEq(img);
[imgHE2, orgHist2, heHist2] = myHistEq(img_2);
subplot(1,2,1),imshow(imgHE),title('histogram-equalized original');
subplot(1,2,2),imshow(imgHE2),title('LoG-sharpened');
imwrite(imgHE2,'7-SharpenedwithLoG.png');
