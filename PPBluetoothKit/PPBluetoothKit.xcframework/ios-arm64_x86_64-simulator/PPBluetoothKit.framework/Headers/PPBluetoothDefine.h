//
//  PPBluetoothDefine.h
//  PPBluetoothKIt
//
//  Created by 彭思远 on 2023/3/27.
//

#ifndef PPBluetoothDefine_h
#define PPBluetoothDefine_h

#define kBLEAdvDataManufacturerData @"kCBAdvDataManufacturerData"
#define kBLEAdvDataLocalName @"kCBAdvDataLocalName"
#define kBLEAdvDataIsConnectable @"kCBAdvDataIsConnectable"

typedef NS_ENUM(NSInteger, PPBluetoothState) {
    PPBluetoothStateUnknown = 0,
    PPBluetoothStateResetting,
    PPBluetoothStateUnsupported,
    PPBluetoothStateUnauthorized,
    PPBluetoothStatePoweredOff,
    PPBluetoothStatePoweredOn,
} ;

// 设备类型
typedef NS_ENUM(NSUInteger, PPDeviceConnectType) {
    
    PPDeviceConnectTypeUnknow = 0, // 未知
    PPDeviceConnectTypeBleAdv, // 蓝牙广播秤
    PPDeviceConnectTypeBleConnect, // 蓝牙连接秤
};

// 设备类型
typedef NS_ENUM(NSUInteger, PPDeviceType) {
    
    PPDeviceTypeUnknow = 0, // 未知
    PPDeviceTypeCF, // 体脂秤
    PPDeviceTypeCE, //体重秤
    PPDeviceTypeCB, // 婴儿秤
    PPDeviceTypeCA, // 厨房秤
};

// 设备蓝牙协议版本
typedef NS_ENUM(NSUInteger, PPDeviceProtocolType) {
    
    PPDeviceProtocolTypeUnknow = 0, // 未知
    PPDeviceProtocolTypeV2, // 2.x版本
    PPDeviceProtocolTypeV3, // 3.x版本
    PPDeviceProtocolTypeTorre, // torre版本
};

// 测脂计算方式
typedef NS_ENUM(NSUInteger, PPDeviceCalcuteType){
    
    PPDeviceCalcuteTypeUnknow = 0, // 未知
    PPDeviceCalcuteTypeInScale, // 秤端计算
    PPDeviceCalcuteTypeDirect, // 直流算法
    PPDeviceCalcuteTypeAlternate, // 交流算法
    PPDeviceCalcuteTypeAlternate8, // 8电极交流算法
    PPDeviceCalcuteTypeAlternateNormal,   //默认计算库直接用合泰返回的体脂率
    PPDeviceCalcuteTypeNeedNot, // 无需计算
};

// 设备供电方式
typedef NS_ENUM(NSUInteger, PPDevicePowerType) {
    
    PPDevicePowerTypeUnknow = 0, // 未知
    PPDevicePowerTypeBattery, // 电池
    PPDevicePowerTypeSolar, // 太阳能
    PPDevicePowerTypeCharge, // 充电
};

// 设备功能类型
typedef NS_OPTIONS(NSUInteger, PPDeviceFuncType) {
    
    PPDeviceFuncTypeWeight = 1 << 0, // 称重
    PPDeviceFuncTypeFat = 1 << 1, // 测脂
    PPDeviceFuncTypeHeartRate = 1 << 2, // 心律
    PPDeviceFuncTypeHistory = 1 << 3, // 历史
    PPDeviceFuncTypeSafe = 1 << 4, // 孕妇
    PPDeviceFuncTypeBMDJ = 1 << 5, // 闭目单脚
    PPDeviceFuncTypeBaby = 1 << 6, // 抱婴模式
    PPDeviceFuncTypeWifi = 1 << 7, // wifi配网
};

// 设备精度
typedef NS_ENUM(NSUInteger, PPDeviceAccuracyType) {
    
    PPDeviceAccuracyTypeUnknow = 0, // 未知
    PPDeviceAccuracyTypePoint01, // 0.1KG精度
    PPDeviceAccuracyTypePoint005, // 0.05KG精度
    PPDeviceAccuracyTypePoint001, // 0.01KG精度
    PPDeviceAccuracyTypePointG, // 1G精度
    PPDeviceAccuracyTypePoint01G, // 0.1G精度
};

// 设备具有的单位
typedef NS_OPTIONS(NSUInteger, PPDeviceUnitType) {
    
    PPDeviceUnitTypeKG = 1 << 0,
    PPDeviceUnitTypeLB = 1 << 1,
    PPDeviceUnitTypeST = 1 << 2,
    PPDeviceUnitTypeJin = 1 << 3,
    PPDeviceUnitTypeSTLB = 1 << 4,
    PPDeviceUnitTypeG = 1 << 5,
    PPDeviceUnitTypeMLWater= 1 << 6,
    PPDeviceUnitTypeMLMilk = 1 << 7,
    PPDeviceUnitTypeOZ = 1 << 8,
    PPDeviceUnitTypeLBOZ = 1 << 9,
    PPDeviceUnitTypeFLOZ = 1 << 10,
    PPDeviceUnitTypeFLOZWater = 1 << 11,
    PPDeviceUnitTypeFLOZMilk = 1 << 12,
};

// 用户使用的单位
typedef NS_ENUM(NSUInteger, PPDeviceUnit) {
    
    PPUnitKG = 0,
    PPUnitLB = 1,
    PPUnitST = 2,
    PPUnitJin = 3,
    PPUnitSTLB = 4,
    PPUnitG = 5,
    PPUnitLBOZ = 6,
    PPUnitOZ = 7,
    PPUnitMLWater = 8,
    PPUnitMLMilk = 9,
    PPUnitFLOZWater = 10,
    PPUnitFLOZMilk = 11,
};

// 性别
typedef NS_ENUM(NSUInteger, PPDeviceGenderType) {
    
    PPDeviceGenderTypeFemale = 0, // 女性
    PPDeviceGenderTypeMale,   // 男性
};


// 配网错误状态状态
typedef NS_ENUM(NSUInteger, PPWIFIConfigState) {
    
    PPWIFIConfigStateUnknow,
    PPWIFIConfigStateStart,
    PPWIFIConfigStateStartSuccess,
    PPWIFIConfigStateStartFailed,
    PPWIFIConfigStateDomainSendStart,
    PPWIFIConfigStateDomainSendSuccess,
    PPWIFIConfigStateDomainSendFailed,
    PPWIFIConfigStateDomainSendCode,
    PPWIFIConfigStateDomainSendCodeSuccess,
    PPWIFIConfigStateDomainSendCodeFailed,
    PPWIFIConfigStateSSIDSendStart,
    PPWIFIConfigStateSSIDSendSuccess,
    PPWIFIConfigStateSSIDSendFailed,
    PPWIFIConfigStateSSIDSendCode,
    PPWIFIConfigStateSSIDSendCodeSuccess,
    PPWIFIConfigStateSSIDSendCodeFailed,
    PPWIFIConfigStatePasswordSendStart,
    PPWIFIConfigStatePasswordSendSuccess,
    PPWIFIConfigStatePasswordSendFailed,
    PPWIFIConfigStatePasswordSendCode,
    PPWIFIConfigStatePasswordSendCodeSuccess,
    PPWIFIConfigStatePasswordSendCodeFailed,
    PPWIFIConfigStateRegist,
    PPWIFIConfigStateRegistSuccess,
    PPWIFIConfigStateRegistFailedTimeOut,
    PPWIFIConfigStateRegistFailedConnect,
    PPWIFIConfigStateRegistFailedHTTP,
    PPWIFIConfigStateRegistFailedHTTPS,
    PPWIFIConfigStateRegistFailedRegist,
    PPWIFIConfigStateRegistFailedCommand,
    
};

#endif /* PPBluetoothDefine_h */
