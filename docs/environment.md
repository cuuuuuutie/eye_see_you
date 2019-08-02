# 开发环境

[TOC]

## 1、Arduino开发环境

1. 下载对应版本的Arduino IDE

   下载链接：https://www.arduino.cc/en/Main/Software

2. 安装IDE



## 2、Processing开发环境

1. 下载对应版本的processing

   下载链接：https://processing.org/download/

2. 安装processing



## 3、Kinect开发环境

​	windows版和mac版本的Kinect的驱动不同，使用到的库也是不同的

### 3.1 windows版

**需求：**

-  A Kinect for Windows v2 Device (K4W2)
-  Install the [Kinect SDK v2](http://www.microsoft.com/en-us/kinectforwindows/default.aspx))
-  Computer with a dedicated USB 3.0 port and 64bits
-  For Windows 10 and 8.
-  [Processing 3.0](http://processing.org/)
-  Update your latest video card driver.
-  Install DirectX 11.



**安装：**

- Automatic: Install from Processing contributors library manager.
- Manual: Install [Kinect SDK v2](http://www.microsoft.com/en-us/kinectforwindows/default.aspx))
- Copy KinectPV2 folder to your processing libraries sketch folder.



安装完毕Kinect SDK，可以运行响应的检测程序进行检测，或者进入设备管理器查看Kinect识别是否正常；



### 3.2 mac版

#### 3.2.1 安装libfreenect2驱动

- 安装常用工具： wget, git, cmake, pkg-config,automake,autoconf

  ```
  brew install git wget cmake pkg-config automake autoconf
  ```

- 下载 libfreenect2 源码

  ```
  git clone https://github.com/OpenKinect/libfreenect2.git
  cd libfreenect2
  ```

- 安装依赖 : libusb, GLFW

  ```
  brew update
  brew install libusb
  brew install glfw3
  ```

- 安装 TurboJPEG (可选)

  ```
  brew install jpeg-turbo
  ```

- Install OpenNI2 (可选)

  ```
  brew tap brewsci/science
  brew install openni2
  export OPENNI2_REDIST=/usr/local/lib/ni2
  export OPENNI2_INCLUDE=/usr/local/include/ni2
  ```

- 编译安装

  ```
  mkdir build && cd build
  cmake ..
  make
  make install
  ```

- 运行测试程序: `./bin/Protonect`

- 测试 OpenNI2. `make install-openni2` (may need sudo), then run `NiViewer`. Environment variable `LIBFREENECT2_PIPELINE` can be set to `cl`, `cuda`, etc to specify the pipeline.



#### 3.2.2 安装processing库函数

- 安装 `Open Kinect for Processing 1.0` 
- 安装 `Opencv for Processing 0.5.4` 



## 3、参考文档

- [Arduino官网链接](https://www.arduino.cc/)
- [Processing官网链接](https://processing.org/)
- [Kinect官网链接](https://developer.microsoft.com/en-us/windows/kinect)
- [Kinect v2 Processing library for Windows](http://codigogenerativo.com/kinectpv2/)
- [Lib KinectPV2 examples](http://codigogenerativo.com/code/kinectpv2-k4w2-processing-library/)

- [libfreenect2 ](https://github.com/OpenKinect/libfreenect2)
- [Mac: Getting Started with Kinect and Processing](https://shiffman.net/p5/kinect/)



