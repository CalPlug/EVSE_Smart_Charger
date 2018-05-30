import processing.serial.*;
import mqtt.*;
MQTTClient client;

String subscribed_topic;
String published_topic;

//Image Definitions
PImage check_yes;   //image background
PImage check_no;   //image battery
PImage save_serial; //Save Image
PImage logo;   //image logo
PImage RGB_LCD;
PImage Mono_LCD;
PImage led_on;
PImage led_off;

//Font Definitions
PFont fontA; //Main font

//Element Definitions
boolean check_Ground = true;
boolean check_GFCI = true;
boolean check_Diode = true;
boolean check_Vent = true;
boolean check_Relay = true;
boolean save_val = false;
boolean LCD_is_RGB = true;
boolean tx_led = false;
boolean rx_led = false;
int icon_size = 50;
int current_X = 15;
int settings_X = 280;
int check_X = (settings_X + 190);
int check_Ground_Y = 140;
int check_GFCI_Y = (check_Ground_Y + icon_size);
int check_Diode_Y = (check_Ground_Y + (2*icon_size));
int check_Vent_Y = (check_Ground_Y + (3*icon_size));
int check_Relay_Y = (check_Ground_Y + (4*icon_size));
int save_X = check_X;
int save_Y = 470;
int tx_led_X = (check_X - 35);
int rx_led_X = (check_X + 25);
int led_Y = 415;
int led_size = 25;
int logo_X = 5;
int logo_Y = 480;
int logo_W = 180;
int logo_H = 75;
int state_X = 240;
int state_Y = 60;

int debounce = 500;
int press = 0;

//OpenEVSE Settings
int DEFAULT_SERVICE_LEVEL = 2; // 1=L1, 2=L2

// Default capacity in amps
int DEFAULT_CURRENT_CAPACITY_L1 = 12;
int DEFAULT_CURRENT_CAPACITY_L2 = 30;

// MIN/MAX allowable current in amps
int MIN_CURRENT_CAPACITY = 6;
int MAX_CURRENT_CAPACITY_L1 = 16; // J1772 Max for L1 on a 20A circuit
int MAX_CURRENT_CAPACITY_L2 = 30; // J1772 Max for L2

int EVSE_STATE = 3;
int amp = 30;
int svc = 2;

RectButton rect1, rect2, rect3, rect4, rect5, rect6;
boolean locked = false;  
color currentcolor;  

String lastInput = new String();
String currentInput = new String();
String ans = new String();
//String translation = new String();
//int transcount = 0;
//int anscount = 0; 
String[] br = new String[3];

void setup() 
{
  int x = 600;
  int y = 50;
  int size = 100;
  color buttoncolor = color(190, 190, 190);
  color highlight = color(153, 153, 153);
  rect1 = new RectButton(x, y, size, buttoncolor, highlight);
  x = 720;
  rect2 = new RectButton(x, y, size, buttoncolor, highlight);
  x = 600;
  y = 170;
  rect3 = new RectButton(x, y, size, buttoncolor, highlight);
  x = 720;
  rect4 = new RectButton(x, y, size, buttoncolor, highlight);
  x = 600;
  y = 290;
  rect5 = new RectButton(x, y, size, buttoncolor, highlight);
  x = 720;
  rect6 = new RectButton(x, y, size, buttoncolor, highlight);
  
  client = new MQTTClient(this);
  subscribed_topic = "topic/EVSE/response";
  published_topic = "topic/EVSE";
  client.connect("mqtt://nszhdozp:TmWGEn_f3Ebp@m10.cloudmqtt.com:12613", "processing");
  client.subscribe(subscribed_topic);
  client.publish(published_topic);
  
  //String portName = Serial.list()[0];
  //String portName = Serial.list()[1];
  //myPort = new Serial(this, portName, 115200);
  
  size(900,580);
  frameRate(30);
  
  //println(portName); //println(Serial.list());?


  check_yes = loadImage("check_yes.png");
  check_no = loadImage("check_no.png");
  logo = loadImage("OpenEVSE_logo.jpg");
  save_serial = loadImage("filesave.png");
  RGB_LCD = loadImage("RGB_LCD.jpg");
  Mono_LCD = loadImage("Mono_LCD.jpg");
  led_on = loadImage("led_on.png");
  led_off = loadImage("led_off.png");

  fontA = loadFont("CharterBT-Roman-48.vlw");
}




void update(int x, int y) {
   if(locked == false) {
      rect1.update();
      rect2.update();
      rect3.update();
      rect4.update();
      rect5.update();
      rect6.update();
   } else {
      locked = false;
   }

   String[] comp = new String[2];
   String templine = null;   
   
   if(mousePressed) {
      if(rect1.pressed()) { //start charge
          //String start_charge = "$FE*AF";
          client.publish(published_topic, "start_charge");
          //transcount = 1;
          //anscount = 1;
      } if(rect2.pressed()) { //stop charge
         //String stop_charge = "$FS*BD";
         client.publish(published_topic, "stop_charge");
         //transcount = 2;
         //anscount = 2;
      } else if(rect3.pressed()) { //set current //check templine
         comp[0] = "set_current";
         comp[1] = lastInput;
         templine = join(comp, " ");
         client.publish(published_topic, templine);
         //transcount = 3;
         //anscount = 3;
      } else if(rect4.pressed()) { //get current
         //String get_current = "$GG*B2";
         client.publish(published_topic, "get_current");
         //transcount = 4;
         //anscount = 4;
      } else if(rect5.pressed()) { //get level
         //String get_energy = "$GU*CO";
         client.publish(published_topic, "get_level");         
         //transcount = 5;
         //anscount = 5;
      } else if(rect6.pressed()) { //get status
         //String get_status ="$GS*BE";
         client.publish(published_topic, "get_status");
         //transcount = 6;
         //anscount = 6;
      }
      
      delay(1000);
      comp[0] = null;
      comp[1] = null;
      templine = null;
       
   }
      
}
 
class Button {
   int x, y;
   int size;
   color basecolor, highlightcolor;
   color currentcolor;
   boolean over = false;
   boolean pressed = false;
   void update() {
      if(over()) {
         currentcolor = highlightcolor;
      } else {
         currentcolor = basecolor;
      }
   }
   boolean pressed() {
      if(over) {
          locked = true;
          return true;
      } else {
          locked = false;
          return false;
      }
   }
   boolean over() {
      return true;
   }
   void display() {
   }
}
 
class RectButton extends Button {
   RectButton(int ix, int iy, int isize, color icolor, color ihighlight) {
      x = ix;
      y = iy;
      size = isize;
      basecolor = icolor;
      highlightcolor = ihighlight;
      currentcolor = basecolor;
   }
   boolean over() {
      if( overRect(x, y, size, size) ) {
         over = true;
         return true;
       } else {
         over = false;
         return false;
       }
    }
   void display() {
      stroke(255);
      fill(currentcolor);
      rect(x, y, size, size);
   }
}
 
boolean overRect(int x, int y, int width, int height) {
   if (mouseX >= x && mouseX <= x+width && mouseY >= y && mouseY <= y+height) {
      return true;
   } else {
      return false;
   }
}

void keyPressed()
{
 if(key == ENTER)
 {
   lastInput = currentInput;
   currentInput = "";
   println(lastInput);
 }
 else if(key == BACKSPACE && currentInput.length() > 0)
 {
   currentInput = currentInput.substring(0, currentInput.length() - 1);
 }
 else
 {
   if (key == '0') {currentInput = currentInput + key;}
   if (key == '1') {currentInput = currentInput + key;}
   if (key == '2') {currentInput = currentInput + key;}
   if (key == '3') {currentInput = currentInput + key;}
   if (key == '4') {currentInput = currentInput + key;}
   if (key == '5') {currentInput = currentInput + key;}
   if (key == '6') {currentInput = currentInput + key;}
   if (key == '7') {currentInput = currentInput + key;}
   if (key == '8') {currentInput = currentInput + key;}
   if (key == '9') {currentInput = currentInput + key;}
 }
}


void check_box (boolean checked, int check_y) {
  if (checked == true){
    image(check_yes, check_X, check_y, icon_size, icon_size);
  }
    else {
    image(check_no, check_X, check_y, icon_size, icon_size);
    }
}

void messageReceived(String topic, byte[] payload){
  ans = new String(payload);
  println(ans);

  //try {
  //}
  //}catch(Exception E) {}
  
}

void draw() 
{
background(255, 255, 255);
image(logo, logo_X, logo_Y, logo_W, logo_H);

 
fill(100,100,100);
textFont(fontA, 35);
text("EVSE State:", 30, 60);
textFont(fontA, 25);
fill(0);
text("L1 - Current", current_X, (check_Ground_Y + (icon_size / 2)));
text("L2 - Current", current_X, (check_Ground_Y + (icon_size / 2) + 75));


stroke(255);
update(mouseX, mouseY);
/*
if (anscount == 1) {
  if (ans.equals("$OK")) {
    ans = "$OK";
    translation = "Charge Started";
  } else if (ans.equals("$NK")) {
    ans = "$NK";
  } else {
    ans = "";
  }  
} else if (anscount == 2) {
  if (ans.equals("$OK")) {
    ans = "$OK";
    translation = "Charge Stopped";
  } else if (ans.equals("$NK")) {
    ans = "$NK";
  } else {
    ans = "";
  }  
} else if (anscount == 3) {
  
  br = split(ans, ' ');
  if (br[0].equals("$OK")) {
    ans = "$OK " + br[1];
    translation = "Current Set to "  + br[1];
  } else if (br[0].equals("$NK")) {
    ans = "$NK";
  } else {
    ans = "";
  }  
} else if (anscount == 4) {
  println("ans");
  println(ans);
  br = split(ans, ' ');
  if (br[0].equals("$OK")) {
      ans = "$OK " + br[1];
    translation = "Current is "  + br[1] + " mA";
  } else if (br[0].equals("$NK")) {
    ans = "$NK";
  } else {
    ans = "";
  }  
} else if (anscount == 5) {
  ans = "$OK 1 6";
  br = split(ans, ' ');
  if (br[0].equals("$OK")) {
    ans = "$OK " + br[1];
    translation = "System is Level "  + br[1];
    svc = Integer.parseInt(br[1]);
    amp = Integer.parseInt(br[2]);
    if (svc == 1) {DEFAULT_CURRENT_CAPACITY_L1 = Integer.parseInt(br[2]);}
    if (svc == 2) {DEFAULT_CURRENT_CAPACITY_L2 = Integer.parseInt(br[2]);}
  } else if (br[0].equals("$NK")) {
    ans = "$NK";
  } else {
    ans = "";
  }  
} else if (anscount == 6) {
  br = split(ans, " ");
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
} */

rect1.display();
rect2.display();
rect3.display();
rect4.display();
rect5.display();
rect6.display();

textFont(fontA, 17);
fill(0,0,0);

text("Start Charge",600,50);
text("Stop Charge",720,50);
text("Set Current",600,170);
text("Read Current",720,170);
text("Level Check",600,290);
text("Read Status",720,290);

textFont(fontA, 18);
text("Saved Input:",600,425);
text(lastInput,705,425);
text(" Curr. Input:",600,445);
text(currentInput,705,445);
text("    Response:",600,465);
text(" Translation:",600,485);
/*
if(ans.equals("$NK")) {
 if(transcount == 1) {
     translation = "Charge Start failure";
 } else if(transcount == 2) {
     translation = "Charge Stop failure";
 } else if(transcount == 3) {
     translation = "Current Set failure";
 } else if(transcount == 4) {
     translation = "Current Read failure";
 } else if(transcount == 5) {
     translation = "Level Check failure";
 } else if(transcount == 6) {
     translation = "Read Status failure";
 } else {
     translation = "System Error -- transcount"; 
 }
}*/

text(ans,705,465);
//text(translation,705,485);



text(DEFAULT_CURRENT_CAPACITY_L1, (current_X + 180), (check_Ground_Y + (icon_size / 2)));
text(DEFAULT_CURRENT_CAPACITY_L2, (current_X + 180), (check_Ground_Y + (icon_size / 2)+ 75));

textFont(fontA, 20);
fill(100,100,100);
text("Min - Max", current_X, (check_Ground_Y + (icon_size / 2) + 100));
text("Min - Max", current_X, (check_Ground_Y + (icon_size / 2) + 25));
text(MIN_CURRENT_CAPACITY, (current_X + 150), (check_Ground_Y + (icon_size / 2) + 25));
text("-", (current_X + 170), (check_Ground_Y + (icon_size / 2) + 25));
text(MAX_CURRENT_CAPACITY_L1, (current_X + 180), (check_Ground_Y + (icon_size / 2) + 25));
text(MIN_CURRENT_CAPACITY, (current_X + 150), (check_Ground_Y + (icon_size / 2) + 100));
text("-", (current_X + 170), (check_Ground_Y + (icon_size / 2) + 100));
text(MAX_CURRENT_CAPACITY_L2, (current_X + 180), (check_Ground_Y + (icon_size / 2) + 100));

fill(0);
textFont(fontA, 25);
text("Ground Check", settings_X, (check_Ground_Y + (icon_size / 2)));
text("GFCI", settings_X, (check_GFCI_Y + (icon_size / 2)));
text("Diode Check", settings_X, (check_Diode_Y + (icon_size / 2)));
text("Vent Required", settings_X, (check_Vent_Y + (icon_size / 2)));
text("Stuck Relay", settings_X, (check_Relay_Y + (icon_size / 2)));
text("Save Settings", settings_X, (save_Y + (icon_size / 2)));

textFont(fontA, 15);
text("OpenEVSE Configuration Tool v1.0", 240, 560);
text("TX", 410, 435);
text("RX", 470, 435);

//Check Boxes  
    
check_box (check_Ground, check_Ground_Y);  
check_box (check_GFCI, check_GFCI_Y);
check_box (check_Diode, check_Diode_Y);
check_box (check_Vent, check_Vent_Y);
check_box (check_Relay, check_Relay_Y);

image(save_serial, save_X, save_Y, icon_size, icon_size);
 
if (LCD_is_RGB == true){  
  image(RGB_LCD, (check_X - 40), (check_Ground_Y - 100), 100, 45); 
  }
if (LCD_is_RGB == false){  
  image(Mono_LCD, (check_X - 40), (check_Ground_Y - 100), 100, 45); 
  }
  
if (tx_led == true){  
  image(led_on, tx_led_X, led_Y, led_size, led_size);
  tx_led = false;
}
  else { 
  image(led_off, tx_led_X, led_Y, led_size, led_size);
  }

if (rx_led == true){  
  image(led_on, rx_led_X, led_Y, led_size, led_size);
  rx_led = false;
}
   else  {
  image(led_off, rx_led_X, led_Y, led_size, led_size);
  }


  
if (mouseX >= check_X && mouseX <= (check_X + icon_size) && mouseY >= check_Ground_Y && mouseY < (check_Ground_Y + icon_size) && mousePressed){
  if (check_Ground == true && millis() - press >= debounce){
    check_Ground = false ;
    press = millis();
    String ground_check = "$SG 0*0E";
    //myPort.write("$SG 0*0E\r");
    client.publish(subscribed_topic, ground_check);
    tx_led = true;
   } 
  else if (check_Ground == false && millis() - press >= debounce){
    check_Ground = true ;
    press = millis();
    String ground_check = "$SG 1*0F";
    //myPort.write("$SG 1*0F\r");
    client.publish(subscribed_topic, ground_check);
    tx_led = true;
  } 
 }
if (mouseX >= check_X && mouseX <= (check_X + icon_size) && mouseY >= check_GFCI_Y && mouseY < (check_GFCI_Y + icon_size) && mousePressed){
  if (check_GFCI == true && millis() - press >= debounce){
    check_GFCI = false ;
    press = millis();
    String gfci_check = "$SS 0*1A";
    //myPort.write("$SS 0*1A\r");
    client.publish(subscribed_topic, gfci_check);
    tx_led = true;
   } 
  else if (check_GFCI == false && millis() - press >= debounce){
    check_GFCI = true ;
    press = millis();
    String gfci_check = "$SS 1*1B";
    //myPort.write("$SS 1*1B\r"); 
    client.publish(subscribed_topic, gfci_check);
    tx_led = true;  
  } 
 } 
 if (mouseX >= check_X && mouseX <= (check_X + icon_size) && mouseY >= check_Diode_Y && mouseY < (check_Diode_Y + icon_size) && mousePressed){
  if (check_Diode == true && millis() - press >= debounce){
    check_Diode = false ;
    press = millis();
    String diode_check = "$SD 1*0C";
    //myPort.write("$SD 1*0C\r"); 
    client.publish(subscribed_topic, diode_check);
    tx_led = true;
   } 
  else if (check_Diode == false && millis() - press >= debounce){
    check_Diode = true ;
    press = millis();
    String diode_check = "$SD 0*0B";
    //myPort.write("$SD 0*0B\r");
    client.publish(subscribed_topic, diode_check);
    tx_led = true;
  } 
 }
 if (mouseX >= check_X && mouseX <= (check_X + icon_size) && mouseY >= check_Vent_Y && mouseY < (check_Vent_Y + icon_size) && mousePressed){
  if (check_Vent == true && millis() - press >= debounce){
    check_Vent= false ;
    String vent_check = "$SV 0*1D";
    //myPort.write("$SV 0*1D\r");
    client.publish(subscribed_topic, vent_check);
    press = millis();
    tx_led = true;
   } 
  else if (check_Vent == false && millis() - press >= debounce){
    check_Vent = true ;
    press = millis();
    String vent_check = "$SV 1*1E";
    //myPort.write("$SV 1*1E\r");
    client.publish(subscribed_topic, vent_check);
    tx_led = true;    
  } 
 } 
  if (mouseX >= check_X && mouseX <= (check_X + icon_size) && mouseY >= check_Relay_Y && mouseY < (check_Relay_Y + icon_size) && mousePressed){
  if (check_Relay == true && millis() - press >= debounce){
    check_Relay= false ;
    press = millis();
    String relay_check = "$SR 0*19";
    //myPort.write("$SR 0*19\r");
    client.publish(subscribed_topic, relay_check);
    tx_led = true;
   } 
  else if (check_Relay == false && millis() - press >= debounce){
    check_Relay = true ;
    press = millis();
    String relay_check = "$SR 1*1A";
    //myPort.write("$SR 1*1A\r"); 
    client.publish(subscribed_topic, relay_check);
    tx_led = true;  
  } 
 }
  if (mouseX >= save_X && mouseX <= (save_X + icon_size) && mouseY >= save_Y && mouseY < (save_Y + icon_size) && mousePressed){
    image(save_serial, (save_X + 2), (save_Y + 2), icon_size, icon_size);
    
    if (save_val  == false && millis() - press >= debounce){
      save_val = true;
      press = millis();
      tx_led = true;
  }
 }
 if (mouseX >= logo_X && mouseX <= (logo_X + logo_W) && mouseY >= logo_Y && mouseY < (logo_Y + logo_H) && mousePressed){
 link("https://code.google.com/p/open-evse/");
 }
if (mouseX >= (check_X - icon_size) && mouseX <= (check_X + icon_size) && mouseY >= 50 && mouseY < 100 && mousePressed){
  if (LCD_is_RGB == true && millis() - press >= debounce){
    LCD_is_RGB = false ;
    String lcd_check = "$S0 0*F7";
    //myPort.write("$S0 0*F7\r");
    client.publish(subscribed_topic, lcd_check);
    press = millis();
    tx_led = true;
   } 
  else if (LCD_is_RGB == false && millis() - press >= debounce){
    LCD_is_RGB = true ;
    String lcd_check = "$S0 1*F8";
    //myPort.write("$S0 1*F8\r");
    client.publish(subscribed_topic, lcd_check);
    press = millis(); 
    tx_led = true;   
  } 
 }


fill(45);
textFont(fontA, 36);
if (EVSE_STATE == 0){  
  text("Unknown", state_X, state_Y);
} else if (EVSE_STATE == 1){  
  text("Ready", state_X, state_Y);
  text("L", (state_X), (state_Y + icon_size));
  text(svc, (state_X + 20), (state_Y + icon_size));
  text("-", (state_X + 45), (state_Y + icon_size));
  text(amp, state_X + 60, (state_Y + icon_size));
  text("A", (state_X + 100), (state_Y + icon_size));
} else if (EVSE_STATE == 2){  
  text("Connected", state_X, state_Y);
  text("L", (state_X), (state_Y + icon_size));
  text(svc, (state_X + 20), (state_Y + icon_size));
  text("-", (state_X + 45), (state_Y + icon_size));
  text(amp, state_X + 60, (state_Y + icon_size));
  text("A", (state_X + 100), (state_Y + icon_size));
} else if (EVSE_STATE == 3){  
  text("Charging", state_X, state_Y);
  text("L", (state_X), (state_Y + icon_size));
  text(svc, (state_X + 20), (state_Y + icon_size));
  text("-", (state_X + 45), (state_Y + icon_size));
  text(amp, state_X + 60, (state_Y + icon_size));
  text("A", (state_X + 100), (state_Y + icon_size));
} else if (EVSE_STATE == 254){  
  text("Sleeping", state_X, state_Y); 
} else if (EVSE_STATE == 255){  
  text("Disabled", state_X, state_Y); 
} else {text("Error", state_X, state_Y);}

}    