clc;clear;

%Antag cirkulär form på robot
D = 0.45; %Diameter cm (baserat på Husqvarna 305)

%Antag sensorräckvidd = 1 m, max tillåtet avstånd = 0.2 m, 
%vinkel sensorna ser i (gamma) till 15 grader och sensorhöjd = 0.25 m.

max_range = 1;
critical_range = 0.2;
gamma = 15 * pi / 180;
h1 = 0.25; 

%Ansätt antal sensorer n

n = [2 5 10 15 20]; 

%Beräkna vinkel mellan varje sensor

alpha = 2 * pi ./ n - gamma; 

%beräkna den andra vinkeln i triangeln de sensorstrålarna bildar

beta = (pi - alpha) / 2;

%Beräkna avstånd från robots centrum till maximal sensorrange och till 
%minsta tillåtna avstånd

r_max_range  = D/2 + max_range; 
r_critical_range = D/2 + critical_range; 

%Beräkna minimal detekterbar bredd B på föremål vid olika avstånd. 
%Bredden är bredden som sedd ifrån robotens centrum

B_max_range = 2 * cos(beta) * r_max_range;        
B_critical_range = 2 * cos(beta) * r_critical_range;

%Beräkna minimal detekterbar höjd H på föremål vid olika avstånd.
%Höjden är höjden vinkelrätt från golvet.

h2_max_range = tan (gamma/2) * max_range;
h2_critical_range = tan(gamma/2) * critical_range;

H_max_range = h1 - h2_max_range;
H_critical_range = h1 - h2_critical_range;

%Beräkna avståndet då sensorn ser ända till golvet. 

Range_floor = h1 / tan(gamma/2);




                         

