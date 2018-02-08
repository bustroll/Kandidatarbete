clc;clear;

%Antag cirkul�r form p� robot
D = 0.45; %Diameter cm (baserat p� Husqvarna 305)

%Antag sensorr�ckvidd = 1 m, max till�tet avst�nd = 0.2 m, 
%vinkel sensorna ser i (gamma) till 15 grader och sensorh�jd = 0.25 m.

max_range = 1;
critical_range = 0.2;
gamma = 15 * pi / 180;
h1 = 0.25; 

%Ans�tt antal sensorer n

n = [2 5 10 15 20]; 

%Ber�kna vinkel mellan varje sensor

alpha = 2 * pi ./ n - gamma; 

%ber�kna den andra vinkeln i triangeln de sensorstr�larna bildar

beta = (pi - alpha) / 2;

%Ber�kna avst�nd fr�n robots centrum till maximal sensorrange och till 
%minsta till�tna avst�nd

r_max_range  = D/2 + max_range; 
r_critical_range = D/2 + critical_range; 

%Ber�kna minimal detekterbar bredd B p� f�rem�l vid olika avst�nd. 
%Bredden �r bredden som sedd ifr�n robotens centrum

B_max_range = 2 * cos(beta) * r_max_range;        
B_critical_range = 2 * cos(beta) * r_critical_range;

%Ber�kna minimal detekterbar h�jd H p� f�rem�l vid olika avst�nd.
%H�jden �r h�jden vinkelr�tt fr�n golvet.

h2_max_range = tan (gamma/2) * max_range;
h2_critical_range = tan(gamma/2) * critical_range;

H_max_range = h1 - h2_max_range;
H_critical_range = h1 - h2_critical_range;

%Ber�kna avst�ndet d� sensorn ser �nda till golvet. 

Range_floor = h1 / tan(gamma/2);




                         

