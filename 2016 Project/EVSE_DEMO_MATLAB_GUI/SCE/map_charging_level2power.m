function [ power ] =map_charging_level2power( charging_level )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
if  charging_level==0
    power=0; 
elseif charging_level==4
    power=0;
elseif charging_level==1 %current=6A
    power=6*240;
elseif charging_level==2 %current=16A
    power=7200;
elseif charging_level==3 %current=12A
    power=5400;
elseif charging_level==5 %current=8A
    power=3000;
elseif charging_level==6 %current=7A
    power=2500;
elseif charging_level==7
    power=2250;
elseif charging_level==8
    power=1800;
end

end

