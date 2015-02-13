/**
Modified by Epic Jefferson
 * oscP5sendreceive by andreas schlegel
 * example shows how to send and receive osc messages.
 * oscP5 website at http://www.sojamo.de/oscP5
 */
 
import oscP5.*;
import netP5.*;
  
OscP5 oscP5;
NetAddress myRemoteLocation;

int mx = 0;
int my = 0;
int phoneWidth = 0;
int phoneHeight = 0;

String ipaddress = "10.0.0.174";   //insert ip address here

void setup() {
  size(displayWidth,displayHeight);
  phoneWidth = displayWidth;
  phoneHeight = displayHeight;
  
  frameRate(25);
  /* start oscP5, listening for incoming messages at port 12000 */
  oscP5 = new OscP5(this,12000);
  
  /* myRemoteLocation is a NetAddress. a NetAddress takes 2 parameters,
   * an ip address and a port number. myRemoteLocation is used as parameter in
   * oscP5.send() when sending osc packets to another computer, device, 
   * application. usage see below. for testing purposes the listening port
   * and the port of the remote location address are the same, hence you will
   * send messages back to this sketch.
   */
   
  
  myRemoteLocation = new NetAddress(ipaddress,12000);
  OscMessage setup = new OscMessage("/setup");
  setup.add(phoneWidth);
  setup.add(phoneHeight);
  oscP5.send(setup,myRemoteLocation);
  
  strokeWeight(5);
}


void draw() {
//  background(0);  
}

void mouseDragged() {
  /* in the following different ways of creating osc messages are shown by example */
  OscMessage myMessage = new OscMessage("/test");
  
  mx = mouseX;
  my = mouseY;
  
  line(mouseX,mouseY,pmouseX,pmouseY);
  
//  myMessage.add(123); /* add an int to the osc message */
  myMessage.add(mx);
  myMessage.add(my);
  /* send the message */
  oscP5.send(myMessage, myRemoteLocation); 
}


/* incoming osc message are forwarded to the oscEvent method. */
void oscEvent(OscMessage theOscMessage) {
  /* print the address pattern and the typetag of the received OscMessage */
  print("### received an osc message.");
  print(" addrpattern: "+theOscMessage.addrPattern());
  println(" typetag: "+theOscMessage.typetag());
}
