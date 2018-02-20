clear all; clc; clf;
I = imread('DSC_0324.JPG');

%image(I);
%imshow(I);


a = edge(rgb2gray(I),'Roberts');
b = edge(rgb2gray(I),'Prewitt');
c = edge(rgb2gray(I),'Sobel');

d = edge(rgb2gray(I),'Roberts',0);
e = edge(rgb2gray(I),'Roberts',0.05);

subplot(3,2,1)
imshow(a);

subplot(3,2,2)
imshow(b);

subplot(3,2,3)
imshow(c);

subplot(3,2,4)
imshow(I);

subplot(3,2,5)
imshow(d);

subplot(3,2,6)
imshow(e);

%%
I = rgb2gray(imread('DSC_0324.JPG'));

[~, threshold] = edge(I,'Sobel');
fudgeFactor = 0.9;
x = edge(I,'Sobel', threshold * fudgeFactor);
se90 = strel('line',4,90);
se0 = strel('line',4,0);
xdil = imdilate(x,[se90,se0]);
xfill = imfill(xdil,'holes');
xnobord = imclearborder(xfill,4);
seD = strel('diamond',1);
xfinal = imerode(xnobord,seD);
xfinal = imerode(xfinal,seD);
xoutline = bwperim(xfinal);
Segout = I; 
Segout(xoutline) = 255; 
figure, imshow(Segout)