full_path = 'DICOM images\thyroid5.dcm'; 
dicominfo_image = dicominfo(full_path);
dicomread_image = dicomread(dicominfo_image);
dicomread_image2 = mat2gray(dicomread_image);
%gaussion fileter
J = imGaussFilter(dicomread_image2, 3, 3, 0);
%CLAHE filter
res = adapthisteq(J,'cliplimit',0.01,'Distribution','rayleigh');

figure
subplot(1,3,1);
imshow(dicomread_image2);
title('Original Image');
%show filtered image
subplot(1,3,2);
imshow(res);
title('2 filtered image');
[peaksnr, snr] = psnr(res,dicomread_image2);  
fprintf('\n The Peak-SNR value is %0.4f', peaksnr);
%to calculate SNR
fprintf('\n The SNR value is %0.4f \n', snr);