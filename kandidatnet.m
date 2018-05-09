%% Obs ladda ner neural network toolbox!!
%Läser in bildbiblioteken från mapp.
digitDatasetPath = fullfile('Filvägtillmap');
digitData = imageDatastore(digitDatasetPath,...
        'IncludeSubfolders',true,'LabelSource','foldernames');
%%
% Definierar tränings och testdata
antal_traindata= 98; %Minsta antal av antal bilder per mapp
rng(1) % For reproducibility
[trainData,testData] = splitEachLabel(digitData,... %Skapar ett dataset och ett träningsset
				antal_traindata, 'randomize');
%%
% Läser storleken av bilden. n och m är storleken på bilden. o anger om bilden är i färg eller ej. 
[n, m, o] = size(digitData.readimage(1));

% Definerar det neurala nätverket med dess lager. 
lager = [imageInputLayer([n m o]); %Läser in bilden i nätverket och definierar bildens storlek. 
          convolution2dLayer(3,8); % Skapar 8 filter med storleken 3*3. Beräknar skalärprodukten av vikterna och indata
          reluLayer; %Sätter alla värden mindre än 0 till 
          batchNormalizationLayer %Normaliserar datan
          reluLayer  %Sätter alla värden mindre än 0 till 
          maxPooling2dLayer(2,'Stride',2) %Reducerar dimensionerna på matrisen
    
          convolution2dLayer(3,16,'Padding','same') % Skapar 16 filter med storleken 3*3. Beräknar skalärprodukten av vikterna och indata
          batchNormalizationLayer %Normaliserar datan
          reluLayer  %Sätter alla värden mindre än 0 till 
          maxPooling2dLayer(2,'Stride',2)  %Reducerar dimensionerna på matrisen
    
          convolution2dLayer(3,32,'Padding','same') % Skapar 32 filter med storleken 3*3. Beräknar skalärprodukten av vikterna och indata
          batchNormalizationLayer %Normaliserar datan
          reluLayer  %Sätter alla värden mindre än 0 till
    
          fullyConnectedLayer(3) %Kopplar ihop lagrerna och ger en storlek på 3
          softmaxLayer %Normaliserar utdatan
          classificationLayer %Klassifiserar bilden med hjälp av sannolikhet
         ];
%%
% Defininerar träningen (det finns olika val man kan göra och bestämma vad
% man vill se i plotten) 
Train_val = trainingOptions('sgdm','MaxEpochs',20,...
	'InitialLearnRate',0.0001, 'ExecutionEnvironment', 'parallel', 'Plots','training-progress');
%% Startar träningen av nätverket 
net = trainNetwork(trainData,lager,Train_val); % Startar träning av nätverket
A = testData.Labels; % Testdatans etiketter 
B = classify(net,testData); %Klassification av testdatan med hjälp av nätverket
C = sum(B == A)/numel(A) % C anger hur exakt nätverket är


%% Validering av nätverket
testbilderPath = fullfile('filvägtillmapp');
testbilder = imageDatastore(testbilderPath,'IncludeSubfolders',true,'LabelSource','foldernames');
Valideringsbilder= augmentedImageDatastore([n m o],testbilder); %Ändrar storleken på bilderna i datastoren för att kunna ta in större bilder i nätverket. 

%%
net.classify(Valideringsbilder)   % Klassifiserar valideringsbilderna. 
