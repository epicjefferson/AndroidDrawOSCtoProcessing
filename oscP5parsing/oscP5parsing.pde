/**
 * oscP5parsing by andreas schlegel
 * example shows how to parse incoming osc messages "by hand".
 * it is recommended to take a look at oscP5plug for an
 * alternative and more convenient way to parse messages.
 * oscP5 website at http://www.sojamo.de/oscP5
 */

import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress myRemoteLocation;

int firstValue = 0;
int secondValue = 0;
float cx,cy = 0;
int phoneWidth = 0;
int phoneHeight = 0;

void setup() {
  size(400,400);
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
//  myRemoteLocation = new NetAddress("127.0.0.1",12000);
}

void draw() {
  background(0);  
  fill(255);
  cx = map(firstValue,0,float(phoneWidth),0,width);
  cy = map(secondValue,0,float(phoneHeight),0,height);
  ellipse(cx,cy,50,50);
}


void mousePressed() {
  /* create a new osc message object */
//  OscMessage myMessage = new OscMessage("/test");
//  
//  myMessage.add(123); /* add an int to the osc message */
//  myMessage.add(12.34); /* add a float to the osc message */
//  myMessage.add("some text"); /* add a string to the osc message */

  /* send the message */
//  oscP5.send(myMessage, myRemoteLocation); 
}


void oscEvent(OscMessage theOscMessage) {
  /* check if theOscMessage has the address pattern we are looking for. */
  
  if(theOscMessage.checkAddrPattern("/test")==true) {
    /* check if the typetag is the right one. */
    if(theOscMessage.checkTypetag("ii")) {
      /* parse theOscMessage and extract the values from the osc message arguments. */
      firstValue = theOscMessage.get(0).intValue();  
      secondValue = theOscMessage.get(1).intValue();
//      String thirdValue = theOscMessage.get(2).stringValue();
//      print("### received an osc message /test with typetag ifs.");
//      fill(255);
//      ellipse(firstValue,secondValue,50,50);
      println(" values: "+firstValue+", "+secondValue);
      return;
    }  
  }
  if(theOscMessage.checkAddrPattern("/setup")==true){
    if(theOscMessage.checkTypetag("ii")){
      phoneWidth = theOscMessage.get(0).intValue();
      phoneHeight = theOscMessage.get(1).intValue();
      println("phoneWidth = " + phoneWidth + "phoneHeight = " + phoneHeight);
      return;
    }
  }
  println("### received an osc message. with address pattern "+theOscMessage.addrPattern());
}
