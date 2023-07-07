//
//  PPBluetoothAppleDataAnalysis.h
//  PPBluetoothKit
//
//  Created by 彭思远 on 2023/4/3.
//

#import <Foundation/Foundation.h>
#import "PPBluetoothAdvDeviceModel.h"
#import "PPBluetoothScaleBaseModel.h"
#import "PPBluetooth180ADeviceModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface PPBluetoothAppleDataAnalysis : NSObject

+ (PPBluetoothScaleBaseModel *)analysis11LengthData:(NSData *)receiveData deviceModel:(PPBluetoothAdvDeviceModel *)device;


+ (PPBluetoothScaleBaseModel *)analysis18LengthData:(NSData *)receiveDate deviceAdvModel:(PPBluetoothAdvDeviceModel *)device andDevice180AModel:(PPBluetooth180ADeviceModel *)device180A;


@end

NS_ASSUME_NONNULL_END
