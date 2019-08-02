import gab.opencv.*;
import java.awt.Rectangle;
import processing.serial.*;

import org.openkinect.freenect.*;
import org.openkinect.freenect2.*;
import org.openkinect.processing.*;

Serial myPort;
Kinect2 kinect2;
OpenCV opencv;
Rectangle[] faces;

boolean foundUsers = false;
int locX = -1;
int pos = 0;
int lastpos = 0;
String val; // save the flag info
boolean firstContact = false; // since we're doing serial handshaking, we need to check if we heard frim the arduino
int threshold = 5;


void setup() {
  size(1024, 424, P2D);
  
  
  // setup contact with arduino
  // ensure the port num of arduino
  String portName = Serial.list()[1]; //change the 0 to a 1 or 2 etc. to match your port
  myPort = new Serial(this, portName, 9600);
  println(portName);
  myPort.bufferUntil('\n');
  

  kinect2 = new Kinect2(this);
  kinect2.initVideo();
  //kinect2.initDepth();
  kinect2.initIR();
  // Start all data
  kinect2.initDevice();
  
  opencv = new OpenCV(this,512,424);

  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);  
  //faces = opencv.detect();
}


void draw() {
  background(0);
  foundUsers = false;
  locX = getFaceMapInfraredCenter();
  
  image(opencv.getInput(), 0, 0);
  image(kinect2.getVideoImage(), kinect2.depthWidth, 0,512,424);
  
 
  fill(255);
  stroke(0, 255, 0);
  strokeWeight(3);
  
  if(locX != -1){
    foundUsers = true;
    text("Your location on axis X is "+locX, 50, 90);
    text("pos is "+int(locX/512.0*273 - 273/2 ),50,110);
    //println("Angel is "+int(locX/512.0*180));
    //myPort.write(int(locX/512.0*180));
  }else{
    //myPort.write(0);
  }
  text("Found User: "+foundUsers, 50, 70);
  
}

void serialEvent(Serial myPort){
  
  /*** Communicate with Arduino through the serial port
  * 
  */
  val = myPort.readStringUntil('\n');
  if(val != null) {
    val = trim(val);
    //println(val);
    
    if(firstContact == false) {
      if(val.equals("A")) {
        myPort.clear();
        firstContact = true;
        //myPort.write("A");
        println("contact");
      }
    }
    else {
       
       if(val.equals("B")) {
         if(locX != -1) { 
           
           
            pos = int((locX-20.0)/460*273);
            String s = String.valueOf(pos);
            if(Math.abs(pos - lastpos) > threshold) {
              
              println("Sending:   " +"$"+s+"$");
              myPort.write("$"+s+"$");
              lastpos = pos;
            }
          }else{
            myPort.write(lastpos);
            println("lastpos :"+ lastpos);
          }  
       }else{
         println("Recive: "+val);
       }
       myPort.write("A");
    }
  }
}

void mousePressed() {
  println(frameRate);
  ///saveFrame();
}

public int getFaceMapInfraredCenter() {
  /*** Get the face position within the detectable range
  * 
  */
  
  opencv.loadImage(kinect2.getIrImage());
  faces = opencv.detect();
  //println(faces.length);
  if (faces.length >0){
      rect(faces[0].x, faces[0].y, faces[0].width, faces[0].height);
      //println(faces[0]);
      return int(faces[0].x + faces[0].width/2 );
  }
  
  return -1;
  
}
