%function [object, warning, travel] = object_det(sensorer, sensor_front_nr,...
%    sensor_back_nr, sensor_right_nr, sensor_left_nr, travel, warning, object, parameters)


clear
%% Insignalen till hinderundvikningen
% anta att signalerna in ger distans i mm (5=5 mm avstånd)
%
sensorer=[4900 1500 4000 5000 6000 8000 9000 10000 12000 13000 15000]; % test på distanser
                                                 av olika sensorer                                                 
travel=[0 0];   % (fram/bak= +-1, höger/vänster= +-1)
warning=0;      % varningssignalen larmar vid 1 av vid 0
sensor_front_nr=[1 4];
sensor_back_nr=[5 7];
sensor_right_nr=[8 9];
sensor_left_nr=[10 11];

parameter=[500 560];

object=[0 0 0 0]; % anger om det finns hinder på en sida (fram, bak, höger, vänster
% bestäm sensor riktning

%% hantera in-data
sensor_front=sensorer(sensor_front_nr(1):sensor_front_nr(2));
sensor_back=sensorer(sensor_back_nr(1):sensor_back_nr(2));
sensor_right=sensorer(sensor_right_nr(1):sensor_right_nr(2));
sensor_left=sensorer(sensor_left_nr(1):sensor_left_nr(2));


% parameter är satta värden på gränsen som är tillåten för föremål (1)
% är när föremål är för nära och (2) är avståndet som den ska hålla sig
% ifrån väggen
critical=parameter(1);
wall=parameter(2);


%% bestäm om en sida är för nära
if min(sensor_front)<critical && warning==0  % fram
    if min(sensor_back)>wall
        travel(1)=-1;
    else
        warning=1;
    end
elseif min(sensor_back)<critical && warning==0   % bak
    if min(sensor_front)>wall
        travel(1)=1;
    else
        warning=1;
    end
elseif min(sensor_right)<critical && warning==0  % höger
    if min(sensor_left)>wall
        if min(sensor_front)>min(sensor_back)   % köra fram eller bak?
            travel(1)=1;
            travel(2)=-1;
        else
            travel(1)=-1;
            travel(2)=-1;
        end
    else
        warning=1;
    end
elseif min(sensor_left)<critical && warning==0   % vänster
    if min(sensor_right)>wall
        if min(sensor_front)>min(sensor_back)   % köra fram eller bak?
            travel(1)=1;
            travel(2)=1;
        else
            travel(1)=-1;
            travel(2)=1;
        end
    else
        warning=1;
    end
end
    
    
%% finns det ett hinder
if min(sensor_front)<wall
    object(1)=1;
else
    object(1)=0;
end

if min(sensor_back)<wall
    object(2)=1;
else
    object(2)=0;
end


if min(sensor_right)<wall
    object(3)=1;
else
    object(3)=0;
end


if min(sensor_left)<wall
    object(4)=1;
else
    object(4)=0;
end


%% Klar utskicka object och travel




