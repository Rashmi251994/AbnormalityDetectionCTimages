full_path = 'lung4.dcm'; 
dicominfo_image = dicominfo(full_path);
dicomread_image = dicomread(dicominfo_image);
dicomread_image2 = mat2gray(dicomread_image);

K = medfilt2(dicomread_image2,[3 3]);
J = imGaussFilter(K, 3, 3, 0);
res = adapthisteq(J,'cliplimit',0.01,'Distribution','rayleigh');

hy = fspecial('sobel');
hx = hy';
Iy = imfilter(double(res ), hy, 'replicate');
Ix = imfilter(double(res ), hx, 'replicate');
gradmag = sqrt(Ix.^2 + Iy.^2);
figure
imshow(gradmag,[]), title('Gradient magnitude (gradmag)')
%L = watershed(gradmag);
%Lrgb = label2rgb(L);
%figure, imshow(Lrgb), title('Watershed transform of gradient magnitude (Lrgb)')
se = strel('disk', 20);
Io = imopen(res , se);
figure
imshow(Io), title('Opening (Io)')
Ie = imerode(res , se);
Iobr = imreconstruct(Ie,res );
figure
imshow(Iobr), title('Opening-by-reconstruction (Iobr)')
Ioc = imclose(Io, se);
figure
imshow(Ioc), title('Opening-closing (Ioc)')
Iobrd = imdilate(Iobr, se);
Iobrcbr = imreconstruct(imcomplement(Iobrd), imcomplement(Iobr));
Iobrcbr = imcomplement(Iobrcbr);
figure
imshow(Iobrcbr), title('Opening-closing by reconstruction (Iobrcbr)')
fgm = imregionalmax(Iobrcbr);
figure
imshow(fgm), title('Regional maxima of opening-closing by reconstruction (fgm)')
I2 = res ;
I2(fgm) = 255;
figure
imshow(I2), title('Regional maxima superimposed on original image (I2)')
se2 = strel(ones(5,5));
fgm2 = imclose(fgm, se2);
fgm3 = imerode(fgm2, se2);
fgm4 = bwareaopen(fgm3, 20);
I3 = res ;
I3(fgm4) = 255;
figure
imshow(I3)
title('Modified regional maxima superimposed on original image (fgm4)')
bw=im2bw(Iobrcbr,0.4941);
%level = graythresh(Iobrcbr);
%bw = imbinarize(Iobrcbr,level);
figure
imshow(bw), title('Thresholded opening-closing by reconstruction (bw)')
D = bwdist(bw);
DL = watershed(D);
bgm = DL == 0;
figure
imshow(bgm), title('Watershed ridge lines (bgm)')
gradmag2 = imimposemin(gradmag, bgm | fgm4);
L = watershed(gradmag2);
figure
imshow(L), title('watershed')
I4 = res ;
I4(imdilate(L == 0, ones(3, 3)) | bgm | fgm4) = 255;
figure
imshow(I4)
title('Markers and object boundaries superimposed on original image (I4)')
Lrgb = label2rgb(L, 'jet', 'w', 'shuffle');
figure
imshow(Lrgb)
title('Colored watershed label matrix (Lrgb)')

