#include <stdio.h>
#include <stdlib.h>

void Initialize();

int main(){
	
	
	
	
}

int Set_State(int Pilot_High, int Pilot_Low)
{
char state; 

switch(state){
	
	case 'A': //not connected 
	Pilot_High = 12;
	Pilot_Low = 12;
	break;
	
	case 'B': //ev connected and ready 
	Pilot_High = 9;
	Pilot_Low = -12;
	break;
	
	case 'C': //ev charge 
	Pilot_High = 6;
	Pilot_Low = -12;
	break;
	 
	case 'D': //ev charge
	Pilot_High = 3;
	Pilot_Low = -12;
	break;
	
	case 'E': //error
	Pilot_High = 0;
	Pilot_Low = 0;
	break;
	
	case 'F': // unknown error
	Pilot_High = -12;
	Pilot_Low = -12;
	break;
	
	default: 
	printf("error");
	
}

if (state == 'A'){
	setrelay();

}