full_path = 'DICOM images\lung1.dcm'; 
dicominfo_image = dicominfo(full_path);
dicomread_image = dicomread(dicominfo_image);
dicomread_image2 = mat2gray(dicomread_image);

K = adapthisteq(dicomread_image2,'cliplimit',0.01,'Distribution','rayleigh');
%K = adapthisteq(dicomread_image2);
figure
subplot(2,2,1);
imhist(dicomread_image2);
title('Histogram of original image');
subplot(2,2,2);
imhist(K);
title('Histogram of CLAHE filtered image');
subplot(2,2,3);
imshow(dicomread_image2);
title('Original Image');
%show filtered image
subplot(2,2,4);
imshow(K);
title('CLAHE filtered image');
%to calculate PSNR

[peaksnr, snr] = psnr(dicomread_image2,K);  
fprintf('\n The Peak-SNR value is %0.4f', peaksnr);
%to calculate SNR
fprintf('\n The SNR value is %0.4f \n', snr);