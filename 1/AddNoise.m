function NoisyImg = AddNoise(DicomAddress,NoiseStats)
i = dicomread(DicomAddress);
j = i(:,:,:,1);
mu= NoiseStats(1);
s = NoiseStats(2);
j = im2double(j);
NoisyImg = j + sqrt(s)*randn(size(j)) + mu;
imshow([j,NoisyImg]);
imwrite(j, 'Orglmg.png');
imwrite(NoisyImg, 'GaussianNoise.png');
plot([j(:,1,1) NoisyImg(:,1:1)])
legend('Original Signal','Signal with Noisy')
end
