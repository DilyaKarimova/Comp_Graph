image = imread('/Users/dilyara/Desktop/Comp_Graph/TwoProject/котэ.bmp');
img = double(image)/255;

c1 = img(:,:,1);
c2 = img(:,:,2);
c3 = img(:,:,3); %выделение битовых плоскостей


v1= max((max(c1))).*c1-c1.*c1;
v2= max((max(c2))).*c2-c2.*c2;
v3= max((max(c3))).*c3-c3.*c3; %cоляризация каждой битовой плоскости

result = img;

result(:,:,1) = v1;
result(:,:,2) = v2;
result(:,:,3) = v3; %сборка результирующего изображения


subplot(2, 8, 1);
imshow(img);

subplot(2, 8, 2);
imshow(c1);

subplot(2, 8, 3);
imshow(c2);

subplot(2, 8, 4);
imshow(c3);

subplot(2, 8, 5);
imshow(v1);

subplot(2, 8, 6);
imshow(v2);

subplot(2, 8, 7);
imshow(v3);

subplot(2, 8, 8);
imshow(result);

subplot(2, 8, 9);
histogram(img);

subplot(2, 8, 10);
histogram(c1);

subplot(2, 8, 11);
histogram(c2);

subplot(2, 8, 12);
histogram(c3);

subplot(2, 8, 13);
histogram(v1);

subplot(2, 8, 14);
histogram(v2);

subplot(2, 8, 15);
histogram(v3);

subplot(2, 8, 16);
histogram(result);

imwrite(result, 'BmpToJpg.jpg');
