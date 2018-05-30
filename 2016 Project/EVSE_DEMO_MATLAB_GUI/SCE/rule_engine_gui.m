%main function is 'simu_start_Callback'
function varargout = rule_engine_gui(varargin)
% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
'gui_Singleton',  gui_Singleton, ...
'gui_OpeningFcn', @rule_engine_gui_OpeningFcn, ...
'gui_OutputFcn',  @rule_engine_gui_OutputFcn, ...
'gui_LayoutFcn',  [] , ...
'gui_Callback',   []);
if nargin && ischar(varargin{1})
gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
[varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before rule_engine_gui is made visible.
function rule_engine_gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to rule_engine_gui (see VARARGIN)

global port;

% Choose default command line output for rule_engine_gui



port=serial('COM1')
set(port,'BaudRate',115200);
set(port,'Terminator','CR');

fopen(port);
assignin('base','port',port);






handles.output = hObject;
global new_EV;
new_EV=0;
global EV_string;
EV_string='1-9';
% Update handles structure
%xlabel(handles.axes1,'time: 5pm-8am');
ylabel(handles.axes1,'total power consumption');
title(handles.axes1,'Smart Charging');

title(handles.axes2,'Regular Charging');
%xlabel(handles.axes2,'time: 5pm-8am');
ylabel(handles.axes2,'total power consumption');


guidata(hObject, handles);

% UIWAIT makes rule_engine_gui wait for user response (see UIRESUME)
%uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = rule_engine_gui_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in simu_start.
function simu_start_Callback(hObject, eventdata, handles)
% hObject    handle to simu_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%{
fclose(port)
delete(port)
clear port
%}
clear_graph(handles);
global port

EV_quantity=str2num(get(handles.Intial_EV,'String'));
%power_utility=str2num(get(handles.available_power,'String'));
threshold_time=6;
one_hour=6;
season=get(handles.Threshold,'String');
field0 = 'EV_quantity'; value0 = EV_quantity;
field1 = 'EV_number'; value1 =[1:EV_quantity];
field2 = 'EV_charging_status'; value2 =zeros(1,EV_quantity);
field3 = 'charging_time';  value3 = zeros(1,EV_quantity);
field4 = 'energy';  value4 = zeros(1,EV_quantity);
field5 = 'EV_previous_setlevel_time';  value5 = zeros(1,EV_quantity);
%real_node_comm(0,1); 
%force the EV to charging state
%Note: prev set level time is absolute time and charging time is relative
%time. For example, if the simulator has run for 20s and the EV8 joined
%network at 16s. Then charging time is 4s and prev_set_level_time is 20s.
%The name is confusing because it is previously used for something else
%before I modify the code.

%preload data%
if strcmp(season,'Winter')==1
[num,txt,raw] = xlsread('AvailablePower.xls','C2:C25');
elseif strcmp(season,'Spring')==1
[num,txt,raw] = xlsread('AvailablePower.xls','C27:C50');
elseif strcmp(season,'Summer')==1
[num,txt,raw] = xlsread('AvailablePower.xls','C52:C75');
else
[num,txt,raw] = xlsread('AvailablePower.xls','C77:C100');
end
%*******************************************************************%

raw_data=cell2mat(raw)*1000*0.1/500;%only 10% is consumed by EV, scale down to 400 EV, scale factor is 500

global EV;
global wind_delta;

wind_delta=6000*(10.042*4+ 48.533)*1000*0.1/500;

global EV_string;
EV = struct(field0,value0,field1,value1,field2,value2,field3,value3,field4,value4,field5,value5);


EV_comp=EV; %comp means for comparison
global simu_time
simu_time=90;
global time_elapse
time_elapse=0;
counter=1;
global new_EV;
time_array=[];
power_consumption_array=[];
power_consumption_array_comp=[];
tic
while time_elapse<simu_time
 
toc
time_elapse=toc;
time_array=[time_array time_elapse]; %Optimaze this part. Concatenation inside loop is inefficient

pause(0.02);

while port.BytesAvailable~=0
    fgetl(port);
    pause(0.02);
end
fprintf(port,'$GS*BE'); %check real node state
real_node_check=fgetl(port);
while length(real_node_check)==4
    real_node_check=fgetl(port);
end
if (real_node_check(5)=='3') %!!!!!!!!!!!!!For testing purpose
    if (EV.EV_number(1)==1)
    %real node constructor%
    EV.EV_quantity=EV.EV_quantity+1;
    EV.EV_number=[0,EV.EV_number];
    EV.EV_previous_setlevel_time=[time_elapse,EV.EV_previous_setlevel_time];
    EV.EV_charging_status=[0,EV.EV_charging_status];
    EV.charging_time=[0,EV.charging_time];
    EV.energy=[0,EV.energy];
    end
end



%charging scheduling and store data for plotting%
index=floor(time_elapse/one_hour)+1;
%available_power=power_utility+raw_data(index);


[charging_car,total_power_consumption,EV.EV_charging_status,EV.EV_previous_setlevel_time]=smart_charging(EV.EV_previous_setlevel_time,EV.EV_quantity,EV.EV_number,EV.charging_time,EV.EV_charging_status,threshold_time,time_elapse,season,wind_delta);
%total_power_consumption=total_power_consumption-raw_data(index);
%net power load
real_node_comm(EV.EV_number(1),EV.EV_charging_status(1));

%disp(EV)
%disp(total_power_consumption)
[total_power_consumption_comp,EV_comp.EV_charging_status,EV_comp.EV_previous_setlevel_time]=dumb_charging(EV_comp.EV_previous_setlevel_time,EV_comp.EV_quantity,EV_comp.EV_number,EV_comp.charging_time,EV_comp.EV_charging_status,threshold_time,time_elapse);
%total_power_consumption_comp=total_power_consumption_comp-raw_data(index);
%disp(EV_comp)
%disp(total_power_consumption_comp)
power_consumption_array=[power_consumption_array total_power_consumption];
power_consumption_array_comp=[power_consumption_array_comp total_power_consumption_comp];
%real time plotting%
if length(time_array)>=2

plot(handles.axes1,[time_array(counter),time_array(counter+1)],[power_consumption_array(counter),power_consumption_array(counter+1)],'LineWidth',2);
axis(handles.axes1,[0 90 0 1.5*power_consumption_array(1)]);
%xlabel(handles.axes1,'time: 5pm-9am');
ylabel(handles.axes1,'Total power consumption');
title(handles.axes1,'Smart Charging');
%set(gca,'xtick',[]);
hold(handles.axes1,'on');


plot(handles.axes2,[time_array(counter),time_array(counter+1)],[power_consumption_array_comp(counter),power_consumption_array_comp(counter+1)],'LineWidth',2,'Color',[0,0.7,0.9]);
axis(handles.axes2,[0 90 0 1.5*power_consumption_array_comp(1)]);
%plot(new_time,new_power,new_time,new_power_comp,'LineWidth',2);
title(handles.axes2,'Regular Charging');
%xlabel(handles.axes2,'time: 5pm-9am');
ylabel(handles.axes2,'Total power consumption');
hold(handles.axes2,'on');

counter=counter+1;
end
%Plot EV_status on GUI

time_update(handles,time_elapse);
plot_EV_status(EV,EV_string,handles);


set(handles.Total_car,'String',EV.EV_quantity);
set(handles.total_charging_car,'String',charging_car);

pause(0.5);

%time_elapse=time_elapse+2;
time_elapse=toc;
%disp(toc)
%disp(time_elapse)

[EV,EV_comp]=smartnit_update(EV,EV_comp,time_elapse,new_EV);
new_EV=0;
end


%fclose(port)
%delete(port)
%clear port




plot(handles.axes1,time_array,power_consumption_array,'LineWidth',2);
xlabel(handles.axes1,'time')
ylabel(handles.axes1,'total power consumption')
title(handles.axes1,'Smart Charging')
plot(handles.axes2,time_array,power_consumption_array_comp,'LineWidth',2,'Color',[0,0.7,0.9]);
%plot(new_time,new_power,new_time,new_power_comp,'LineWidth',2);
title(handles.axes2,'Regular Charging')
xlabel(handles.axes2,'time')
ylabel(handles.axes2,'total power consumption')










function Intial_EV_Callback(hObject, eventdata, handles)
% hObject    handle to Intial_EV (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Intial_EV as text
%        str2double(get(hObject,'String')) returns contents of Intial_EV as a double


% --- Executes during object creation, after setting all properties.
function Intial_EV_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Intial_EV (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
set(hObject,'BackgroundColor','white');
end



function Threshold_Callback(hObject, eventdata, handles)
% hObject    handle to Threshold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Threshold as text
%        str2double(get(hObject,'String')) returns contents of Threshold as a double


% --- Executes during object creation, after setting all properties.
function Threshold_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Threshold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
set(hObject,'BackgroundColor','white');
end



function available_power_Callback(hObject, eventdata, handles)
% hObject    handle to available_power (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of available_power as text
%        str2double(get(hObject,'String')) returns contents of available_power as a double


% --- Executes during object creation, after setting all properties.
function available_power_CreateFcn(hObject, eventdata, handles)
% hObject    handle to available_power (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in confirm.
function confirm_Callback(hObject, eventdata, handles)
% hObject    handle to confirm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global new_EV;
new_EV=str2num(get(handles.add_new_ev,'String'));


function add_new_ev_Callback(hObject, eventdata, handles)
% hObject    handle to add_new_ev (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of add_new_ev as text
%        str2double(get(hObject,'String')) returns contents of add_new_ev as a double


% --- Executes during object creation, after setting all properties.
function add_new_ev_CreateFcn(hObject, eventdata, handles)
% hObject    handle to add_new_ev (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes1


% --- Executes during object creation, after setting all properties.
function text6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



function edit10_Callback(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit10 as text
%        str2double(get(hObject,'String')) returns contents of edit10 as a double


% --- Executes during object creation, after setting all properties.
function edit10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
set(hObject,'BackgroundColor','white');
end



function edit9_Callback(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit9 as text
%        str2double(get(hObject,'String')) returns contents of edit9 as a double


% --- Executes during object creation, after setting all properties.
function edit9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
set(hObject,'BackgroundColor','white');
end



function edit8_Callback(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit8 as text
%        str2double(get(hObject,'String')) returns contents of edit8 as a double


% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in checkbox2.
function checkbox2_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox2


% --- Executes during object deletion, before destroying properties.
function checkbox2_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to checkbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


function plot_EV_status( EV,string,handles )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
global port;
m=1;
while (string(m)~='-' && string(m)~=',')%find first '-' or ','
    if length(string)>=2
    m=m+1;
    
    else
        return
    end
    if m==length(string)
    %msgbox('Index too large!');
    return
    end
end

    
switch string(m)
%input is x-y
case '-'
start_point=str2num(string(1:m-1));
end_point=str2num(string(m+1:length(string)));
for i=start_point:start_point+8
%select charging state%
char2=int2str(i-start_point+1);
if i<=end_point
if i<=EV.EV_number(EV.EV_quantity) %car is in list
EV_exist=1;
car_number=strcat('car ',int2str(i));
if i~=0         %reqeust car is virtual node
    if EV.EV_number(1)==0     %if real node is in array car i is actually EV(i+1) because the number will start from 0
        j=i+1;
    else
        j=i;
    end
current=strcat(int2str((map_charging_level2power(EV.EV_charging_status(j)))/240),'A');
time=int2str(EV.charging_time(j));
    if EV.EV_charging_status(j)==4
        char3='4'; %4 means complete;eg tag c14 in gui, check last char
    elseif EV.EV_charging_status(j)==0

        char3='1';%1 means sleeping
    else
        char3='3'; %virtual node is always set to level 2, last tag char is 3; eg c13
    end
else
car_number=strcat('car ',int2str(i));
if EV.EV_number(1)~=0
    car_number='N/A';
    current='N/A';
    time='N/A';
    EV_exist=0;
else
    
    while port.BytesAvailable~=0
        fgetl(port);
        pause(0.01);
    end
    fprintf(port,'$GG*B2');
    out_string1=fgetl(port);
    while numel(out_string1)<7
        out_string1=fgetl(port);
    end
    pause(0.01);
    while port.BytesAvailable~=0
        fgetl(port);
        pause(0.01);
    end
    fprintf(port,'$GS*BE');
    out_string2=fgetl(port);
    while numel(out_string2)<7
        out_string2=fgetl(port);
    end
    pnt2=6;
    pnt1=6;
    while (out_string1(pnt1)~=' ') %find second ' ';
        pnt1=pnt1+1;
    end
    while (out_string2(pnt2)~=' ')
        pnt2=pnt2+1;
    end
    current=strcat(num2str((str2num(out_string1(5:pnt1-1)))/1000),'A');
    time=out_string2(pnt2+1:length(out_string2));%real node development
    if (strcmp(out_string2(5:7),'254'))   %sleeping
    char3='1';
    else %if not sleeping, charging, default L 1
    char3='2';
    end
end
end
else %car is not in the list
car_number='N/A';
current='N/A';
time='N/A';
EV_exist=0;
end
else %the rest part is not listed. For example, user type 1-3, then slots 4-9 is not listed and should be N/A
car_number='N/A';
current='N/A';
time='N/A';
EV_exist=0;
end

y1=strcat('c',char2,'1'); %tab for sleeping
y2=strcat('c',char2,'2'); %level 1
y3=strcat('c',char2,'3'); %level 2
y4=strcat('c',char2,'4'); %complete
y5=strcat('c',char2,'5'); %current
y6=strcat('c',char2,'6'); %time
z=strcat('c',char2);%car number


set(handles.(y1),'BackgroundColor',[0.941,0.941,0.941]); %clear previous draw
set(handles.(y2),'BackgroundColor',[0.941,0.941,0.941]);
set(handles.(y3),'BackgroundColor',[0.941,0.941,0.941]);
set(handles.(y4),'BackgroundColor',[0.941,0.941,0.941]);
if EV_exist==1
x=strcat('c',char2,char3);
set(handles.(x),'BackgroundColor',[0,1,0]); %set new color
end
set(handles.(z),'String',car_number); %update car number
set(handles.(y5),'String',current);
set(handles.(y6),'string',time);


end
case ','
left=1;
right=m-1;
    for i=1:9
    if m<length(string)
    number=str2num(string(left:right));
    elseif m==length(string)
    number=str2num(string(left:length(string)));
    m=m+1;
    else
    number=-1;
    end

    if number>0 && number<=EV.EV_number(EV.EV_quantity) %virtual node and is in list
        EV_exist=1;
        car_number=strcat('car ',int2str(number));
        if EV.EV_number(1)==0     %if real node is in array car i is actually EV(i+1) because the number will start from 0
        number=number+1;
        end

        current=strcat(int2str((map_charging_level2power(EV.EV_charging_status(number)))/240),'A');
        time=int2str(EV.charging_time(number));
        %get car charing status(level 1/2, complete, or sleeping)
        if EV.EV_charging_status(number)==4
        char3='4'; %4 means complete;eg tag c14 in gui, check last char
        elseif EV.EV_charging_status(number)==0

        char3='1';%1 means sleeping
        else
        char3='3'; %virtual node is always set to level 2, last tag char is 3; eg c13
        end

    elseif (( number>EV.EV_number(EV.EV_quantity)) || number==-1 || ((number==0)&&(EV.EV_number(1)~=0))) %virtual node not in the list or EV or real node not connected is N/A(eg.user type 3,12 car slots 3-9 is not used)
        EV_exist=0;
        car_number='N/A';
        current='N/A';
        time='N/A';
    elseif (number==0 && EV.EV_number(1)==0)
        EV_exist=1;
        car_number=strcat('car ',int2str(number));
        pause(0.01);
        while port.BytesAvailable~=0
            fgetl(port);
            pause(0.01);
        end
        fprintf(port,'$GG*B2');
        out_string1=fgetl(port);
        while numel(out_string1)<7
            out_string1=fgetl(port);
        end

        pause(0.01);
        while port.BytesAvailable~=0
            fgetl(port);
            pause(0.01);
        end
        fprintf(port,'$GS*BE');
        out_string2=fgetl(port);
        pause(0.01);
        while numel(out_string2)<7
            out_string2=fgetl(port);
            pause(0.01);
        end

    pnt2=6;
    pnt1=6;
    %disp(out_string1)
    %disp(out_string2)
    while (out_string1(pnt1)~=' ') %find second ' ';
    pnt1=pnt1+1;
    end
    while (out_string2(pnt2)~=' ')
    pnt2=pnt2+1;
    end
    current=strcat(num2str((str2num(out_string1(5:pnt1-1)))/1000),'A');
    time=out_string2(pnt2+1:length(out_string2));%real node development
    if (strcmp(out_string2(5:7),'254'))   %sleeping
    char3='1';
    else %if not sleeping, charging, default L 1
    char3='2';
    end

    end
    char2=int2str(i);
    y1=strcat('c',char2,'1'); %sleeping
    y2=strcat('c',char2,'2'); %level 1
    y3=strcat('c',char2,'3'); %level 2
    y4=strcat('c',char2,'4'); %complete
    y5=strcat('c',char2,'5'); %current
    y6=strcat('c',char2,'6'); %time
    z=strcat('c',char2);%car number


    set(handles.(y1),'BackgroundColor',[0.941,0.941,0.941]); %clear previous draw
    set(handles.(y2),'BackgroundColor',[0.941,0.941,0.941]);
    set(handles.(y3),'BackgroundColor',[0.941,0.941,0.941]);
    set(handles.(y4),'BackgroundColor',[0.941,0.941,0.941]);
    if EV_exist==1
    x=strcat('c',char2,char3);
    set(handles.(x),'BackgroundColor',[0,1,0]); %set new color
    end
    set(handles.(z),'String',car_number); %update car number
    set(handles.(y5),'String',current);
    set(handles.(y6),'string',time);

    m=m+1;
    left=m;

        while m<length(string) %check next ','
            if string(m)~=','
            m=m+1;

            else
            right=m-1;
            break;
            end

        end

    end

otherwise
msgbox('Illegal Index!');

end



function EV_selection_Callback(hObject, eventdata, handles)
% hObject    handle to EV_selection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EV_selection as text
%        str2double(get(hObject,'String')) returns contents of EV_selection as a double

% --- Executes during object creation, after setting all properties.
function EV_selection_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EV_selection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in change_EV.
function change_EV_Callback(hObject, eventdata, handles)
% hObject    handle to change_EV (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global EV_string;
global simu_time;
global time_elapse
global EV
EV_string=get(handles.EV_selection,'String');
if time_elapse>simu_time
    
    plot_EV_status(EV,EV_string,handles);
end


% --- Executes on slider movement.
function slider_Callback(hObject, eventdata, handles)
% hObject    handle to slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global wind_delta;


wind_delta=6000*10.042*get(handles.slider,'Value')*1000*0.1/500+6000*(10.042*4+ 48.533)*1000*0.1/500; %scale up by 5 since slider is range from 0-1 scale down to 10% and scale down by 500
disp('Wind is')
disp(wind_delta)
a=get(handles.slider,'Value');
disp('a is')
disp(a)

% --- Executes during object creation, after setting all properties.
function slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes during object creation, after setting all properties.
function Time_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
function time_update(handles,time_elapse)
    hour=floor(time_elapse/6);%1s=10 min
    minute=round((time_elapse-hour*6)*10);
    if hour>=7
        last_string='AM';
        hour=hour-7;
    else
        hour=hour+5;
        last_string='PM';
    end
    hour=int2str(hour);
    minute=int2str(minute);
    if length(minute)<2
        minute=strcat('0',minute);
    end
    set(handles.Time,'string',strcat(hour,':',minute,' ',last_string));

   

% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
h=msgbox({'               Team Member:';'Anthony Vu        anthov1@uci.edu';'Arnunav Singh     arunavs@uci.edu';'Hongnian Yu       hongniay@uci.edu';'Ming Wang        mingw3@uci.edu';' ';'               (c) Team HAM'} ,'About the Author')
function real_node_comm(number,status)
global port;
if (number==0)
pause(0.01);
switch status
    
case 0     %sleeping mode
while port.BytesAvailable~=0
    fgetl(port);
    pause(0.01);
end
fprintf(port,'$FS*BD');
pause(0.01);
while port.BytesAvailable~=0
    fgetl(port);
    pause(0.01);
end
for j=1:3
fprintf(port,'$FP 0 0 UtilityDisableEV!');
pause(0.01);
while port.BytesAvailable~=0
    fgetl(port);
    pause(0.01);
end
end
%%%%%%%%%%%ADD MESSAGE TO REMIND USER
case 1 %low current
while port.BytesAvailable~=0
    fgetl(port);
    pause(0.01);
end
fprintf(port,'$FE*AF');
pause(0.01);
while port.BytesAvailable~=0
    fgetl(port);
    pause(0.01);
end
fprintf(port,'$SC 6');
pause(0.01);
while port.BytesAvailable~=0
    fgetl(port);
    pause(0.01);
end
case 2
while port.BytesAvailable~=0
    fgetl(port);
    pause(0.01);
end
fprintf(port,'$FE*AF');
pause(0.01);
while port.BytesAvailable~=0
    fgetl(port);
    pause(0.01);
end
fprintf(port,'$SC 12');
pause(0.01);
while port.BytesAvailable~=0
    fgetl(port);
    pause(0.01);
end
case 3
while port.BytesAvailable~=0
    fgetl(port);
    pause(0.01);
end
fprintf(port,'$FE*AF');
pause(0.01);
while port.BytesAvailable~=0
    fgetl(port);
    pause(0.01);
end
fprintf(port,'$SC 10');
pause(0.01);
while port.BytesAvailable~=0
    fgetl(port);
    pause(0.01);
end
case 5
while port.BytesAvailable~=0
    fgetl(port);
    pause(0.01);
end
fprintf(port,'$FE*AF');
pause(0.01);
while port.BytesAvailable~=0
    fgetl(port);
    pause(0.01);
end
fprintf(port,'$SC 8');
pause(0.01);
while port.BytesAvailable~=0
    fgetl(port);
    pause(0.01);
end
case 6
while port.BytesAvailable~=0
    fgetl(port);
    pause(0.01);
end
fprintf(port,'$FE*AF');
pause(0.01);
while port.BytesAvailable~=0
    fgetl(port);
    pause(0.01);
end
fprintf(port,'$SC 7');
pause(0.01);
while port.BytesAvailable~=0
    fgetl(port);
    pause(0.01);
end
case 7
while port.BytesAvailable~=0
    fgetl(port);
    pause(0.01);
end
fprintf(port,'$FE*AF');
pause(0.01);
while port.BytesAvailable~=0
    fgetl(port);
    pause(0.01);
end
fprintf(port,'$SC 6');
pause(0.01);
while port.BytesAvailable~=0
    fgetl(port);
    pause(0.01);
end

case 8
while port.BytesAvailable~=0
    fgetl(port);
    pause(0.01);
end
fprintf(port,'$FE*AF');
pause(0.01);
while port.BytesAvailable~=0
    fgetl(port);
    pause(0.01);
end
fprintf(port,'$SC 9');
pause(0.01);
while port.BytesAvailable~=0
    fgetl(port);
    pause(0.01);
end
otherwise
msgbox('Illegal EV_state');
end
end


% --- Executes during object creation, after setting all properties.
function Total_car_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Total_car (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function total_charging_car_CreateFcn(hObject, eventdata, handles)
% hObject    handle to total_charging_car (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
function clear_graph(handles)
set(handles.EV_selection,'String','');
set(handles.add_new_ev,'String','');
cla(handles.axes1);
cla(handles.axes2);


% --- Executes when figure1 is resized.
function figure1_ResizeFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
