typedef enum{ 
	PILOT_STATE_P12, PILOT_STATE_PWM, PILOT_STATE_N12
}
PILOT_STATE;

typedef struct { 
	PILOT_STATE m_State;
	DigitalPin pin;
} J1772Pilot ;

void Init();

void SetState(J1772Pilot* Pilot, PILOT_STATE pstate);

PILOT_STATE GetState(J1772Pilot* Pilot);

int SetPWM(J1772Pilot* Pilot, int amps);



