function [EV,EV_comp] = smartnit_update( EV,EV_comp,time_elapse,add_EV)
 %EV_quantity, EV_number, EV_charging_status, EV_charging_time, EV_energy, EV_previous_setlevel_time
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
full_energy=172800; %30KWh one hour is 6s


for  i=1:EV.EV_quantity %always start from the first virtual node because full_energy is for virtual node.
        if (EV.EV_charging_status(i)~=0);
        EV.charging_time(i)=EV.charging_time(i)+(time_elapse-EV.EV_previous_setlevel_time(i));
        EV.energy(i)=EV.energy(i)+(time_elapse-EV.EV_previous_setlevel_time(i))*map_charging_level2power(EV.EV_charging_status(i));
        end
    if (EV.energy(i)>=full_energy && EV.EV_number(i)~=0);
        EV.EV_charging_status(i)=4; %Note!!!This part is inefficient in terms of algorithm because concatenation is used inside loop. Optimization is needed.
 %       EV_charging_status(i)=[];
  %      EV_number(i)=[];
  %      EV_charging_time(i)=[];
  %      EV_previous_setlevel_time(i)=[];
  %      EV_energy(i)=[];
  %      EV_quantity=EV_quantity-1;
        continue;
    end
end


for  i=1:EV_comp.EV_quantity
        if (EV_comp.EV_charging_status(i)~=0);
        EV_comp.charging_time(i)=EV_comp.charging_time(i)+(time_elapse-EV_comp.EV_previous_setlevel_time(i));

        EV_comp.energy(i)=EV_comp.energy(i)+(time_elapse-EV_comp.EV_previous_setlevel_time(i))*map_charging_level2power(EV_comp.EV_charging_status(i));
        end
    if EV_comp.energy(i)>=full_energy;
        EV_comp.EV_charging_status(i)=4; %Note!!!This part is inefficient in terms of algorithm because concatenation is used inside loop. Optimization is needed.

        continue;
    end
end
   


   
   
   
%if (time_elapse>2 && time_elapse<4)  
    %add_EV=randi([1,2],1,1);
if add_EV~=0
    new_EV_status=zeros(1,add_EV);
    new_EV_charging_time=zeros(1,add_EV);
    new_EV_setlevel_time=ones(1,add_EV)*time_elapse;
    new_EV_number=[EV.EV_number(EV.EV_quantity)+1:EV.EV_number(EV.EV_quantity)+add_EV];
  
    
    
    EV.EV_charging_status=[EV.EV_charging_status new_EV_status];
    EV.EV_number=[EV.EV_number new_EV_number];
    EV.charging_time=[EV.charging_time new_EV_charging_time];
    EV.energy=[EV.energy new_EV_status];
    EV.EV_previous_setlevel_time=[EV.EV_previous_setlevel_time new_EV_setlevel_time];
    EV.EV_quantity=EV.EV_quantity+add_EV;
    
    EV_comp.EV_charging_status=[EV_comp.EV_charging_status new_EV_status];
    EV_comp.EV_number=[EV_comp.EV_number new_EV_number];
    EV_comp.charging_time=[EV_comp.charging_time new_EV_charging_time];
    EV_comp.energy=[EV_comp.energy new_EV_status];
    EV_comp.EV_previous_setlevel_time=[EV_comp.EV_previous_setlevel_time new_EV_setlevel_time];
    EV_comp.EV_quantity=EV_comp.EV_quantity+add_EV;
end

        
    
return
    
        

end

