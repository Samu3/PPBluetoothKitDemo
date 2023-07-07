//
//  PPBluetoothManager.h
//  PPBluetoothKit
//
//  Created by 彭思远 on 2023/4/7.
//

#import <Foundation/Foundation.h>
#import "PPBluetoothDefine.h"

NS_ASSUME_NONNULL_BEGIN

@interface PPBluetoothManager : NSObject


+ (BOOL)hasScaleFunc:(PPDeviceFuncType)funcType;

+ (BOOL)hasHistoryFunc:(PPDeviceFuncType)funcType;

+ (BOOL)hasSafeFunc:(PPDeviceFuncType)funcType;

+ (BOOL)hasBMDJFunc:(PPDeviceFuncType)funcType;

+ (BOOL)hasBabyFunc:(PPDeviceFuncType)funcType;

+ (BOOL)hasWifiFunc:(PPDeviceFuncType)funcType;

@end

NS_ASSUME_NONNULL_END
