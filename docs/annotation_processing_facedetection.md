# Processing控制实现

[TOC]



## 1、控制流程

```flow
st=>start: Start
e=>end
op1=>operation: 设置画布大小
op2=>operation: 获取arduino串口名并建立连接
op3=>operation: 初始化Kinect
op4=>operation: 屏幕打印用户坐标信息并标识用户脸部


sub1=>subroutine: 获取用户脸部所在位置横坐标
sub2=>subroutine: 通过串口将位置信息发送到arduino
cond=>condition: 横坐标有效


st->op1->op2->op3->sub1->cond
cond(yes,down)->op4->sub2(left)->sub1
cond(no,right)->sub1

```



## 2、代码注释

```
代码路径
.
└── src                                                         源码
    └── processing
        ├── mac_processing_facedetection
        │   └── mac_processing_facedetection.pde                processing mac版代码
        └── windows_processing_facedetection
            └── windows_processing_facedetection.pde            processing windows版代码
```



### 2.1 设置画布大小

```
size(1024, 424);
```

### 2.2 获取arduino串口名并建立连接

**windows:**

```java
  // setup contact with arduino
  String portName = Serial.list()[0]; //change the 0 to a 1 or 2 etc. to match your port
  myPort = new Serial(this, portName, 9600);
  myPort.bufferUntil('\n');
```

**mac:**

这里需要注意确认串口对应的是arduino

```java
  // setup contact with arduino
  // ensure the port num of arduino
  String portName = Serial.list()[1]; //change the 0 to a 1 or 2 etc. to match your port
  myPort = new Serial(this, portName, 9600);
  println(portName);
  myPort.bufferUntil('\n');
```

### 2.3 初始化Kinect

**windows：**

```java
  // setup contact with Kinect
  kinect = new KinectPV2(this);
  //for face detection base on the infrared Img
  kinect.enableInfraredImg(true);
  kinect.enableFaceDetection(true);
  kinect.init();
```



**mac:**

- mac使用opencv识别人脸，因此需要初始化opencv

```java
  kinect2 = new Kinect2(this);
  kinect2.initVideo();
  //kinect2.initDepth();
  kinect2.initIR();
  // Start all data
  kinect2.initDevice();
  opencv = new OpenCV(this,512,424);
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);  
```



### 2.4 获取用户脸部所在位置横坐标

**windows:**

```java
public int getFaceMapInfraredCenter() {
  /*
  * 
  */
  ArrayList<FaceData> faceData =  kinect.getFaceData();
  for (int i = 0; i < faceData.size(); i++){
    FaceData faceD = faceData.get(i);
    if (faceD.isFaceTracked()) {
      KRectangle rectFace = faceD.getBoundingRectInfrared();
      return int(rectFace.getX() + rectFace.getWidth()/2);
    }
  }
  return -1;
}
```

**mac:**

```java

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
```



### 2.5 横坐标发送到arduino

```java

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
```

