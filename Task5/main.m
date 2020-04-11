img=imread('/Users/dilya/Desktop/input.jpg');  
i = rgb2gray(img);
b=4;w=251;
img_with_noise= i; 
[m,n]=size(i);
x = randint(m,n,[0,255]);
img_with_noise(x <= b) = 0;  
 img_with_noise(x >=w) = 255; 
 
subplot(1, 2, 1);
imshow(img_with_noise);
%---------------Выше добавили шум в изображение (соль и перец)

algoResult = wienerAlgoritm(img_with_noise, [10 10]);
subplot(1, 2, 2);
imshow(algoResult);
