clear all
clf
clc

global xPosition;
xPosition = -1;
global yPosition;
yPosition = -1;
global theta;
theta = 0;
global maxVelocity;
maxVelocity = 1.39;
global currentVelocity;
currentVelocity = 0;
global acceleration;
acceleration = 0.4;
global deacceleration;
deacceleration = -0.4;
global gridSize;
gridSize = zeros(110,65);
global timeStep;
timeStep = 1;
global wall;
wall = 0;

InitializePostion();
InitializeTheta();
vector = InitializeRV();
Path(vector);
%%
PlotSim();

%%1. Roboten får en startposition
%%2. Beräkna riktningsvektor
%%3. Räknar ut vägen
%%4a. Roboten kör fram tills kant (+1 i varje grid)
%%4b. Kunna vända och kör vidare
%4c. Acceleration/Deacceleration vid kanterna (Kolla när den måste börja
%    stanna in, vid ny theta måste hastighete vara 0
%5. Räkna ut procentdel i matrisen som har siffror skiljt från 0
% - Om procentdelen är mindre än X%
%%7a. Roboten uppdatera theta
%8a. Gör om 3-5
% - else
%%7b. Skriv ut resultaten
%%8b. Plotta grid-matrisen
% Klar! :)