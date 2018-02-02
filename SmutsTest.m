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

%%1. Roboten f�r en startposition
%%2. Ber�kna riktningsvektor
%%3. R�knar ut v�gen
%%4a. Roboten k�r fram tills kant (+1 i varje grid)
%%4b. Kunna v�nda och k�r vidare
%4c. Acceleration/Deacceleration vid kanterna (Kolla n�r den m�ste b�rja
%    stanna in, vid ny theta m�ste hastighete vara 0
%5. R�kna ut procentdel i matrisen som har siffror skiljt fr�n 0
% - Om procentdelen �r mindre �n X%
%%7a. Roboten uppdatera theta
%8a. G�r om 3-5
% - else
%%7b. Skriv ut resultaten
%%8b. Plotta grid-matrisen
% Klar! :)