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

%%  Hitta kanterna på bilden, samt jämför sobel och canny => Canny är bäst
% Apply both the Sobel and Canny edge detectors to the image and display
% them for comparison.
BW1 = edge(I,'sobel', 0.15); % Får inte rikigt med allt... 
BW2 = edge(I,'canny',  0.35);% Denna är den bästa!!!
figure;
imshowpair(BW1,BW2,'montage')
title('Sobel Filter                                   Canny Filter');
%[BW1,threshOut] = edge(I,'Sobel');

%% Fyller hål, inte perfekt men tillräckligt många tror jag
BW3 = imfill(BW2,'holes');
figure
imshow(BW3)
title('Filled Image')

%% Procent svart i bilden
percentageBlack=(1-nnz(BW3)/numel(BW3))*100;
% Här kan man göra någon slags krav att om percentageBlack > 99.5 (Detta
% värde måste valideras) tänd inte lampan. 
if (percentageBlack > 99.5)
    disp ('Här är det rent')
else
    disp('Här är det grus')
end 

%% Vidare tankar och uppgifter: 
% Vilken kvadrant ligger det i bilden, om hela bilden är täckt spelar det
% ingen roll vilket håll den går åt osv. 
% Säkskilja grus från sladdar och andra objekt. 
% Få ut hur många procent som är gurs av varje kvadrant 
