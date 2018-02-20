% openExample('images/DetectEdgesInImagesExample')
f=dir('grus.jpg');
fil={f.name};  
for k=1:numel(fil)
  file=fil{k}
  new_file=strrep(file,'.jpg','.png')
  im=imread(file)
  imwrite(im,new_file)
end
%%
RGB = imread('grus.png');
imshow(RGB)
I = rgb2gray(RGB);
figure
imshow(I)

%%  Hitta kanterna p� bilden, samt j�mf�r sobel och canny => Canny �r b�st
% Apply both the Sobel and Canny edge detectors to the image and display
% them for comparison.
BW1 = edge(I,'sobel', 0.15); % F�r inte rikigt med allt... 
BW2 = edge(I,'canny',  0.35);% Denna �r den b�sta!!!
figure;
imshowpair(BW1,BW2,'montage')
title('Sobel Filter                                   Canny Filter');
%[BW1,threshOut] = edge(I,'Sobel');

%% Fyller h�l, inte perfekt men tillr�ckligt m�nga tror jag
BW3 = imfill(BW2,'holes');
figure
imshow(BW3)
title('Filled Image')

%% Procent svart i bilden
percentageBlack=(1-nnz(BW3)/numel(BW3))*100;
% H�r kan man g�ra n�gon slags krav att om percentageBlack > 99.5 (Detta
% v�rde m�ste valideras) t�nd inte lampan. 
if (percentageBlack > 99.5)
    disp ('H�r �r det rent')
else
    disp('H�r �r det grus')
end 

%% Vidare tankar och uppgifter: 
% Vilken kvadrant ligger det i bilden, om hela bilden �r t�ckt spelar det
% ingen roll vilket h�ll den g�r �t osv. 
% S�kskilja grus fr�n sladdar och andra objekt. 
% F� ut hur m�nga procent som �r gurs av varje kvadrant 
