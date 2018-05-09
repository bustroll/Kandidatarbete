% L�ser in webcamen, ladda ner support packages for USB webcams
camList = webcamlist 
cam = webcam(1)
preview(cam);
%%
for idx = 1:500 %Tar 500 bilder
    img = snapshot(cam);
    image(img);
    I = rgb2gray(img); %G�r om bilderna till gr�skala 

A = edge(I,'canny',  0.35); %Appilicerar Cannymetoden med tr�selv�rde 0.35
B = imfill(A,'holes'); %Fyller i de kanterna som Cannymetoden hittar
AndelSvart=(1-nnz(B)/numel(B))*100;% Andel svart i bilden
if (AndelSvart > 99.5) 
    disp ('H�r �r det rent')
else
    disp('H�r �r det grus')
end 
 pause(1) %En delay f�r att vi ska hinna kolla p� programmet och validera det medans det k�r
end

