function [total_power_consumption,EV_charging_status,previous_set_level_time]=dumb_charging(previous_set_level_time,EV_quantity,EV_number,charging_time,EV_charging_status,threshold_time,time_elapse);
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
total_power_consumption=0;
    set_level=2;
for i=1:EV_quantity
  
    if EV_charging_status(1,i)~=4
        EV_charging_status(1,i)=set_level;
    end
    previous_set_level_time(i)=time_elapse;
    total_power_consumption=total_power_consumption+map_charging_level2power(EV_charging_status(1,i));
end

return
        



end

