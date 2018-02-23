%function [object, warning, travel] = object_det(sensorer, sensor_front_nr,...
%    sensor_back_nr, sensor_right_nr, sensor_left_nr, travel, warning, object, parameters)


clear
%% Insignalen till hinderundvikningen
% anta att signalerna in ger distans i mm (5=5 mm avst�nd)
%
sensorer=[4900 1500 4000 5000 6000 8000 9000 10000 12000 13000 15000]; % test p� distanser
                                                 av olika sensorer                                                 
travel=[0 0];   % (fram/bak= +-1, h�ger/v�nster= +-1)
warning=0;      % varningssignalen larmar vid 1 av vid 0
sensor_front_nr=[1 4];
sensor_back_nr=[5 7];
sensor_right_nr=[8 9];
sensor_left_nr=[10 11];

parameter=[500 560];

object=[0 0 0 0]; % anger om det finns hinder p� en sida (fram, bak, h�ger, v�nster
% best�m sensor riktning

%% hantera in-data
sensor_front=sensorer(sensor_front_nr(1):sensor_front_nr(2));
sensor_back=sensorer(sensor_back_nr(1):sensor_back_nr(2));
sensor_right=sensorer(sensor_right_nr(1):sensor_right_nr(2));
sensor_left=sensorer(sensor_left_nr(1):sensor_left_nr(2));


% parameter �r satta v�rden p� gr�nsen som �r till�ten f�r f�rem�l (1)
% �r n�r f�rem�l �r f�r n�ra och (2) �r avst�ndet som den ska h�lla sig
% ifr�n v�ggen
critical=parameter(1);
wall=parameter(2);


%% best�m om en sida �r f�r n�ra
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
elseif min(sensor_right)<critical && warning==0  % h�ger
    if min(sensor_left)>wall
        if min(sensor_front)>min(sensor_back)   % k�ra fram eller bak?
            travel(1)=1;
            travel(2)=-1;
        else
            travel(1)=-1;
            travel(2)=-1;
        end
    else
        warning=1;
    end
elseif min(sensor_left)<critical && warning==0   % v�nster
    if min(sensor_right)>wall
        if min(sensor_front)>min(sensor_back)   % k�ra fram eller bak?
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




