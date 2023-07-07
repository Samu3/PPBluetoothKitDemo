//
//  PPBluetoothAdvDeviceModel.h
//  PPBluetoothKit
//
//  Created by 彭思远 on 2023/4/1.
//

#import <Foundation/Foundation.h>
#import "PPBluetoothDefine.h"

NS_ASSUME_NONNULL_BEGIN

@interface PPBluetoothAdvDeviceModel : NSObject

@property (nonatomic, copy) NSString *deviceName;
@property (nonatomic, copy) NSString *deviceMac;
@property (nonatomic, copy) NSString *sign;
@property (nonatomic, assign) PPDeviceConnectType deviceConnectType;
@property (nonatomic, assign) PPDeviceType deviceType;
@property (nonatomic, assign) PPDeviceProtocolType deviceProtocolType;
@property (nonatomic, assign) PPDeviceCalcuteType deviceCalcuteType;
@property (nonatomic, assign) PPDeviceAccuracyType deviceAccuracyType;
@property (nonatomic, assign) PPDevicePowerType devicePowerType;
@property (nonatomic, assign) PPDeviceFuncType deviceFuncType;
@property (nonatomic, assign) PPDeviceUnitType deviceUnitType;
@property (nonatomic, assign) NSInteger devicePower;
@property (nonatomic, assign) NSInteger rssi;

- (void)fillWithAdvertisementData:(NSDictionary<NSString *,id> *)advertisementData andRSSI:(NSNumber *)rssi;

@end

NS_ASSUME_NONNULL_END
