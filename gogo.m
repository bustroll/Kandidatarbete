% Läser in webcamen, ladda ner support packages for USB webcams
camList = webcamlist 
cam = webcam(1)
preview(cam);
%%
for idx = 1:500 %Tar 500 bilder
    img = snapshot(cam);
    image(img);
    I = rgb2gray(img); %Gör om bilderna till gråskala 

A = edge(I,'canny',  0.35); %Appilicerar Cannymetoden med tröselvärde 0.35
B = imfill(A,'holes'); %Fyller i de kanterna som Cannymetoden hittar
AndelSvart=(1-nnz(B)/numel(B))*100;% Andel svart i bilden
if (AndelSvart > 99.5) 
    disp ('Här är det rent')
else
    disp('Här är det grus')
end 
 pause(1) %En delay för att vi ska hinna kolla på programmet och validera det medans det kör
end

