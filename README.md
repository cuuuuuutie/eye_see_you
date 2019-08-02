# Eye See You

[TOC]

## 1、项目简介

眼球矩阵随人脸移动



## 2、项目实现

​	项目基于arduino，processing，Kinect传感器等实现



### 2.1 硬件清单

| 元件            | 数量 | 说明                                                         |
| --------------- | ---- | ------------------------------------------------------------ |
| 亚克力板        | 1    |                                                              |
| 木质背板        | 1    |                                                              |
| 支撑木条        | 若干 |                                                              |
| 黏土眼球        | 121  |                                                              |
| 杜邦线          | 若干 |                                                              |
| 扎线带          | 若干 |                                                              |
| 热缩管          | 若干 |                                                              |
| 辉盛MG90S舵机   | 121  | [购买链接](https://item.taobao.com/item.htm?id=543402344365) |
| PCA9685         | 8    | [购买链接](https://item.taobao.com/item.htm?id=548923660446) |
| Arduino uno R3  | 1    |                                                              |
| Kinect V2感应器 | 1    |                                                              |
| MW 5V60A电源    | 2    |                                                              |
| MW 5V10A电源    | 1    |                                                              |



### 2.2 软件实现

- arduino控制实现

- processing控制实现

  - mac版
  - windows版

  ```
  说明：processing代码不同是因为平台使用不同的驱动以及不同函数库所致
  ```



> 软件实现参见src源码以及docs目录下源码解读



## 3、索引

```
.
├── README.md                                                   项目简介
├── docs                                                        说明文档
│   ├── FAQ.md                                                  常见问题
│   ├── annotation_arduino_code_.md                             arduino代码注释
│   ├── annotation_processing_facedetection.md                  processing代码注释
│   ├── environment.md                                          环境搭建
│   ├── hardware.md                                             硬件说明
│   └── imgs                                                    图片文件
└── src                                                         源码
    ├── arduino                                                   
    │   └── arduino_move
    │       └── arduino_move.ino                                arduino代码
    └── processing
        ├── mac_processing_facedetection
        │   └── mac_processing_facedetection.pde                processing mac版代码
        └── windows_processing_facedetection
            └── windows_processing_facedetection.pde            processing windows版代码
```



**文档索引直达：**

> [作品硬件](docs/hardware.md)
>
> [开发环境](docs/environment.md)
>
> [Arduino代码解读](docs/annotation_arduino_code_.md)
>
> [processing代码解读](docs/annotation_processing_facedetection.md)
>
> [常见问题](docs/FAQ.md)



## 4、相关文档

- [arduino与windows版processing代码链接](https://github.com/Echo-Ji/eye_move)



