  //br = split(ans, " ");
  
  if (br[0].equals("$OK")) {
    ans = "$OK " + br[1];
    if(Integer.parseInt(br[1]) == 1) {
             EVSE_STATE = 1;
             translation = "Ready State"; 
         } else if(Integer.parseInt(br[1]) == 2) {
             EVSE_STATE = 2;
            translation = "Connected State";
         } else if(Integer.parseInt(br[1]) == 3) {
             EVSE_STATE = 3;
             translation = "Charging State";
         } else if(Integer.parseInt(br[1]) == 254) {
             EVSE_STATE = 254;
             translation = "Sleep State";
         } else if(Integer.parseInt(br[1]) == 255) {
            EVSE_STATE = 255;
             translation = "Disabled State";
         } else {
             translation = "Unknown Error -- Get State";
         }
  } else if (br[0].equals("$NK")) {
    ans = "$NK";
  } else {
    ans = "";
  }  

#include <ESP8266WiFi.h>
#include <PubSubClient.h>

String StartCharge;
String StopCharge;
String ReadCurrent;
String SetCurrent;
String LevelCheck;
String ReadStatus;

String SetCurrentA;
String SetCurrentB;
String SetCurrentC;
String SetCurrentD;
String SetCurrentE;
String SetCurrentF;
String SetCurrentG;
String SetCurrentH;
String SetCurrentI;
String SetCurrentJ;
String SetCurrentTest;

String StatusCharging;
String StatusChargingStopped;

//UCI WIFI
const char* ssid = "UCInet Mobile Access";
const char* password = "";

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
char rsp_readStat[50];

int buff_max = 50;


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
  int a,b,c,d,e,f,g,h,i,j,n = 0;
  int countbits1, countbits2, countbits3, countbits4, countbits5, countbits6 = 0;
  int countbitsA, countbitsB, countbitsC, countbitsD, countbitsE, countbitsF, countbitsG, countbitsH, countbitsI, countbitsJ = 0;
  int amtOfBits = 20;
  int current;
  
  /* Start Charge */
  
  for (int i = 0; i < StartCharge.length(); i++){
    if((char)payload[i] == StartCharge[i]){
      t++;
    }
  }

  if (t == StartCharge.length()){
    Serial.print("$FE*AF\r"); //what we write out
    delay(500);
    
    charge = true;

/* This is for checking all the bytes until you cant read anymore, amtOfBits is the amount of bits*/
    for (countbits1 = 0; (Serial.available() > 0); countbits1++) {
      rsp_charge[countbits1] = (char)Serial.read(); // Putting response into an array to be sent to cloud
      
    }

  }

/* Stop Charge */
  for (int i = 0; i < StopCharge.length(); i++){
    if((char)payload[i] == StopCharge[i]){
      r++;
    }
  }

  if (r == StopCharge.length()){
    Serial.print("$FS*BD\r");
    delay(500);
    
    notCharge = true;

    for (countbits2 = 0; (Serial.available() > 0); countbits2++) {
       rsp_notCharge[countbits2] = (char)Serial.read();

    }

   

  }

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

 

  }
/*********** Set Current Functions **********/


/* Set Current 6 */
  for (int i = 0; i < SetCurrent.length(); i++){
    if((char)payload[i] == SetCurrent[i]){
      n++;
    }
  }

   if (n == SetCurrent.length()){
    Serial.print("$SC 6\r"); // What do i put here???
    delay(500);

    setCurr = true;
    
    for (countbits4 = 0; (Serial.available() > 0) && countbits4 < amtOfBits; countbits4++) {
      rsp_setCurr[countbits4] = (char)Serial.read();

    }

  }

  /* Set Current 7 */
  for (int i = 0; i < SetCurrentA.length(); i++){
    if((char)payload[i] == SetCurrentA[i]){
      a++;
    }
  }

   if (a == SetCurrentA.length()){
    Serial.print("$SC 7\r"); // What do i put here???
    delay(500);

    setCurr = true;
    
    for (countbitsA = 0; (Serial.available() > 0) && countbitsA < amtOfBits; countbitsA++) {
      rsp_setCurr[countbitsA] = (char)Serial.read();

    }

  }
  


  /***** End of Set Current Funcs ******/

/* Read Status */
  for (int i = 0; i < ReadStatus.length(); i++){
    if((char)payload[i] == ReadStatus[i]){
      z++;
    }
  }


   if (z == ReadStatus.length()){
    Serial.print("$GS*BE\r");
    delay(500);
    
    readStat = true;
    
    for (countbits5 = 0; (Serial.available() > 0); countbits5++) {
      rsp_readStat[countbits5] = (char)Serial.read();
      
    }

 

  }


/* Level Check */
  for (int i = 0; i < LevelCheck.length(); i++){
    if((char)payload[i] == LevelCheck[i]){
      w++;
    }
  }


   if (w == LevelCheck.length()){
    Serial.print("$GS*BE\r");
    delay(500);
    
    levCheck = true;
    
    for (countbits6 = 0; (Serial.available() > 0); countbits6++) {
      rsp_levCheck[countbits6] = (char)Serial.read();
      
    }

 

  }
  
}

void reconnect() {
  while (!client.connected()) {
    //Serial.print("Attempting a conenection to MQTT...");

    if (client.connect("ESP8266Client", "nszhdozp", "TmWGEn_f3Ebp")) {
      //Serial.println("connected");
      client.publish("topic/EVSE/response", "publishing-yes"); // what are we publishing?
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

  StartCharge = "$FE*AF"; //what we get from mqtt
  StopCharge = "$FS*BD";
  ReadCurrent= "$GG*B2";


  SetCurrent = "$SC 6"; // ??? What are we expecting?
  SetCurrentA = "$SC 7";
//  SetCurrentB = "$SC 8";
//  SetCurrentC = "$SC 9";
//  SetCurrentD = "$SC 10";
//  SetCurrentE = "$SC 11";
//  SetCurrentF = "$SC 12";
//  SetCurrentG = "$SC 13";
//  SetCurrentH = "$SC 14";
//  SetCurrentI = "$SC 15";
//  SetCurrentJ = "$SC 16";
  

  
  ReadStatus = "$GS*BE";
  LevelCheck = "$GU*CO";
  
  
  charge = false;
  notCharge = false;
  readCurr = false;
  
  setCurr = false;
  readStat = false;
  levCheck = false;
  
  
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
  if (charge)
  {
      client.publish("topic/EVSE/response",rsp_charge); // Send command back up to cloud, it works but we getting weird response
      charge = false;
  }
  if (notCharge)
  {
      client.publish("topic/EVSE/response",rsp_notCharge);
      notCharge = false;
  }
  if (readCurr)
  {
      client.publish("topic/EVSE/response",rsp_readCurr);
      readCurr = false;
  }
  if (setCurr)
  {
      client.publish("topic/EVSE/response",rsp_setCurr);
      setCurr = false;
  }
  if (readStat)
  {
      client.publish("topic/EVSE/response",rsp_readStat);
      readStat = false;
  }
  if (levCheck)
  {
      client.publish("topic/EVSE/response",rsp_levCheck);
      levCheck = false;
  }


}
