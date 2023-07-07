//
//  PPBluetoothInterface.h
//  PPBluetoothKIt
//
//  Created by 彭思远 on 2023/3/27.
//

#ifndef PPBluetoothInterface_h
#define PPBluetoothInterface_h


#import "PPBluetoothDefine.h"

@class PPBluetoothAdvDeviceModel;
@class CBPeripheral;
@class PPBluetoothScaleBaseModel;
@class PPBluetooth180ADeviceModel;
@class PPBodyFatModel;
@class PPTorreWifiDeviceModel;

@protocol PPBluetoothUpdateStateDelegate <NSObject>

- (void)centralManagerDidUpdateState:(PPBluetoothState)state;

@end

@protocol PPBluetoothSurroundDeviceDelegate <NSObject>

- (void)centralManagerDidFoundSurroundDevice:(PPBluetoothAdvDeviceModel *)device andPeripheral:(CBPeripheral *)peripheral;
@end


@protocol PPBluetoothConnectDelegate <NSObject>

@optional

- (void)centralManagerDidConnect;

- (void)centralManagerDidFailToConnect:(NSError *)error;

- (void)centralManagerDidDisconnect;

@end


@protocol PPBluetoothServiceDelegate <NSObject>

- (void)discoverFFF0ServiceSuccess;


@end

@protocol PPBluetoothCMDDataDelegate <NSObject>

@optional

- (void)syncDeviceHistorySuccess;

- (void)syncDeviceTimeSuccess;

- (void)deleteDeviceHistoryDataSuccess;

- (void)deviceWillDisconnect;

@end


@protocol PPBluetoothScaleDataDelegate <NSObject>


- (void)monitorProcessData:(PPBluetoothScaleBaseModel *)model;

- (void)monitorLockData:(PPBluetoothScaleBaseModel *)model;

@optional

- (void)monitorHistoryData:(PPBluetoothScaleBaseModel *)model;

@end


@protocol PPBluetoothCalculateInScaleDataDelegate <NSObject>

- (void)monitorLockData:(PPBodyFatModel *)model;

@optional

- (void)monitorProcessData:(PPBluetoothScaleBaseModel *)model;

@end



#endif /* PPBluetoothInterface_h */
