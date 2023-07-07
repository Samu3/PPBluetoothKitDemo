# PPBluetoothKitDemo

 这是一个连接蓝牙秤的demo。

### PPBluetoothKit

目前版本为 v1.0

# 安装



### pod

 目前sdk还未上传到远程仓库

```
 pod 'PPBluetoothKit',:path=>'./PPBluetoothKit'
```

### 其它

 直接将SDK拖入工程

# 流程

~~~mermaid
graph TD
A[发现蓝牙设备] --> B[判断设备类型] --> C[广播秤 Banana]
B[判断设备类型] --> D[蓝牙秤 Apple,Coconut,Durian]
C[广播秤 Banana] --> E[scaleDataDelegate]
E[scaleDataDelegate] --> F[monitorProcessData] --> G[monitorLockData] --> H[PPBluetoothScaleBaseModel转换PPBodyFatModel]
D[蓝牙秤 Apple,Coconut,Durian] --> I[connect]
I[connect] --> J[discoverFFF0Service]
J[discoverFFF0Service] --> k[discoverFFF0ServiceSuccess]
k[discoverFFF0ServiceSuccess] --> E[scaleDataDelegate]

~~~

# 运行



### 引入头文件 

```objective-c
#import <PPBluetoothKit/PPBodyFatModel.h>
```



### 发现蓝牙设备

```
//发现设备实例
  lazy var scaleManager:PPBluetoothConnectManager = PPBluetoothConnectManager()

//蓝牙状态代理
self.scaleManager.updateStateDelegate = self;

//发现设备代理
self.scaleManager.surroundDeviceDelegate = self;

//判断蓝牙状态
func centralManagerDidUpdate(_ state: PPBluetoothState) {}

//发现设备回调
func centralManagerDidFoundSurroundDevice(_ device: PPBluetoothAdvDeviceModel!, andPeripheral peripheral: CBPeripheral!) {}
```



## 连接设备

连接设备需要根据**deviceConnectType**和**deviceProtocolType**判断设备类型，具体判断可见demo的ViewController scaleClick方法

```swift
//PPBluetoothSurroundDeviceDelegate
func centralManagerDidFoundSurroundDevice(_ device: PPBluetoothAdvDeviceModel!, andPeripheral peripheral: CBPeripheral!) {
  
//设备连接代理
self.scaleManager.connectDelegate = self

//连接设备
self.scaleManager.connect(peripheral, withDevice: device)

//初始化apple协议蓝牙类型实例
//PPBluetoothPeripheralApple //Apple类蓝牙协议
//PPBluetoothPeripheralBanana //Banana类蓝牙协议
//PPBluetoothPeripheralCoconut //Coconut类蓝牙协议
//PPBluetoothPeripheralDurian //Durian类蓝牙协议

var	appleDevice  : PPBluetoothPeripheralApple ? = PPBluetoothPeripheralApple(peripheral: peripheral, andDevice: device)
  
//发现特征服务代理 
appleDevice?.serviceDelegate = self

//手机发送ble指令代理
appleDevice?.cmdDelegate = self

}


```



### 秤重前的准备

```swift
//蓝牙连接秤需要连接后调用discoverFFF0Service()

//连接状态回调

//PPBluetoothConnectDelegate
func centralManagerDidConnect() {
  
	   appleDevice?.discoverFFF0Service()

}

//发现设备服务特征回调

//PPBluetoothServiceDelegate

  func discoverFFF0ServiceSuccess() {

	    appleDevice?.scaleDataDelegate = self

}

//广播秤不需要服务特征直接遵循PPBluetoothScaleDataDelegate协议
    appleDevice?.scaleDataDelegate = self
```



### 获取秤上数据

```objective-c
//PPBluetoothScaleDataDelegate

//过程数据

- (void)monitorProcessData:(PPBluetoothScaleBaseModel *)model;

//锁定数据

- (void)monitorLockData:(PPBluetoothScaleBaseModel *)model;
```



### 数据解析

PPBodyFatModel是所有数据解析的集合，通过PPBodyFatModel里的变量属性获取想要的结果

```swift
 let settingModel = PPBluetoothDeviceSettingModel()
        settingModel.isAthleteMode = isAthleteMode //运动员模式
        settingModel.isPregnantMode = false //孕妇模式
        settingModel.height = height //身高
        settingModel.age = age //年龄
        settingModel.gender = PPDeviceGenderType(rawValue: UInt(gender)) ?? .female //性别
        settingModel.unit = unit

let model:PPBluetoothScaleBaseModel! //通过PPBluetoothScaleDataDelegate代理获取PPBluetoothScaleBaseModel 解析成fatmodel

let fatModel = PPBodyFatModel(userModel: settingModel,
                                      deviceCalcuteType:selectDevice!.0.deviceCalcuteType,
                                      deviceMac:selectDevice!.0.deviceMac,
                              
weight:CGFloat(model.weight) / 100.0,
                              
heartRate: model.heartRate,
                              
andImpedance: model.impedance)
```

