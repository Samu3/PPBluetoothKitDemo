//
//  PPScaleFilter.h
//  powercloudneutral
//
//  Created by 彭思远 on 2020/8/5.
//  Copyright © 2020 Peng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import "PPBluetoothDefine.h"

NS_ASSUME_NONNULL_BEGIN

@interface PPScaleFilter : NSObject

+ (BOOL)checkData:(NSData *)receiveData;

+ (NSArray *)allDeviceNameArr;

+ (NSArray<CBUUID *> *)filterServicesByUUID;

+ (NSString *)macAddressByCBAdvDataManufacturerData:(NSData *)advData andDeivceName:(NSString *)name;

+ (PPDeviceType)deviceTypeByCBAdvDataManufacturerData:(NSData *)advData andDeivceName:(NSString *)name;

+ (NSString *)signByAdvData:(NSData *)advData;

+ (PPDeviceProtocolType)deviceProtocolTypeByAdvData:(NSData *)advData andDeivceName:(NSString *)name;

+ (NSInteger)devicePowerByCBAdvDataManufacturerData:(NSData *)advData andDeivceName:(NSString *)name;

+ (PPDeviceCalcuteType)deviceCalcuteTypeByCBAdvDataManufacturerData:(NSData *)advData deviceType:(PPDeviceType)type andDeivceName:(NSString *)name;

+ (PPDeviceAccuracyType)deviceAccuracyTypeByCBAdvDataManufacturerData:(NSData *)advData deviceType:(PPDeviceType)deviceType andDeivceName:(NSString *)name;

+ (PPDevicePowerType)devicePowerTypeByCBAdvDataManufacturerData:(NSData *)advData andDeivceName:(NSString *)name;

+ (PPDeviceFuncType)deviceFuncByCBAdvDataManufacturerData:(NSData *)advData deviceType:(PPDeviceType)deviceType protocolType:(PPDeviceProtocolType)protocolType deviceConnectType:(PPDeviceConnectType)deviceConnectType andDeivceName:(NSString *)name;

+ (PPDeviceUnitType)deviceUnitByCBAdvDataManufacturerData:(NSData *)advData DeviceType:(PPDeviceType)type protocolType:(PPDeviceProtocolType)protocolType andDeivceName:(NSString *)deviceName;

@end

NS_ASSUME_NONNULL_END
