function [ total_charging_car,total_power_consumption,EV_charging_status,previous_set_level_time] = smart_charging(previous_set_level_time,EV_quantity,EV_number,EV_time_since_charging,EV_charging_status,threshold_time,time_elapse,season,wind)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes hereV
total_power_consumption=0;
%%power_level2=2000;
%%quantity_threshold=0.8*available_power/power_level2;


disable=0;
min=1;
complete=4;
max=2;
total_charging_car=0;
timefactor=6; %8seconds=1hr
initialtime=5;%starting at 5pm

switch season 
    case 'Winter'
        groupA=ceil(EV_quantity/3);
        groupB=groupA+ceil(EV_quantity/3);
    case 'Fall'
        groupA=ceil(11*EV_quantity/20);
   %{
    case 'Summer'
        groupA=ceil(11.2*EV_quantity/20);
        %}
    otherwise
        groupA=ceil(10.5*EV_quantity/20);
end
% if EV_quantity>quantity_threshold
%     set_level=1;
% else
%     set_level=2;
% end
for i=1:EV_quantity
    %after charging for certain time and before 8pm
    if EV_time_since_charging(i)>threshold_time && time_elapse<((8-initialtime)*timefactor)
        if time_elapse<((7-initialtime)*timefactor)
            if EV_charging_status(i)~=complete
                EV_charging_status(1,i)=min;
            end
        else
            if EV_charging_status(i)~=complete
                EV_charging_status(1,i)=disable;
            end
        end
        %previous_set_level_time(i)=time_elapse;
    %after charging for certain time and after 8pm, which scheduling starts
    elseif EV_time_since_charging(i)>threshold_time && time_elapse>((8-initialtime)*timefactor)
        switch season 
            case 'Winter'
                max=2;
                if time_elapse<((11-initialtime)*timefactor) %first frame
                   if i<=groupA 
                       if EV_charging_status(i)~=complete
                           EV_charging_status(1,i)=max;
                       end
                   else 
                       if EV_charging_status(i)~=complete
                       EV_charging_status(1,i)=disable;
                       end
                   end
                elseif time_elapse>((11-initialtime)*timefactor) && time_elapse<((14-initialtime)*timefactor) %second frame
                   if (i>groupA && i<=groupB)
                       if EV_charging_status(i)~=complete
                           EV_charging_status(1,i)=max;
                       end
                   else 
                       if EV_charging_status(i)~=complete
                       EV_charging_status(1,i)=disable;
                       end
                   end
                else %third frame
                    if i>groupB
                        if EV_charging_status(i)~=complete
                           EV_charging_status(1,i)=max;
                        end
                    else %%unnecessary
                        if EV_charging_status(i)~=complete
                           EV_charging_status(1,i)=disable;
                        end
                    end
                end
            case 'Summer'
                if time_elapse<((12-initialtime)*timefactor) %first frame
                      if EV_charging_status(i)~=complete
                           EV_charging_status(1,i)=5;
                      end
                elseif time_elapse>((12-initialtime)*timefactor) && time_elapse<((13-initialtime)*timefactor) %second frame
                       if EV_charging_status(i)~=complete
                           EV_charging_status(1,i)=6;
                       end
                elseif time_elapse>((13-initialtime)*timefactor) && time_elapse<((15-initialtime)*timefactor) %second frame
                       if EV_charging_status(i)~=complete
                           EV_charging_status(1,i)=7;
                       end
                else %third frame
                        if EV_charging_status(i)~=complete
                           EV_charging_status(1,i)=8;
                        end
                end
            otherwise
                max=3;
                if time_elapse<((12-initialtime)*timefactor) %first frame
                   if i<=groupA
                       if EV_charging_status(i)~=complete
                           EV_charging_status(1,i)=max;
                       end
                   else 
                       if EV_charging_status(i)~=complete
                       EV_charging_status(1,i)=disable;
                       end
                   end
                   else %second frame
                    if i>groupA
                        if EV_charging_status(i)~=complete
                           EV_charging_status(1,i)=max;
                        end
                    else %%unnecessary
                        if EV_charging_status(i)~=complete
                           EV_charging_status(1,i)=disable;
                        end
                    end
                end 
        end
    %haven't charge for a certain time, ignore all the smart scheduling,
    %charging itself first
    elseif EV_time_since_charging(i)<threshold_time
        if EV_charging_status(i)~=complete
        EV_charging_status(1,i)=max;
        %previous_set_level_time(i)=time_elapse;
        end
    end
    
    %taking care of additional wind power, only for those car in the
    %scheduling list
    if EV_time_since_charging(i)>threshold_time && time_elapse>((8-initialtime)*timefactor) && wind>106442
        switch season
            case 'Summer'
                if EV_charging_status(i) ~=complete
                    if wind >=0
                        if time_elapse<((12-initialtime)*timefactor) %first frame
                           EV_charging_status(1,i)=3;
                           wind=wind-5400;
                        elseif time_elapse>((12-initialtime)*timefactor) && time_elapse<((13-initialtime)*timefactor)
                           EV_charging_status(1,i)=5;
                           wind=wind-3000;
                        elseif time_elapse>((13-initialtime)*timefactor) && time_elapse<((15-initialtime)*timefactor)
                           EV_charging_status(1,i)=6;
                           wind=wind-2500;
                        else
                           EV_charging_status(1,i)=7;
                           wind=wind-2250;
                        end
                    end
                end
            case 'Winter'
                max=2;
                if EV_charging_status(i) == disable
                    if wind >=0
                        EV_charging_status(i) = max;
                        wind=wind-7200;
                    end
                end
            otherwise
                max=3;
                if EV_charging_status(i) == disable
                    if wind >=0
                        EV_charging_status(i) = max;
                        wind=wind-5400;
                    end
                end
        end
    end
    if time_elapse>((17.5-initialtime)*timefactor) %first frame
        if EV_charging_status(i)~=complete
            EV_charging_status(1,i)=max;
        end
    end
    previous_set_level_time(i)=time_elapse;
    
    total_power_consumption=total_power_consumption+map_charging_level2power(EV_charging_status(i));
    if (EV_charging_status(i)~=0 && EV_charging_status(i)~=4)
        total_charging_car=total_charging_car+1;
    end

end
return
end

