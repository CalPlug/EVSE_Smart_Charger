

void Init(J1772Pilot* Pilot) {
	
	TCCR1A = 0;  // set up Control Register A
	ICR1 = TOP;
	// WGM13 -> select P&F mode CS10 -> prescaler = 1
	TCCR1B = _BV(WGM13) | _BV(CS10);
 
#if (PILOT_IDX == 1) // PB1
	DDRB |= _BV(PORTB1);
	TCCR1A |= _BV(COM1A1);
#else // PB2
	DDRB |= _BV(PORTB2);
	TCCR1A |= _BV(COM1B1);
#endif // PILOT_IDX
#else // fast PWM

	// ********************************* fix for pin class!!! - Luis
	pin.init(PILOT_REG,PILOT_IDX,DigitalPin::OUT); 
	//****************************
#endif

	SetState(J1772Pilot* Pilot, PILOT_STATE_P12); // turns the pilot on 12V steady state
	
	// requires that the caller has a struct type J1772Pilot
	// this is only modifying its attributes
}

// no PWM pilot signal - steady state
// PILOT_STATE_P12 = steady +12V (EVSE_STATE_A - VEHICLE NOT CONNECTED)
// PILOT_STATE_N12 = steady -12V (EVSE_STATE_F - FAULT) 
void setState(J1772Pilot* Pilot, PILOT_STATE pstate){
	
	AutoCriticalSection asc; // figure out what this is - Luis
	
	if(pstate == PILOT_STATE_P12) {
#if (PILOT_IDX == 1)
		OCR1A = TOP;
#else
		OCR1B = TOP;
#endif
	}
	else {
#if (PILOT_IDX == 1) // PB1
    OCR1A = 0;
#else // PB2
    OCR1B = 0;
#endif
	}
#else // fast PWM
  TCCR1A = 0; //disable pwm by turning off COM1A1,COM1A0,COM1B1,COM1B0
  
  // **************** Fix for pin class! -Luis
  pin.write((state == PILOT_STATE_P12) ? 1 : 0);
  
  //**********************
#endif // PAFC_PWM

  Pilot->m_State = state;

}

// set EVSE current capacity in Amperes
// duty cycle 
// outputting a 1KHz square wave to digital pin 10 via Timer 1
//
int SetPWM(J1772Pilot* Pilot, int amps) {
#ifdef PAFC_PWM
  // duty cycle = OCR1A(B) / ICR1 * 100 %

  unsigned cnt;
  if ((amps >= 6) && (amps <= 51)) {
    // amps = (duty cycle %) X 0.6
    cnt = amps * (TOP/60);
  } else if ((amps > 51) && (amps <= 80)) {
    // amps = (duty cycle % - 64) X 2.5
    cnt = (amps * (TOP/250)) + (64*(TOP/100));
  }
  else {
    return 1;
  }

#if (PILOT_IDX == 1) // PB1
  OCR1A = cnt;
#else // PB2
  OCR1B = cnt;
#endif

  Pilot->m_State = PILOT_STATE_PWM;

  return 0;
#else // fast PWM
  uint8_t ocr1b = 0;
  if ((amps >= 6) && (amps <= 51)) {
    ocr1b = 25 * amps / 6 - 1;  // J1772 states "Available current = (duty cycle %) X 0.6"
  } else if ((amps > 51) && (amps <= 80)) {
    ocr1b = amps + 159;  // J1772 states "Available current = (duty cycle % - 64) X 2.5"
  }
  else {
    return 1; // error
  }

  if (ocr1b) {
    AutoCriticalSection asc;
    // Timer1 initialization:
    // 16MHz / 64 / (OCR1A+1) / 2 on digital 9
    // 16MHz / 64 / (OCR1A+1) on digital 10
    // 1KHz variable duty cycle on digital 10, 500Hz fixed 50% on digital 9
    // pin 10 duty cycle = (OCR1B+1)/(OCR1A+1)

    TCCR1A = _BV(COM1A0) | _BV(COM1B1) | _BV(WGM11) | _BV(WGM10);
    TCCR1B = _BV(WGM13) | _BV(WGM12) | _BV(CS11) | _BV(CS10);
    OCR1A = 249;

    // 10% = 24 , 96% = 239
    OCR1B = ocr1b;

    Pilot->m_State = PILOT_STATE_PWM;
	return 0;
  }
  else { 
  // !duty
    // invalid amps
    return 1;
  }
#endif // PAFC_PWM
}