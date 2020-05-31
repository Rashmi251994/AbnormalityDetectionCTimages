full_path = 'DICOM images\thyroid5.dcm'; 
dicominfo_image = dicominfo(full_path);
dicomread_image = dicomread(dicominfo_image);
dicomread_image2 = mat2gray(dicomread_image);
X=dicomread_image2;
[A,H,V,D]=dwt_2D(X,'Haar');
%Y = idwt_2D(A,H,V,D,'Haar');
I=imresize(A,[512,512]);

figure
subplot(1,3,1);
imshow(dicomread_image2);colormap gray
title('Original Image');
%subplot(1,3,2)
%imagesc(j);
 
subplot(1,3,2);
imshow(I); colormap gray
title('Haar wavelet');
figure(2)
subplot(2,2,1);
imhist(dicomread_image2);
title('Histogram of original image');
subplot(2,2,2);
imhist(A);
title('Histogram of Haar filtered image');


[peaksnr, snr] = psnr(dicomread_image2,I);  
fprintf('\n The Peak-SNR value is %0.4f', peaksnr);
%to calculate SNR
fprintf('\n The SNR value is %0.4f \n', snr);