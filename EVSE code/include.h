#include <stdint.h>

typedef struct {
	int status;
	string MQTT_sub;
} ESP8266;

typedef struct {
	// LEDS??? O_O_O_O_O_O_O_O_O_O_O_O_O_O
} LED;

typedef struct {
	int pwm_high, pwm_low;
	LED led;
	string MQTT_message;
	char state;
	bool relay1, relay2;	
	bool lvl_1, lvl_2;
} ChargeState;

void Set_State(ChargeState* charge, char state);

void LevelDetection(ChargeState* charge);

void groundfaultinterrupt(void);

void read4relay(void); // reads level for charging

void setRelay(ChargeState* charge); // sets the relays
/* 
0 both off
1 level 1
2 level 2
else both off 
to send 

0 failure
1 success
to receive 
*/
int ESP8266setup(ESP8266* client);
/*
1 failure
0 success
*/
int getMQTTData(ESP8266* client);

void sendMQTTData(ESP8266* client);


void readWattmeterSPI(void);

int initilizeLED(void);

void Initialize(void);

void readPilot(ChargeState* charge);
