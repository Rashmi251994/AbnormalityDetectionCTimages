full_path = 'DICOM images\thyroid5.dcm'; 
dicominfo_image = dicominfo(full_path);
dicomread_image = dicomread(dicominfo_image);
dicomread_image2 = mat2gray(dicomread_image);

se = strel('disk',10);
BW= imopen(dicomread_image2,se);
BW2 = imclose(dicomread_image2,se);
D=imdilate(dicomread_image2,se);
figure
subplot(1,3,1);
imshow(dicomread_image2);
title('Original Image');
%show opening image
subplot(1,3,2);
imshow(BW);
title('Morphological Opening');
%show closing image
subplot(1,3,3);
imshow(BW2);
title('Morphological closing');
%to calculate PSNR

[peaksnr1, snr1] = psnr(BW, dicomread_image2);  
fprintf('\n The Peak-SNR value of opening image is %0.4f', peaksnr1);
%to calculate SNR
fprintf('\n The SNR value of opening image is %0.4f \n', snr1);
[peaksnr2, snr2] = psnr(dicomread_image2,BW2);  
fprintf('\n The Peak-SNR value of closing image is %0.4f', peaksnr2);
%to calculate SNR
fprintf('\n The SNR value of closing image is %0.4f \n', snr2);