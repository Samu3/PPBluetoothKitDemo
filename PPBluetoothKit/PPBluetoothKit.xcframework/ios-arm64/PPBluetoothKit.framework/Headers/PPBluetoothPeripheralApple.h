//
//  PPBluetoothPeripheralApple.h
//  PPBluetoothKit
//
//  Created by 彭思远 on 2023/3/31.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import "PPBluetoothAdvDeviceModel.h"
#import "PPBluetooth180ADeviceModel.h"
#import "PPBluetoothInterface.h"
#import "PPBluetoothDeviceSettingModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PPBluetoothPeripheralApple : NSObject

@property (nonatomic, weak) id<PPBluetoothServiceDelegate> serviceDelegate;

@property (nonatomic, weak) id<PPBluetoothCMDDataDelegate> cmdDelegate;

@property (nonatomic, weak) id<PPBluetoothScaleDataDelegate> scaleDataDelegate;

@property (nonatomic, strong) CBPeripheral *peripheral;

- (instancetype)initWithPeripheral:(CBPeripheral *)peripheral  andDevice:(PPBluetoothAdvDeviceModel *)device;

- (void)discoverDeviceInfoService:(void(^)(PPBluetooth180ADeviceModel *deviceModel))deviceInfoResponseHandler;

- (void)discoverFFF0Service;

- (void)fetchDeviceHistoryData;

- (void)deleteDeviceHistoryData;

- (void)syncDeviceTime;

- (void)syncDeviceSetting:(PPBluetoothDeviceSettingModel *)settingModel;

@end

NS_ASSUME_NONNULL_END
