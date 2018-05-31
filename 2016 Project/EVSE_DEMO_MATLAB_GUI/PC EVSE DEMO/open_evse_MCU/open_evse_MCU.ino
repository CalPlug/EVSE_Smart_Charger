
#include <ESP8266WiFi.h>
#include <PubSubClient.h>
#include <assert.h>


String StartCharge;
String StopCharge;
String ReadCurrent;
String SetCurrent;
String LevelCheck;
String ReadStatus;

String StatusCharging;
String StatusChargingStopped;

char ok[10];
int correct;
char temp[50];

//CALPLUG WIFI
const char* ssid = "CalPlugIoT";
const char* password = "A8E61C58F8";

const char* mqtt_server = "m10.cloudmqtt.com";


WiFiClient espClient;
PubSubClient client(espClient);

long lastMsg = 0;
char msg[50];
int value = 0;
boolean charge, notCharge, readCurr, setCurr, levCheck, readStat;


int incomingByte, incomingByte_2, incomingByte_3, incomingByte_4, incomingByte_5, incomingByte_6, incomingByte_7;
char rsp_charge[50];
char rsp_notCharge[50];
char rsp_setCurr[50];
char rsp_readCurr[50];
char rsp_levCheck[50];
char rsp_levCheck2[50];
char rsp_readStat[50];
char rsp_readEnergyCurr[50];

int buff_max = 50;


/* ------------ START TEMPORARY STUFF ------------ */

/* defining our map and nodes  */
typedef struct NODE Part;
typedef struct LIST Map;

Map *NewInputResponse(void);
Part *NewPart(char command[10] );
void AppendCommand(Map *desigmapp, char command[10]);
void DeleteInputResponse(Map *mapp);
Part *DeletePart(Part *part);
void *MoveNext(Part *part);


struct NODE {
  Map *mapp;
  Part *next;
  char command[15];
};


struct LIST {

  int length_map;
  Part *first;
  Part *last;
};


Map *CommandLine = NULL;
char CommandPart[15];
char Cleaning[15];
char EnergyValue[10];
char EnergyValue2[10];
char CurrentValue[10];
int energy_delay = 0;
int count_rsp = 0, counter, dollar_flag = 0, clearing, y = 0;
char charge_started[50] = "Charge Started";
char not_charge_started[50] = "Charge Start Fail";
char charge_stopped[50] = "Charge Stopped";
char not_charge_stopped[50] = "Charge Stop Fail";
char sc[10];


/* ------------ END TEMPORARY STUFF ------------ */



void setup_wifi() { //because it needs wifi to connect to

  delay(10);
  //Serial.println();
  //Serial.print("Connecting to ");
  //Serial.println(ssid);

  WiFi.begin(ssid, password);

  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    //Serial.print(".");
  }

  //Serial.println("");
  //Serial.println("WiFi connected");
  //Serial.println("IP address: ");
  //Serial.println(WiFi.localIP());
}

void callback(char* topic, byte* payload, unsigned int length1) {
  int t = 0;
  int r = 0;
  int m = 0;
  int z = 0;
  int w = 0;
  int l = 0;
  int a, b, c, d, e, f, g, h, i, j, n = 0;
  int countbits1, countbits2, countbits3, countbits4, countbits5, countbits6, countbits7, countbits8 = 0;
  int countbitsA, countbitsB, countbitsC, countbitsD, countbitsE, countbitsF, countbitsG, countbitsH, countbitsI, countbitsJ = 0;
  int amtOfBits = 20;
  int current;
  int FirstSpace = 0, SecondSpace = 0;
  int levCheck_Counter=0; 

  /* Start Charge */

  for (int i = 0; i < StartCharge.length(); i++) {
    if ((char)payload[i] == StartCharge[i]) {
      t++;
    }
  }

  if (t == StartCharge.length()) {
    Serial.print("$FE*AF\r"); //what we write out
    delay(500);

    charge = true;

    /* This is for checking all the bytes until you cant read anymore, amtOfBits is the amount of bits*/
    for (countbits1 = 0; (Serial.available() > 0); countbits1++) {
      rsp_charge[countbits1] = (char)Serial.read(); // Putting response into an array to be sent to cloud

    }
    rsp_charge[countbits1] = '$'; //Setting last value to null
    delay(500);
  
    /* Putting all dollar sign responses into a linked list */

    //PARSER
    dollar_flag = 0;
    count_rsp = 0;
    
    while ((countbits1 - count_rsp + 1) > 0) {
      if (rsp_charge[count_rsp] == '$') {
        dollar_flag++;
        counter = -1;
        count_rsp++;
      }

      if (dollar_flag == 1) { /*First instance of $ sign*/
        counter++;        
        CommandPart[counter] = rsp_charge[count_rsp];
        count_rsp++;
      }

      if (dollar_flag == 2) { /*Append to linked list after it sees the next dollar sign*/
        delay(500);
        AppendCommand(CommandLine, CommandPart);
        delay(500);
        for (clearing = 0; clearing < 15; clearing++) { /*Clear array for next command*/
          CommandPart[clearing] = Cleaning[clearing];
        }
        dollar_flag--;
      }
    } //End of While Loop
  }

/* END OF START CHARGE */

  /* STOP CHARGE */

  for (int i = 0; i < StopCharge.length(); i++) {
    if ((char)payload[i] == StopCharge[i]) {
      r++;
    }
  }

  if (r == StopCharge.length()) {
    Serial.print("$FS*BD\r"); //what we write out
    delay(500);
    
    notCharge = true;

    /* This is for checking all the bytes until you cant read anymore, amtOfBits is the amount of bits*/
    for (countbits2 = 0; (Serial.available() > 0); countbits2++) {
      rsp_notCharge[countbits2] = (char)Serial.read(); // Putting response into an array to be sent to cloud

    }
    rsp_notCharge[countbits2] = '$'; //Setting last value to null
    delay(500);

    //PARSER

    count_rsp = 0;
    dollar_flag = 0;
    
    while ((countbits2 - count_rsp + 1) > 0) {
      if (rsp_notCharge[count_rsp] == '$') {
        dollar_flag++;
        counter = -1;
        count_rsp++;
      }

      if (dollar_flag == 1) { /*First instance of $ sign*/
        counter++;        
        CommandPart[counter] = rsp_notCharge[count_rsp];
        count_rsp++;


      }

      if (dollar_flag == 2) { /*Append to linked list after it sees the next dollar sign*/
        delay(500);
        AppendCommand(CommandLine, CommandPart);
        delay(500);
        for (clearing = 0; clearing < 15; clearing++) { /*Clear array for next command*/
          CommandPart[clearing] = Cleaning[clearing];
        }
        dollar_flag--;
      }
    } //End of While Loop

  }

  /* END OF STOP CHARGE */

/* SET CURRENT */
  
  for (int i = 0; i < SetCurrent.length(); i++) {
    if ((char)payload[i] == SetCurrent[i]) {
      z++;
    }
  }
  
  if (z == 11) {
    char sc[10]; //ONLY WORKS FOR 2 DIGITS, FIX
    sc[0] = '$';
    sc[1] = 'S';
    sc[2] = 'C';
    sc[3] = ' ';
    sc[4] = (char)payload[12];
    sc[5] = (char)payload[13];
    sc[6] = '\r';
    Serial.print(sc); //what we write out
    delay(500);


    setCurr = true;

    /* This is for checking all the bytes until you cant read anymore, amtOfBits is the amount of bits*/
    for (countbits4 = 0; (Serial.available() > 0); countbits4++) {
      rsp_setCurr[countbits4] = (char)Serial.read(); // Putting response into an array to be sent to cloud

    }
    rsp_setCurr[countbits4] = '$'; //Setting last value to null
    delay(500);
  
  
    //PARSER
    dollar_flag = 0;
    count_rsp = 0;
    while ((countbits4 - count_rsp + 1) > 0) {
      if (rsp_charge[count_rsp] == '$') {
      dollar_flag++;
      counter = -1;
      count_rsp++;
      }

      if (dollar_flag == 1) { /*First instance of $ sign*/
        counter++;        
        CommandPart[counter] = rsp_charge[count_rsp];
        count_rsp++;
      }

      if (dollar_flag == 2) { /*Append to linked list after it sees the next dollar sign*/
        delay(500);
        AppendCommand(CommandLine, CommandPart);
        delay(500);
        for (clearing = 0; clearing < 15; clearing++) { /*Clear array for next command*/
          CommandPart[clearing] = Cleaning[clearing];
        }
        dollar_flag--;
      }
    } //End of While Loop

  }
  
  /* END OF SET CURRENT */

/* Read Current */
  for (int i = 0; i < ReadCurrent.length(); i++){
    if((char)payload[i] == ReadCurrent[i]){
      m++;
    }
  }

   if (m == ReadCurrent.length()){
    Serial.print("$GG*B2\r");
    delay(500);
    
    readCurr = true;
    
    for (countbits3 = 0; (Serial.available() > 0); countbits3++) {
      rsp_readCurr[countbits3] = (char)Serial.read();
      
    }
    rsp_readCurr[countbits3] = '$'; //Setting last value to null
    delay(500);
  
      /* Putting all dollar sign responses into a linked list */
    //PARSER
    y = 0;
    count_rsp = 0;
    dollar_flag = 0;
    while ((countbits3 - count_rsp + 1) > 0) {
      if (rsp_readCurr[count_rsp] == '$') {
        dollar_flag++;
        counter = -1;
        count_rsp++;
      }

      if (dollar_flag == 1) { /*First instance of $ sign*/
        counter++;        
        CommandPart[counter] = rsp_readCurr[count_rsp];
        count_rsp++;
      }

      if (dollar_flag == 2) { /*Append to linked list after it sees the next dollar sign*/
        delay(500);
        AppendCommand(CommandLine, CommandPart);
        delay(500);
        for (clearing = 0; clearing < 15; clearing++) { /*Clear array for next command*/
          CommandPart[clearing] = Cleaning[clearing];
        }
        dollar_flag--;
      }
    } //End of While Loop
   }//End of if

/*End of Read Current*/


/*Level Check */
for(int i= 0; i< LevelCheck.length(); i++) {
  if((char)payload[i] == LevelCheck[i]) {
  l++;
  }
}

if(l==LevelCheck.length()) {
  Serial.print("$GU*CO\r"); //what we write out
  delay(500);
  
  levCheck = true;

for (countbits6 = 0; (Serial.available() > 0); countbits6++) {
      rsp_levCheck[countbits6] = (char)Serial.read(); // Putting response into an array to be sent to cloud

    }
    rsp_levCheck[countbits6] = '$'; //Setting last value to null
    delay(500); 

    //parser
    y=0;
    count_rsp = 0;
    dollar_flag = 0;
    
    while ((countbits6 - count_rsp + 1) > 0) {
      if (rsp_levCheck[count_rsp] == '$') {
        dollar_flag++;
        counter = -1;
        count_rsp++;
      }

      if (dollar_flag == 1) { /*First instance of $ sign*/
        counter++;        
        CommandPart[counter] = rsp_levCheck[count_rsp];
        count_rsp++;
        }

      if (dollar_flag == 2) { /*Append to linked list after it sees the next dollar sign*/
        delay(500);
        AppendCommand(CommandLine, CommandPart);
        delay(500);
        
        for (clearing = 0; clearing < 15; clearing++) { /*Clear array for next command*/
          CommandPart[clearing] = Cleaning[clearing];
        }
        dollar_flag--;
      }
   } //end of while

   
for(int i=0; i<10; i++) {
  EnergyValue[i] = Cleaning[i];
}

FirstSpace = 0; SecondSpace = 0;

   /*Parsing the spaces*/
     for(int x=0; x<10; x++){ 
 
      if (SecondSpace == 1){
        if(CommandLine -> first -> command[x]== ' '){
          SecondSpace = x;
        }
      }

    if(FirstSpace == 0){ 
      if (CommandLine -> first -> command[x]== ' '){
        FirstSpace = x;
        SecondSpace = 1;
      }
     }
     
   } 

for(int x= FirstSpace+1; x< SecondSpace; ++x) {
  EnergyValue[y] = CommandLine -> first -> command[x];
  //sprintf(temp,"%c", EnergyValue[y]);
  //client.publish("topic/EVSE/response/test", temp);
  y++;
 }

//CurrentValue holds the current energy
DeleteInputResponse(CommandLine);

//FINISH GETTING 1st ENERGY LEVEL

 Serial.print("$GU*CO\r"); //what we write out
  delay(500);
  
for (countbits8 = 0; (Serial.available() > 0); countbits8++) {
      rsp_levCheck2[countbits8] = (char)Serial.read(); // Putting response into an array to be sent to cloud

    }
    rsp_levCheck2[countbits8] = '$'; //Setting last value to null
    delay(500); 

    //parser
    y = 0;
    count_rsp = 0;
    dollar_flag = 0;
 
    while ((countbits8 - count_rsp + 1) > 0) {
      if (rsp_levCheck2[count_rsp] == '$') {
        dollar_flag++;
        counter = -1;
        count_rsp++;
      }

      if (dollar_flag == 1) { /*First instance of $ sign*/
        counter++;        
        CommandPart[counter] = rsp_levCheck2[count_rsp];
        count_rsp++;
        }

      if (dollar_flag == 2) { /*Append to linked list after it sees the next dollar sign*/
        delay(500);
        AppendCommand(CommandLine, CommandPart);
        delay(500);
        
        for (clearing = 0; clearing < 15; clearing++) { /*Clear array for next command*/
          CommandPart[clearing] = Cleaning[clearing];
        }
        dollar_flag--;
      }
   } //end of while

   
for(int i=0; i<10; i++) {
  EnergyValue2[i] = Cleaning[i];
}

FirstSpace = 0; SecondSpace = 0;

   /*Parsing the spaces*/
   for(int x=0; x<10; x++){ 
 
      if (SecondSpace == 1){
        if(CommandLine -> first -> command[x]== ' '){
          SecondSpace = x;
        }
      }

    if(FirstSpace == 0){ 
      if (CommandLine -> first -> command[x]== ' '){
        FirstSpace = x;
        SecondSpace = 1;
      }
     }
   } 


for(int x= FirstSpace+1; x< SecondSpace; ++x) {
  EnergyValue2[y] = CommandLine -> first -> command[x];
  y++;
 }

 
//CurrentValue holds the current energy
DeleteInputResponse(CommandLine);

//FINISH GETTING 2nd ENERGY LEVEL
Serial.print("$GG*B2\r");
energy_delay = 2000;//2.0 seconds
delay(500);

for (countbits7 = 0; (Serial.available() > 0); countbits7++) {
      rsp_readEnergyCurr[countbits7] = (char)Serial.read();
      
    }
    rsp_readEnergyCurr[countbits7] = '$'; //Setting last value to null
    delay(500);
    
  
      /* Putting all dollar sign responses into a linked list */
    
    //PARSER
    y=0;
    count_rsp = 0;
    dollar_flag = 0;
    while ((countbits7 - count_rsp + 1) > 0) {
      if (rsp_readEnergyCurr[count_rsp] == '$') {
        dollar_flag++;
        counter = -1;
        count_rsp++;
      }

      if (dollar_flag == 1) { /*First instance of $ sign*/
        counter++;        
        CommandPart[counter] = rsp_readEnergyCurr[count_rsp];
        count_rsp++;
      }

      if (dollar_flag == 2) { /*Append to linked list after it sees the next dollar sign*/
        delay(500); 
        AppendCommand(CommandLine, CommandPart);
        delay(500);
        for (clearing = 0; clearing < 15; clearing++) { /*Clear array for next command*/
          CommandPart[clearing] = Cleaning[clearing];
        }
        dollar_flag--;
      }
    }

    for(int i=0; i<10; i++) {
  CurrentValue[i] = Cleaning[i];
}

FirstSpace = 0; SecondSpace = 0;

   /*Parsing the spaces*/
   for(int x=0; x<10; x++){ 
 
      if (SecondSpace == 1){
        if(CommandLine -> first -> command[x]== ' '){
          SecondSpace = x;
        }
      }

    if(FirstSpace == 0){ 
      if (CommandLine -> first -> command[x]== ' '){
        FirstSpace = x;
        SecondSpace = 1;
      }
     }
     
   } 
  
for(int x= FirstSpace+1; x< SecondSpace; ++x) {
  CurrentValue[y] = CommandLine -> first -> command[x];  
  y++;
 }  
}//end of whole if
//END OF LEVEL CHECK


/* READ STATUS */
for (int i = 0; i < ReadStatus.length(); i++){
    if((char)payload[i] == ReadStatus[i]){
      w++;
    }
  }


   if (w == ReadStatus.length()){
    Serial.print("$GS*BE\r");
    delay(500);
    
    readStat = true;
    
    for (countbits5 = 0; (Serial.available() > 0); countbits5++) {
      rsp_readStat[countbits5] = (char)Serial.read();
      
    }
    rsp_readStat[countbits5] = '$'; //Setting last value to null
    delay(500);

    //PARSER

    count_rsp = 0;
    dollar_flag = 0;
    
    while ((countbits5 - count_rsp + 1) > 0) {
      if (rsp_readStat[count_rsp] == '$') {
        dollar_flag++;
        counter = -1;
        count_rsp++;
      }

      if (dollar_flag == 1) { /*First instance of $ sign*/
        counter++;        
        CommandPart[counter] = rsp_readStat[count_rsp];
        count_rsp++;
      }

      if (dollar_flag == 2) { /*Append to linked list after it sees the next dollar sign*/
        delay(500);
        AppendCommand(CommandLine, CommandPart);
        delay(500);
        for (clearing = 0; clearing < countbits5; clearing++) { /*Clear array for next command*/
          CommandPart[clearing] = 1;
        }
        dollar_flag--;
      }
    } //End of While Loop

  }

/* END OF READ STATUS */
  
}  /*end of callback*/


void reconnect() {
  while (!client.connected()) {
    //Serial.print("Attempting a conenection to MQTT...");

    if (client.connect("ESP8266Client", "nszhdozp", "TmWGEn_f3Ebp")) {
      //Serial.println("connected");
      client.publish("topic/EVSE/response/test", "publishing-yes"); // what are we publishing?
      client.subscribe("topic/EVSE");
    } else {
      //Serial.print("failed, rc=");
      //Serial.print(client.state());
      //Serial.println(" will try connecting again in 5 secs");
      delay(5000);
    }
  }
}

void setup() {
  // Open serial communications and wait for port to open:
  Serial.begin(115200);
  setup_wifi();
  client.setServer(mqtt_server, 12613); // sets up our MQTT server
  client.setCallback(callback);

  CommandLine = NewInputResponse();

  StartCharge = "start_charge"; //what we get from mqtt
  StopCharge = "stop_charge";
  ReadCurrent = "get_current";

  SetCurrent = "set_current";
  ReadStatus = "get_status";
  LevelCheck = "get_level";


  charge = false;
  notCharge = false;
  readCurr = false;

  setCurr = false;
  readStat = false;
  levCheck = false;

  correct= 0;
  ok[0] = 'O';
  ok[1] = 'K';
  ok[2] = 'a';
  ok[3] = 'a';
  ok[4] = 'a';
  ok[5] = 'a';
  ok[6] = 'a';
  ok[7] = 'a';
  ok[8] = 'a';
  ok[9] = 'a';


}

void loop() { // run over and over
  //Serial.print("$FE*AF\r");
  //delay(10000);
  //Serial.print("$FS*BD\r");
  //delay(10000);
  if (!client.connected()) {
    reconnect();
  }
  client.loop();



  long now = millis();
  if (now - lastMsg > 2000) {
    lastMsg = now;
  }

  /* Pushing response back to cloudmqtt, response is sent to topic/EVSE/response channel */

  //start charge response
  
  if (charge) {
  while(correct != 2) {

   for (int x = 0; x < 10; x++) {
      if (CommandLine -> first -> command[x] == ok[x]){
         correct++;
      }
   }    
      if(correct == 2) {
        client.publish("topic/EVSE/response", charge_started);
      }
      else {
        if(CommandLine -> first -> next != NULL) {
          MoveNext(CommandLine -> first);
          correct = 0;
        }
        else {
          client.publish("topic/EVSE/response", not_charge_started);
          correct = 2;
        }
      }
  }
  charge = false;
  correct = 0;
  DeleteInputResponse(CommandLine);
}

/* END OF START CHARGE RESPONSE */

/* STOP CHARGE RESPONSE */

  if (notCharge) {
  while(correct != 2) {

   for (int x = 0; x < 10; x++) {
      if (CommandLine -> first -> command[x] == ok[x]){
         correct++;
      }
    }    
    if(correct == 2) {
      client.publish("topic/EVSE/response", charge_stopped);
    }
      else {
        if(CommandLine -> first -> next != NULL) {
          MoveNext(CommandLine -> first);
          correct = 0;
        }
        else {
          client.publish("topic/EVSE/response", not_charge_stopped);
          correct = 2;
        }
      }
  }
    notCharge = false;
    correct = 0;
    DeleteInputResponse(CommandLine);
  }

/* END OF STOP CHARGE RESPONSE */

/* SET CURRENT RESPONSE */
  if(setCurr) {
    char Currentz[30] = "Current Set to ";
    Currentz[15] = sc[4];
    Currentz[16] = sc[5];
    
    while(correct != 2) {

      for (int x = 0; x < 10; x++) {
        if (CommandLine -> first -> command[x] == ok[x]){
        correct++;
        }
      }    
      if(correct == 2) {
        client.publish("topic/EVSE/response", Currentz);
      }
      else {
        if(CommandLine -> first -> next != NULL) {
          MoveNext(CommandLine -> first);
          correct = 0;
        }
        else {
          client.publish("topic/EVSE/response", "Current Set Failed");
          correct = 2;
        }
      }
    }
  setCurr = false;
  correct = 0;
  for(int i = 0; i<10; i++) {
    sc[i] = Cleaning[i];
  }
  DeleteInputResponse(CommandLine);
  }

/* END SET CURRENT RESPONSE */

/*Read Current Response*/
  if (readCurr) {
   int FirstSpace = 0, SecondSpace = 0;
   int Current_Counter=0; 

   for(int i=0; i<10;i++) {
    CurrentValue[i] = Cleaning[i];
   }
   
//ONLY LOOKS AT FIRST PART
   /*Parsing the spaces*/
   for(int x=0; x<10; x++){ 
 
      if (SecondSpace == 1){
        if(CommandLine -> first -> command[x]== ' '){
          SecondSpace = x;
        }
      }

    if(FirstSpace == 0){ 
      if (CommandLine -> first -> command[x]== ' '){
        FirstSpace = x;
        SecondSpace = 1;
      }
     }
     
   } 
        
   for(int x = FirstSpace+1; x < SecondSpace; ++x){
    CurrentValue[y]= CommandLine -> first -> command[x];
    y++;
   }

    CurrentValue[y] = ' ';
    CurrentValue[y + 1] = 'm';
    CurrentValue[y + 2] = 'A';

    client.publish("topic/EVSE/response", CurrentValue);
    
    readCurr = false;
    DeleteInputResponse(CommandLine);
  }
/*End of Read Current Response*/

/*Level Check Response*/
if(levCheck) {
  float ev_1 = 0;
  float ev_2 = 0;
  float cv_1 = 0;
  float FinalLevel;
  char Current_fv[10];

  ev_1 = atof(EnergyValue);
  ev_2 = atof(EnergyValue2);
  cv_1 = atof(CurrentValue);
   
  cv_1 = cv_1 / 1000;
  energy_delay = energy_delay/1000;

  FinalLevel = (ev_2 - ev_1)/(cv_1 * energy_delay); 
  
  //sprintf(Current_fv,"%f", FinalLevel); 
  //client.publish("topic/EVSE/response/test", Current_fv);

if(FinalLevel < 180 ) {
  client.publish("topic/EVSE/response", "Charging at Level 1");
}
 else if(FinalLevel> 180) {
  client.publish("topic/EVSE/response", "Charging at Level 2");
 }
     else{
    client.publish("topic/EVSE/response", "System Error");
    }

  levCheck = false;
  
  DeleteInputResponse(CommandLine);
} 
/*END OF LEVEL CHECK RESPONSE*/

/* GET STATUS RESPONSE */
 if (readStat) {
   int FirstSpace = 0, SecondSpace = 0;
   int Current_Counter=0; 
   char CurrentValue[10];
   char CurrentString[10];
   int y=0;
   for(int i=0; i<10;i++) {
    CurrentValue[i] = Cleaning[i];
   }

  for(int x=0; x<10; x++){ 
 
      if (SecondSpace == 1){
        if(CommandLine -> first -> command[x]== ' '){
          SecondSpace = x;
        }
      }

    if(FirstSpace == 0){ 
      if (CommandLine -> first -> command[x]== ' '){
        FirstSpace = x;
        SecondSpace = 1;
      }
     }
     
   } 

   for(int x = FirstSpace+1; x < SecondSpace; ++x){
    CurrentValue[y]= CommandLine -> first -> command[x];
    y++;
   }

   int cv = 0;
   cv = atoi(CurrentValue);
        
    if(cv == 1) {
      client.publish("topic/EVSE/response", "Ready State");
    }
    else if(cv == 2) {
      client.publish("topic/EVSE/response", "Connected State");
    }
    else if(cv == 3) {
      client.publish("topic/EVSE/response", "Charging State");
    }
    else if(cv == 254) {
      client.publish("topic/EVSE/response", "Sleep State");
    }
    else if(cv == 255) {
      client.publish("topic/EVSE/response", "Disabled State");
    }
    else {
      client.publish("topic/EVSE/response", "Unknown Error -- Get State");
    }
    readStat = false;
    DeleteInputResponse(CommandLine);
  }

  /* END OF GET STATUS RESPONSE */

}

  

/* allocate a new student list */
Map *NewInputResponse(void)
{
  Map *mapp;
  mapp = (Map *) malloc(sizeof(Map));
  assert(mapp);
  mapp->length_map = 0;
  mapp->first = NULL;
  return mapp;
}

/* create new node for a student */
Part *NewPart(char command[10] ) {
  assert(command);
  Part *part;
  part = (Part *) malloc(sizeof(Part));
  assert(part);
  part->mapp = NULL;
  part->next = NULL;
  strncpy(part->command, command, 10);
  return part;
}

/* append a student at end of list */
void AppendCommand(Map *desigmapp, char command[10]) {
  assert(desigmapp);
  assert(command);
  //client.publish("topic/EVSE/responsetest","In Append");
  
  Part *part = NewPart(command);
  //client.publish("topic/EVSE/responsetest","Part Made");
  part-> mapp = desigmapp;
  //client.publish("topic/EVSE/responsetest","Map Assigned");

  
  //sprintf(temp,"%d",desigmapp->length_map);
  //client.publish("topic/EVSE/responsetest",temp);
  
  if (desigmapp-> length_map != 0) {
    //client.publish("topic/EVSE/responsetest","Begin Second Append");
    desigmapp->last->next = part;
    desigmapp->last = part;
    //client.publish("topic/EVSE/responsetest","Finish Second Append");
  }
  else {
    //client.publish("topic/EVSE/responsetest","In Else Append");
    desigmapp->first = part;
    desigmapp->last = part;
  }

  desigmapp->length_map++;
  //sprintf(temp,"%d",desigmapp->length_map);
  //client.publish("topic/EVSE/responsetest",temp);
  
}



/* deletes input response (and all entries) */
void DeleteInputResponse(Map *mapp) {
  assert(mapp);
  Part *part = mapp -> first;
  while (part) {
    Part *next = part -> next;
    DeletePart(part);
    part = next;
    mapp->length_map--;
  }
  free(part); //potential error
  if(mapp->length_map > 0){
    DeleteInputResponse(mapp);
  }
  //sprintf(temp,"%d",mapp->length_map);
  //client.publish("topic/EVSE/responsetest",temp);
  
} 

/* delete a node and its data (part) */
Part *DeletePart(Part *part) {
  assert(part);
  assert(part -> command);
  free(part);
}

void *MoveNext(Part *part) {
  assert(part);
  assert(part -> command);
  part -> mapp -> first = part -> next;
  free(part);
}


