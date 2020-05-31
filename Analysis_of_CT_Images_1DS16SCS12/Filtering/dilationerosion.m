full_path = 'DICOM images\blader5.dcm'; 
dicominfo_image = dicominfo(full_path);
dicomread_image = dicomread(dicominfo_image);
dicomread_image2 = mat2gray(dicomread_image);

se = strel('disk',10);
D = imdilate(dicomread_image2,se);
E = imerode(dicomread_image2,se);
D=imdilate(dicomread_image2,se);
figure
subplot(1,3,1);
imshow(dicomread_image2);
title('Original Image');
%show opening image
subplot(1,3,2);
imshow(D);
title('Morphological Dilation');
%show closing image
subplot(1,3,3);
imshow(E);
title('Morphological Erosion');
%to calculate PSNR

[peaksnr1, snr1] = psnr(D, dicomread_image2);  
fprintf('\n The Peak-SNR value of Dilated image is %0.4f', peaksnr1);
%to calculate SNR
fprintf('\n The SNR value of dilated image is %0.4f \n', snr1);
[peaksnr2, snr2] = psnr(E,dicomread_image2);  
fprintf('\n The Peak-SNR value of eroded image is %0.4f', peaksnr2);
%to calculate SNR
fprintf('\n The SNR value of eroded image is %0.4f \n', snr2);