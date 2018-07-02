/*
*    Created By Paolo Caraos
*    5/10/2018
*/

import mqtt.*;

MQTTClient client;

LED deviceStatusLED;  //status of the device
Button relayToggleButton; //toggles relay
Button sendCurrentButton; //requests current
Button changeDeviceButton; //changes MAC_ID and unsubscribes to topics for that device
Button updateButton; //updates all information
                    
TextContainer deviceMessageText;
TextContainer deviceMessageLabels;
TextBox deviceLabelTextBox;
TextBox currentTextBox;

String device_MAC_ID = "240AC4110540";
final String mqtt_user = "dkpljrty"; 
final String mqtt_pwd = "ZJDsxMVKRjoR";
final String mqtt_server = "m10.cloudmqtt.com";
final String mqtt_port = "17934";

final String SUBSC_TOPIC_PREFIX = "out/devices/";
final String PUBL_TOPIC_PREFIX = "in/devices/";

final String TOPIC_POWER_TOGGLE = "/1/OnOff/Toggle";
final String TOPIC_READ_LOAD_STATUS = "1/OnOff/OnOff";
final String TOPIC_READ_CURRENT = "/1/SimpleMeteringServer/RmsCurrent";
final String TOPIC_SEND_CURRENT = "/1/SimpleMeteringServer/RequestCurrent";
final String TOPIC_READ_POWER = "/1/SimpleMeteringServer/InstantaneousDemand";
final String TOPIC_READ_CHARGE_LEVEL = "/1/SimpleMeteringServer/SUPLevel";
final String TOPIC_READ_CHARGE_STATE = "/1/SimpleMeteringServer/ChargeState";
final String TOPIC_GEN_FAULT = "/1/SimpleMeteringServer/GeneralFault";
final String MQTT_TOPICS[] = {TOPIC_POWER_TOGGLE,
                         TOPIC_READ_LOAD_STATUS,
                         TOPIC_READ_CURRENT,
                         TOPIC_SEND_CURRENT,
                         TOPIC_READ_POWER,
                         TOPIC_READ_CHARGE_LEVEL,
                         TOPIC_READ_CHARGE_STATE,
                         TOPIC_GEN_FAULT};
PImage bg;

String power = "";
String deviceCurrent = "";
String chargeLevel = "";
String chargeState = "";
String genFault = "";
String requestCurrent ="";
String relayToggleResponse = "";
final String deviceResponseLabel = "Device Current: \n" +
                   "Device Power: \n" +
                   "Charge State: \n" +
                   "Charge Level: \n" +
                   "\nCurrent Request Response: \n" +
                   "General Fault: \n"+
                   "Relay Response: \n";
String deviceResponse = "";
void setup() 
{
  size(900,600);
  background(0);
  bg = loadImage("images/bg3.png");
  
  deviceMessageText = new TextContainer();
  deviceMessageText.setBounds(290, 180, 400, 250)
                 .setTextFont(createFont("Verdana", 15), 255)
                 .setOpacity(#33ECFF,128);
                 
  deviceMessageLabels = new TextContainer();
  deviceMessageLabels.setBounds(50, 180, 230, 250)
                 .setTextFont(createFont("Verdana", 15), 255)
                 .setOpacity(#FF2A00,128);
  
  deviceStatusLED = new LED();
  deviceStatusLED.setImage("images/on.png","images/off.png")
                 .setBounds(660, 160, 300, 300)
                 .setTextFont(createFont("Verdana", 20), 255)
                 .setText("Power"); 
                
  relayToggleButton = new Button()
                .setResetDelay(500);
  relayToggleButton.setImage("images/power1.png","images/power0.png")
                .setBounds(775, 100, 75, 75)
                .setTextFont(createFont("Verdana", 20), 255)
                .setText(" "); 
                
  updateButton = new Button()
                .setResetDelay(500);
  updateButton.setImage("images/button_OFF.png","images/button_ON.png")
                .setBounds(25,550, 450, 40)
                .setTextFont(createFont("Verdana", 15), 255)
                .setText("Update");  
                
  deviceLabelTextBox = new TextBox();  
  deviceLabelTextBox.setImage("images/textBox4.jpg","images/textBox3.jpg")
                 .setBounds(0, 0, width, 100)
                 .setTextFont(createFont("Verdana", 40), 255)
                 .setOpacity(255,90)
                 .setText(device_MAC_ID);
                
  changeDeviceButton = new Button()
                .setResetDelay(500);
  changeDeviceButton.setImage("images/button_OFF.png","images/button_ON.png")
                .setBounds(300,100, 300, 20)
                .setTextFont(createFont("Verdana", 10), 255)
                .setText("Change Device");
                 
  currentTextBox = new TextBox()
                .enableLetters(false)
                .enableDecimal(false);
  currentTextBox.setBounds(550, 550, 175, 40)
                .setTextFont(createFont("Verdana", 15), 0);
  sendCurrentButton = new Button()
                .setResetDelay(500);
  sendCurrentButton.setImage("images/button_OFF.png","images/button_ON.png")
                .setBounds(725, 550, 150, 40)
                .setTextFont(createFont("Verdana", 15), 255)
                .setText("Request Current");
  
  client = new MQTTClient(this);  
  client.connect("mqtt://"+mqtt_user+":"+mqtt_pwd+"@"+mqtt_server+":"+mqtt_port,"EVSE Processing Application");     
  for(String topic : MQTT_TOPICS)
    client.subscribe(SUBSC_TOPIC_PREFIX + device_MAC_ID + topic);   
}

void draw() 
{
  background(0);
  image(bg, 0, 0, width, height);
  currentTextBox.draw();
  deviceStatusLED.draw();
  deviceLabelTextBox.draw();
  relayToggleButton.draw();
  sendCurrentButton.draw();
  updateButton.draw();
  changeDeviceButton.draw();
  deviceMessageLabels.setText(deviceResponseLabel).draw();
  deviceMessageText.setText(deviceResponse).draw();
}

void mousePressed()
{
  currentTextBox.isPressed(mouseX, mouseY);
  deviceLabelTextBox.isPressed(mouseX, mouseY);
  
  if(relayToggleButton.isPressed(mouseX,mouseY))
  {
    client.publish(PUBL_TOPIC_PREFIX + device_MAC_ID + TOPIC_POWER_TOGGLE, "{\"method\":\"get\",\"params\":{}}");
  }
  else if(updateButton.isPressed(mouseX,mouseY))
  {
    client.publish(PUBL_TOPIC_PREFIX + device_MAC_ID + TOPIC_READ_LOAD_STATUS, "{\"method\":\"get\",\"params\":{}}");
    client.publish(PUBL_TOPIC_PREFIX + device_MAC_ID + TOPIC_READ_CURRENT, "{\"method\":\"get\",\"params\":{}}");
    client.publish(PUBL_TOPIC_PREFIX + device_MAC_ID + TOPIC_READ_POWER, "{\"method\":\"get\",\"params\":{}}");
    client.publish(PUBL_TOPIC_PREFIX + device_MAC_ID + TOPIC_READ_CHARGE_STATE, "{\"method\":\"get\",\"params\":{}}");
    client.publish(PUBL_TOPIC_PREFIX + device_MAC_ID + TOPIC_READ_CHARGE_LEVEL, "{\"method\":\"get\",\"params\":{}}");
    client.publish(PUBL_TOPIC_PREFIX + device_MAC_ID + TOPIC_GEN_FAULT, "{\"method\":\"get\",\"params\":{}}");
  }
  else if(sendCurrentButton.isPressed(mouseX, mouseY))
  {
    //Current value is clipped from 600-3000 (6 A to 30 A)
    try{
      int current = clip(Integer.parseInt(currentTextBox.getText()), 600, 3000);
      client.publish(PUBL_TOPIC_PREFIX + device_MAC_ID + TOPIC_SEND_CURRENT, 
                       "{\"method\":\"get\",\"params\":{\""+
                       current
                       +"\"}}"); 
      currentTextBox.setText(str(current));
    }
    catch(Exception e)
    {
       e.printStackTrace();
    }
  }
  else if(changeDeviceButton.isPressed(mouseX, mouseY))
  {
    //unsubscribe from previous device's topics
    for(String topic: MQTT_TOPICS)
      client.unsubscribe(SUBSC_TOPIC_PREFIX + device_MAC_ID + topic);
    device_MAC_ID = deviceLabelTextBox.getText();
    println("New device: " + device_MAC_ID);
    //subscribe to new ones
    for(String topic: MQTT_TOPICS)
      client.subscribe(SUBSC_TOPIC_PREFIX + device_MAC_ID + topic);
  }
  println("x = "+mouseX+" ::  y = "+ mouseY);
}

void keyPressed()
{
  currentTextBox.keyPressed(key, keyCode);
  deviceLabelTextBox.keyPressed(key, keyCode);
}

void messageReceived(String topic, byte[] payload)
{
  String msg = new String(payload);  
  if((SUBSC_TOPIC_PREFIX + device_MAC_ID + TOPIC_POWER_TOGGLE).equals(topic))
  {
    if(msg.equals("0"))
    {
      println(msg + " - Successful toggle.");
      deviceStatusLED.toggle();
      relayToggleResponse = "("+msg + ") - Successful toggle.";
    }
    else if(msg.equals("1"))
    {      
      relayToggleResponse = "("+msg + ") - Failed toggle. Inapporpriate\n charger state.";
    }
    else if(msg.equals("2"))
    {      
      relayToggleResponse = "("+msg + ") - Failed toggle due to\n safety check.";      
    }
    else
    {
      relayToggleResponse = "("+msg + ") - Unknown toggle reponse.";  
    }
  }
  else if((SUBSC_TOPIC_PREFIX + device_MAC_ID + TOPIC_READ_LOAD_STATUS).equals(topic))
  {
    if(msg.equals("1"))
    {
      deviceStatusLED.toggle(true);
    }
    else if(msg.equals("0"))
    {
      deviceStatusLED.toggle(false);
    }
    else
    {
      relayToggleResponse = "("+msg + ") - Unknown toggle reponse.";   
    }
  }
  else if((SUBSC_TOPIC_PREFIX + device_MAC_ID + TOPIC_READ_CURRENT).equals(topic))
  {
    deviceCurrent = " "+ msg + " A";
  }
  else if((SUBSC_TOPIC_PREFIX + device_MAC_ID + TOPIC_READ_POWER).equals(topic))
  {
    power = " "+ msg + " kW";
  }
  else if((SUBSC_TOPIC_PREFIX + device_MAC_ID + TOPIC_READ_CHARGE_STATE).equals(topic))
  {
    if(msg.equals("0"))
    {
      chargeState = "("+msg + ") - Not connected. Not charging.";
    }
    else if(msg.equals("1"))
    {
      chargeState = "("+msg + ") - Connected. Not charging. ";  
    }
    else if(msg.equals("2"))
    {
      chargeState = "("+msg + ") - Not connected. Not charging. ";  
    }
    else
    {
      chargeState = "("+msg + ") - Unknown charge state.";  
    }
  }
  else if((SUBSC_TOPIC_PREFIX + device_MAC_ID + TOPIC_READ_CHARGE_LEVEL).equals(topic))
  {
    if(msg.equals("0"))
    {
      chargeLevel = "("+msg + ") - FAIL: Error Detected.";
    }
    else if(msg.equals("1"))
    {
      chargeLevel = "("+msg + ") - L1 (Hot/Neutral) connected";  
    }
    else if(msg.equals("2"))
    {
      chargeLevel = "("+msg + ") - L2 (Phase 1/Phase 2) connected ";  
    }
    else
    {
      chargeLevel = "("+msg + ") - Unknown charge level.";  
    }
  }  
  else if((SUBSC_TOPIC_PREFIX + device_MAC_ID + TOPIC_GEN_FAULT).equals(topic))
  {
    if(msg.equals("0"))
    {
      genFault = "("+msg + ") - OK";
    }
    else if(msg.equals("1"))
    {
      genFault = "("+msg + ") - GFI Fault";  
    }
    else if(msg.equals("2"))
    {
      genFault = "("+msg + ") - Level Detection Fault";  
    }
    else if(msg.equals("3"))
    {
      genFault = "("+msg + ") - Stuck Relay";  
    }
    else if(msg.equals("4"))
    {
      genFault = "("+msg + ") - Diode Check Fail";  
    }
    else
    {
      genFault = "("+msg + ") - Unknown fault.";  
    }
  }
  else if((SUBSC_TOPIC_PREFIX + device_MAC_ID + TOPIC_SEND_CURRENT).equals(topic))
  {
    if(msg.equals("0"))
    {
      requestCurrent = "("+msg + ") - Valid value. ";
    }
    else if(msg.equals("1"))
    {
      requestCurrent = "("+msg + ") - Invalid value. Must be within 0 - 4000 A ";  
    }
    else
    {
      requestCurrent = "("+msg + ") - Unknown reponse.";  
    }
  }
  deviceResponse =  deviceCurrent + "\n" +
                    power + "\n" +
                    chargeState + "\n" +
                    chargeLevel + "\n\n" +
                    requestCurrent + "\n" +
                    genFault + "\n"+
                    relayToggleResponse + "\n";
  println("Payload: ", msg);
}

int clip(int x, int min, int max)
{
  return ((x) > (max))? max : ((x) < (min)) ? (min) : (x);
}
