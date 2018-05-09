%% Obs ladda ner neural network toolbox!!
%L�ser in bildbiblioteken fr�n mapp.
digitDatasetPath = fullfile('Filv�gtillmap');
digitData = imageDatastore(digitDatasetPath,...
        'IncludeSubfolders',true,'LabelSource','foldernames');
%%
% Definierar tr�nings och testdata
antal_traindata= 98; %Minsta antal av antal bilder per mapp
rng(1) % For reproducibility
[trainData,testData] = splitEachLabel(digitData,... %Skapar ett dataset och ett tr�ningsset
				antal_traindata, 'randomize');
%%
% L�ser storleken av bilden. n och m �r storleken p� bilden. o anger om bilden �r i f�rg eller ej. 
[n, m, o] = size(digitData.readimage(1));

% Definerar det neurala n�tverket med dess lager. 
lager = [imageInputLayer([n m o]); %L�ser in bilden i n�tverket och definierar bildens storlek. 
          convolution2dLayer(3,8); % Skapar 8 filter med storleken 3*3. Ber�knar skal�rprodukten av vikterna och indata
          reluLayer; %S�tter alla v�rden mindre �n 0 till 
          batchNormalizationLayer %Normaliserar datan
          reluLayer  %S�tter alla v�rden mindre �n 0 till 
          maxPooling2dLayer(2,'Stride',2) %Reducerar dimensionerna p� matrisen
    
          convolution2dLayer(3,16,'Padding','same') % Skapar 16 filter med storleken 3*3. Ber�knar skal�rprodukten av vikterna och indata
          batchNormalizationLayer %Normaliserar datan
          reluLayer  %S�tter alla v�rden mindre �n 0 till 
          maxPooling2dLayer(2,'Stride',2)  %Reducerar dimensionerna p� matrisen
    
          convolution2dLayer(3,32,'Padding','same') % Skapar 32 filter med storleken 3*3. Ber�knar skal�rprodukten av vikterna och indata
          batchNormalizationLayer %Normaliserar datan
          reluLayer  %S�tter alla v�rden mindre �n 0 till
    
          fullyConnectedLayer(3) %Kopplar ihop lagrerna och ger en storlek p� 3
          softmaxLayer %Normaliserar utdatan
          classificationLayer %Klassifiserar bilden med hj�lp av sannolikhet
         ];
%%
% Defininerar tr�ningen (det finns olika val man kan g�ra och best�mma vad
% man vill se i plotten) 
Train_val = trainingOptions('sgdm','MaxEpochs',20,...
	'InitialLearnRate',0.0001, 'ExecutionEnvironment', 'parallel', 'Plots','training-progress');
%% Startar tr�ningen av n�tverket 
net = trainNetwork(trainData,lager,Train_val); % Startar tr�ning av n�tverket
A = testData.Labels; % Testdatans etiketter 
B = classify(net,testData); %Klassification av testdatan med hj�lp av n�tverket
C = sum(B == A)/numel(A) % C anger hur exakt n�tverket �r


%% Validering av n�tverket
testbilderPath = fullfile('filv�gtillmapp');
testbilder = imageDatastore(testbilderPath,'IncludeSubfolders',true,'LabelSource','foldernames');
Valideringsbilder= augmentedImageDatastore([n m o],testbilder); %�ndrar storleken p� bilderna i datastoren f�r att kunna ta in st�rre bilder i n�tverket. 

%%
net.classify(Valideringsbilder)   % Klassifiserar valideringsbilderna. 
